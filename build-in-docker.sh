#!/bin/zsh


# By default run with docker, if podman is available use that
DOCKER_CMD=docker
EGOS_2000_CONTAINER_TAG=latest
# The name of the container image we run
EGOS_2000_CONTAINER=docker.io/tclab/ucore-env:$EGOS_2000_CONTAINER_TAG

RUN=${@:-bash}
# Run the given command in the container
# --rm to clean up the container afterwards. It doesn't contain any state.
#      Everything is in the local directory, since we're fully mounting it into
#      the container. All of the build results are in the Build/ subdirectory.
$DOCKER_CMD run \
  --rm \
  --name "egos-2000-dev" \
  -v $(pwd)/../:/home/user/egos-2000-dev \
  -v ~/.ccache:/ccache \
  -e "CCACHE_DIR=/ccache" \
  -e PATH=$PATH:/toolchain/bin \
  -e PATH=$PATH:/riscv64-acpi/dl/toolchain/bin \
  -e WORK_DIR=/home/user/egos-2000-dev \
  -e GCC5_RISCV64_PREFIX=riscv64-unknown-elf- \
  -it "$EGOS_2000_CONTAINER" \
    $RUN