################################################################################
#      This file is part of OpenELEC - http://www.openelec.tv
#      Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
#
#  This Program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 2, or (at your option)
#  any later version.
#
#  This Program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with OpenELEC.tv; see the file COPYING.  If not, write to
#  the Free Software Foundation, 51 Franklin Street, Suite 500, Boston, MA 02110, USA.
#  http://www.gnu.org/copyleft/gpl.html
################################################################################

PKG_NAME="genesis-plus-gx"
PKG_VERSION="a02ec87"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="Non-commercial"
PKG_SITE="https://github.com/libretro/Genesis-Plus-GX"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="An enhanced port of Genesis Plus for Gamecube/Wii"
PKG_LONGDESC="Genesis Plus GX is an open-source & portable Sega Mega Drive / Genesis emulator, now also emulating SG-1000, Master System, Game Gear and Sega/Mega CD hardware."

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  if [ "$ARCH" == "aarch64" ]; then
    make -f Makefile.libretro NO_OPTIMIZE=1 HAVE_CDROM=1
  else
    if [ "$ARCH" == "arm" ]; then
      CFLAGS="$CFLAGS -DALIGN_LONG"
    fi

    make -f Makefile.libretro HAVE_CDROM=1
  fi
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp genesis_plus_gx_libretro.so $INSTALL/usr/lib/libretro/genesis_plus_gx_libretro.so
}
