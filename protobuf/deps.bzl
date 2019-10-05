
BAZEL_SKYLIB_VERSION = "6741f733227dc68137512161a5ce6fcf283e3f58"  # 0.7.0

PROTOBUF_VERSION = "3.10.0"

RULES_PROTO_VERSION = "b0cc14be5da05168b01db282fe93bdf17aa2b9f4"

DEPS = {

    "com_google_protobuf": {
        "rule": "http_archive",
        "url": "https://github.com/protocolbuffers/protobuf/archive/v%s.zip" % PROTOBUF_VERSION,
        "strip_prefix": "protobuf-%s" % PROTOBUF_VERSION,
        "sha256": "33cba8b89be6c81b1461f1c438424f7a1aa4e31998dbe9ed6f8319583daac8c7",
    },

    "rules_proto": {
        "rule": "http_archive",
        "strip_prefix": "rules_proto-%s" % RULES_PROTO_VERSION,
        "url": "https://github.com/bazelbuild/rules_proto/archive/%s.tar.gz" % RULES_PROTO_VERSION,
        "sha256": "88b0a90433866b44bb4450d4c30bc5738b8c4f9c9ba14e9661deb123f56a833d",
    },

    "bazel_skylib": {
        "rule": "http_archive",
        "strip_prefix": "bazel-skylib-%s" % BAZEL_SKYLIB_VERSION,
        "url": "https://github.com/bazelbuild/bazel-skylib/archive/%s.tar.gz" % BAZEL_SKYLIB_VERSION,
        "sha256": "c202e39b4125ca41d95ebe494ae6a7a3674772df0dc4b1a51e82cf0e55ba78ed",
    },

    "zlib": {
        "rule": "http_archive",
        "build_file": "@com_google_protobuf//:third_party/zlib.BUILD",
        "sha256": "c3e5e9fdd5004dcb542feda5ee4f0ff0744628baf8ed2dd5d66f8ca1197cb1a1",
        "strip_prefix": "zlib-1.2.11",
        "url": "https://zlib.net/zlib-1.2.11.tar.gz",
    },


    # This binds the cc_binary "protoc" into
    # //external:protoc. Required by grpc++.
    "protoc": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

    # Bind the protobuf proto_lib into //external.  Required for
    # compiling the protoc_gen_grpc plugin
    "protocol_compiler": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc",
    },

    # grpc++ expects "//external:protobuf"
    "protobuf": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protobuf",
    },

    # grpc++ expects "//external:protobuf_clib"
    "protobuf_clib": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protoc_lib",
    },

    "protobuf_headers": {
        "rule": "bind",
        "actual": "@com_google_protobuf//:protobuf_headers",
    },
}
