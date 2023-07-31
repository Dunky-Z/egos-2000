#!/bin/zsh

DOCKER_CMD=docker
EGOS_2000_CONTAINER_TAG=latest
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
  -e EGOS=/home/user/egos-2000-dev \
  -it "$EGOS_2000_CONTAINER" \
   /bin/bash -c "echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers &&  su user && zsh"
#    /bin/bash -c "useradd -d /home/user user -M -s /bin/bash && echo 'user ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers && su user && zsh"

