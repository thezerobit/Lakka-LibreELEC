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

PKG_NAME="openlara"
PKG_VERSION="2c9e0a8"
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="BSD"
PKG_SITE="https://github.com/libretro/openlara"
PKG_GIT_URL="$PKG_SITE"
PKG_DEPENDS_TARGET="toolchain"
PKG_PRIORITY="optional"
PKG_SECTION="libretro"
PKG_SHORTDESC="Classic Tomb Raider open-source engine"
PKG_LONGDESC="Classic Tomb Raider open-source engine"

PKG_IS_ADDON="no"
PKG_AUTORECONF="no"

make_target() {
  LARA_GLES=""
  if [ "$OPENGLES_SUPPORT" = yes ]; then
    LARA_GLES="GLES=1"
  fi

  case $PROJECT in
    RPi|RPi2|Gamegirl|Slice|Slice3)
      CFLAGS+=" -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      CXXFLAGS+=" -I$SYSROOT_PREFIX/usr/include/interface/vcos/pthreads \
                  -I$SYSROOT_PREFIX/usr/include/interface/vmcs_host/linux"
      ;;
    imx6)
      CFLAGS+=" -DLINUX -DEGL_API_FB"
      CXXFLAGS+=" -DLINUX -DEGL_API_FB"
      ;;
  esac

  make -C src/platform/libretro $LARA_GLES
}

makeinstall_target() {
  mkdir -p $INSTALL/usr/lib/libretro
  cp src/platform/libretro/*_libretro.so $INSTALL/usr/lib/libretro/
}
