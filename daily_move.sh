#!/bin/bash
#    Copyright (c) 2017, Christian H. Meyer christian.h.meyer@t-online.de
#    All rights reserved.
#    
#    Redistribution and use in source and binary forms, with or without
#    modification, are permitted provided that the following conditions are met:
#
#      1. Redistributions of source code must retain the above copyright
#         notice, this list of conditions and the following disclaimer.
#
#      2. Redistributions in binary form must reproduce the above copyright
#         notice, this list of conditions and the following disclaimer in the
#         documentation and/or other materials provided with the distribution.
#
#      3. Software enabling users to interact remotely with this software or any part 
#         of it must reproduce the above copyright notice, this list of conditions 
#         and the following disclaimer in the documentation and/or other materials.
#
#      4. Neither the name of Christian H. Meyer nor the
#         names of its contributors may be used to endorse or promote products
#         derived from this software without specific prior written permission.
#    
#    THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
#    ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
#    WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
#    DISCLAIMED. IN NO EVENT SHALL CHRISTIAN H. MEYER BE LIABLE FOR ANY
#    DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
#    (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
#    LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
#    ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
#    (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
#    SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

tool=$0
src=$1
dest=$2

function move_files() {
  full_src=$(readlink -f $src)
  full_dest=$(readlink -f $dest)
  date=$(date -I)
  cd $src
  for file in *; do
    fileext=""
    basename=$file
    while [[ $basename = ?*.@(bz2|gz|lzma) ]]; do
      fileext=.${basename##?*.}$fileext
      basename=${basename%.*}
    done
    if [[ $basename = ?*.* ]]; then
      fileext=.${basename##?*.}$fileext
      basename=${basename%.*}
    fi
    mv $full_src/$file $full_dest/$basename-$date$fileext
  done
}

main() {
  if [[ -d $src && -d $dest ]]; then
    move_files
  else
    echo "Usage: $tool src dest"
    echo
    echo "Move files from src to dest and add the current date between filename and suffix"
  fi

}

main
