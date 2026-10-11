#!/usr/bin/env bash

export GOCACHE="$PWD/.cache"
export CGO_ENABLED=1
export GO111MODULE=on
export CGO_LDFLAGS="-L${SRC_DIR}/gominibwa/minibwa -L${PREFIX}/lib"
export CFLAGS="${CFLAGS} -g -Wall -Wno-unused-function -O3"
export CPPFLAGS="${CPPFLAGS} -I${PREFIX}/include"
export LDFLAGS="${LDFLAGS} -L${PREFIX}/lib"
export MACOSX_DEPLOYMENT_TARGET=11.0

mkdir -p "${GOCACHE}"
mkdir -p "${PREFIX}/bin"

# build minibwa
make CC="${CC}" CFLAGS="${CFLAGS}" CPPFLAGS="${CPPFLAGS}" LDFLAGS="${LDFLAGS}" -j"${CPU_COUNT}" -C gominibwa/minibwa libminibwa.a minibwa

# build arachne
go build -ldflags "-X arachne/aligner.VERSION=${PKG_VERSION} -s -w" -o $PREFIX/bin/arachne

go-licenses save . --save_path="${SRC_DIR}/library_licenses"
