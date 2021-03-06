BAZEL := "bazel"

STARTUP_FLAGS += --output_base="$HOME/.cache/bazel"
STARTUP_FLAGS += --host_jvm_args=-Xmx500m
STARTUP_FLAGS += --host_jvm_args=-Xms500m
STARTUP_FLAGS += --batch

BUILD_FLAGS += --verbose_failures
BUILD_FLAGS += --spawn_strategy=standalone
BUILD_FLAGS += --genrule_strategy=standalone
BUILD_FLAGS += --local_resources=400,2,1.0
BUILD_FLAGS += --worker_verbose
BUILD_FLAGS += --strategy=Javac=worker
BUILD_FLAGS += --strategy=Closure=worker
#BUILD_FLAGS += --experimental_repository_cache="$HOME/.bazel_repository_cache"

TESTFLAGS += $(BUILDFLAGS)
TEST_FLAGS += --test_output=errors
TEST_FLAGS += --test_strategy=standalone
TEST_FLAGS += --copt -DGRPC_BAZEL_BUILD # workaorund for building on mac https://github.com/grpc/grpc/pull/13929

BAZEL_BUILD := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) build $(BUILDFLAGS)
BAZEL_TEST := $(BAZEL) $(STARTFLAGS) $(BAZELFLAGS) test $(TEST_FLAGS)
#BAZEL_BUILD := $(BAZEL) build
#BAZEL_TEST := $(BAZEL) test

test_gogo:
	cd tests/gogo && $(BAZEL_TEST) :gogo_test

all: build test

build: external_proto_library_build
	$(BAZEL_BUILD) \
	//examples/extra_args:person_tar \
	//examples/helloworld/go/client \
	//examples/helloworld/go/server \
	//tests/generated_proto_file:* \
	//tests/custom_go_importpath:* \

test: test_gogo
	$(BAZEL_TEST) \
	//examples/wkt/go:wkt_test \

external_proto_library_build:
	cd tests/external_proto_library && $(BAZEL_BUILD) :go_gapi

fmt:
	buildifier WORKSPACE
	buildifier BUILD
	find examples/ -name BUILD | xargs buildifier
	find go/ -name BUILD | xargs buildifier
	find gogo/ -name BUILD | xargs buildifier
	find protobuf/ -name BUILD | xargs buildifier
	find tests/ -name BUILD | xargs buildifier
