
BAZEL_SKYLIB_VERSION = "6741f733227dc68137512161a5ce6fcf283e3f58"  # 0.7.0

PROTOBUF_VERSION = "3.10.0"

RULES_PROTO_VERSION = "b0cc14be5da05168b01db282fe93bdf17aa2b9f4"

RULES_PYTHON_VERSION = "4b84ad270387a7c439ebdccfd530e2339601ef27"

RULES_JAVA_VERSION = "981f06c3d2bd10225e85209904090eb7b5fb26bd"

RULES_CC_VERSION = "b7fe9697c0c76ab2fd431a891dbb9a6a32ed7c3e"

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

    "rules_python": {
        "rule": "http_archive",
        "strip_prefix": "rules_python-%s" % RULES_PYTHON_VERSION,
        "url": "https://github.com/bazelbuild/rules_python/archive/%s.tar.gz" % RULES_PYTHON_VERSION,
        "sha256": "e5470e92a18aa51830db99a4d9c492cc613761d5bdb7131c04bd92b9834380f6",
    },

    "rules_java": {
        "rule": "http_archive",
        "strip_prefix": "rules_java-%s" % RULES_JAVA_VERSION,
        "url": "https://github.com/bazelbuild/rules_java/archive/%s.tar.gz" % RULES_JAVA_VERSION,
        "sha256": "f5a3e477e579231fca27bf202bb0e8fbe4fc6339d63b38ccb87c2760b533d1c3",
    },

    "rules_cc": {
        "rule": "http_archive",
        "strip_prefix": "rules_cc-%s" % RULES_CC_VERSION,
        "url": "https://github.com/bazelbuild/rules_cc/archive/%s.tar.gz" % RULES_CC_VERSION,
        "sha256": "29daf0159f0cf552fcff60b49d8bcd4f08f08506d2da6e41b07058ec50cfeaec",
    },

    "bazel_skylib": {
        "rule": "http_archive",
        "strip_prefix": "bazel-skylib-%s" % BAZEL_SKYLIB_VERSION,
        "url": "https://github.com/bazelbuild/bazel-skylib/archive/%s.tar.gz" % BAZEL_SKYLIB_VERSION,
        "sha256": "c202e39b4125ca41d95ebe494ae6a7a3674772df0dc4b1a51e82cf0e55ba78ed",
    },

    # C-library for zlib
    "com_github_madler_zlib": {
        "rule": "http_archive",
        "url": "https://github.com/madler/zlib/archive/cacf7f1d4e3d44d871b605da3b647f07d718623f.zip", #v1.2.11
        "sha256": "1cce3828ec2ba80ff8a4cac0ab5aa03756026517154c4b450e617ede751d41bd",
        "strip_prefix": "zlib-cacf7f1d4e3d44d871b605da3b647f07d718623f",
        "build_file": str(Label("//protobuf:build_file/com_github_madler_zlib.BUILD")),
    },

    # grpc++ //external:zlib
    "zlib": {
        "rule": "bind",
        "actual": "@com_github_madler_zlib//:zlib",
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
