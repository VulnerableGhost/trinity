#!/bin/sh

hdr()
{
 echo "#pragma once" > version.h
 echo "/* This file is auto-generated */" >> version.h
}


if [ -f version.h ]; then
OLD=$(grep VERSION version.h | head -n1 | sed 's/"//g' | awk '{ print $3 }')
else
OLD=""
fi

DEVEL=$(grep VERSION Makefile | head -n1 | grep pre | wc -l)

# if we don't have git installed, or we're a release version
# get the version number from the makefile.
makefilever()
{
VER=$(grep VERSION= Makefile| head -n1| sed 's/=/ /' | sed 's/"//g' | awk '{print $2}')
  if [ "$OLD" != "$VER" ]; then
    hdr
    echo -n "#define " >> version.h
    echo $VER >> version.h
  fi
}

if [ "$DEVEL" == "1" ]; then
  if [ ! -f /usr/bin/git ]; then
   makefilever
  else
    VER=$(git describe --always)
    if [ "$OLD" != "$VER" ]; then
      hdr
      echo "#define VERSION \""$VER\" >> version.h
    fi
  fi
else
  makefilever
fi