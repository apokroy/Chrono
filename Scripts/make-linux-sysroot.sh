#!/bin/sh
# Packs the minimal set of Linux x86_64 system files that the Delphi Linux64
# linker needs (C runtime start files, libc/libm/libdl/libpthread/librt/libz
# and libgcc) into a tar archive, preserving their absolute paths.
#
# Run it inside a Linux system (or WSL distribution) with libc6-dev and gcc
# installed; Build.ps1 does this automatically. Symlinks are dereferenced (-h)
# so the archive can be extracted on Windows.
#
# Usage: make-linux-sysroot.sh <output.tar>
set -e
out="$1"
if [ -z "$out" ]; then
  echo "usage: $0 <output.tar>" >&2
  exit 2
fi
if [ ! -f /usr/lib/x86_64-linux-gnu/crt1.o ]; then
  echo "libc6-dev is not installed (sudo apt install libc6-dev gcc)" >&2
  exit 1
fi
gccdir=$(ls -d /usr/lib/gcc/x86_64-linux-gnu/* | sort -V | tail -1)

cd /
files=""
for d in usr/lib/x86_64-linux-gnu lib/x86_64-linux-gnu; do
  for p in 'libc.so*' libc_nonshared.a 'libm.so*' 'libm-*.a' 'libmvec.so*' 'libdl.so*' libdl.a \
           'libpthread.so*' libpthread.a 'librt.so*' librt.a 'libz.so*' 'libgcc_s.so*' \
           'ld-linux-x86-64.so*' crt1.o crti.o crtn.o Scrt1.o; do
    for f in $d/$p; do
      [ -e "$f" ] && files="$files $f"
    done
  done
done
for f in "${gccdir#/}"/crt*.o "${gccdir#/}"/libgcc*; do
  [ -e "$f" ] && files="$files $f"
done

tar -chf "$out" $files lib64/ld-linux-x86-64.so.2
echo "Linux sysroot packed from $(. /etc/os-release && echo "$PRETTY_NAME"), gcc $(basename "$gccdir")"
