#!/bin/sh

set -e

PATH=$PATH:./tools

rm -rf Sources/XCMetricsProto
mkdir Sources/XCMetricsProto

rm -rf Sources/PublishBuildEventProto
mkdir Sources/PublishBuildEventProto

# Only works on macOS for now.
# TODO: add support for Linux and remove checked-in files from repo.
./tools/bin/protoc proto/xcmetrics/**/*.proto \
    --swift_out=Sources/XCMetricsProto/ \
    --swift_opt=Visibility=Public \
    --grpc-swift_opt=Visibility=Public \
    --grpc-swift_out=Sources/XCMetricsProto/

# gen BES client
./tools/bin/protodep up -f
./tools/bin/protoc managed_proto/google/devtools/build/v1/*.proto \
    -I=managed_proto/ \
    --swift_out=Sources/PublishBuildEventProto/ \
    --swift_opt=Visibility=Public \
    --grpc-swift_opt=Visibility=Public \
    --grpc-swift_out=Sources/PublishBuildEventProto/