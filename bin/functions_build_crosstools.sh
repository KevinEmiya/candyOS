#!/bin/bash

generate_custom cross_autogen_env prepare_cross_autogen \
    '--depends=cross_autoconf  cross_automake  cross_pkgconfig  cross_gettext  cross_libtool cross_intltool'
    
prepare_cross_autogen()
{
    local do_nothing;
}

##############################
# 编译交叉编译使用的 autoconf
AUTOCONFFILE=autoconf-2.69
generate_script  cross_autoconf     $AUTOCONFFILE     \
    '--config=--prefix=$SDKDIR/usr --host=$MY_TARGET --disable-static'       \
    '--deploy-sdk=/'

generate_script  native_autoconf     $AUTOCONFFILE     \
    '--config=--prefix=/usr'       \
    '--deploy-dev=/'
    
##############################
# 编译本机运行的 automake
AUTOMAKEFILE=automake-1.15
generate_script  cross_automake     $AUTOMAKEFILE     \
    '--config=--prefix=$SDKDIR/usr --disable-static'       \
    '--deploy-sdk=/'
    
generate_script  native_automake     $AUTOMAKEFILE     \
    '--config=--prefix=/usr --disable-static'       \
    '--deploy-dev=/'

##############################
# 编译 libtool
# build_native_libtool()
LIBTOOLFILE=libtool-2.4.6
generate_script  native_libtool     $LIBTOOLFILE     \
    --build-native                  \
    '--config=--prefix=$DEVDIR/usr --disable-static'       \
    '--deploy-dev=/'
    
# --debug --show-usage 
generate_script  cross_libtool     $LIBTOOLFILE     \
    '--config=--prefix=$SDKDIR/usr --host=$MY_TARGET --disable-static'       \
    '--deploy-sdk=/'

##############################
# 编译 intltool-0.51.0
INTLTOOL=intltool-0.51.0
generate_script  native_intltool     $INTLTOOL     \
    '--config=--prefix=/usr --disable-static'       \
    '--deploy-dev=/'
    
generate_script  cross_intltool     $INTLTOOL     \
    '--config=--prefix=/usr --host=$MY_TARGET --disable-static'       \
    '--deploy-sdk=/'
#NATIVE_PREREQUIRST+=" libexpat1-dev libncurses5-dev"        # 编译native gettext需要expat和ncurses

############################################
# 编译 expat
#    build_native_expat()
EXPATFILES=expat-2.2.5
generate_script  native_expat     $EXPATFILES     \
    --build-native                  \
    '--config=--prefix=$DEVDIR/usr --disable-static'       \
    '--deploy-dev=/'

generate_script  expat     $EXPATFILES     \
    '--config=--prefix=/usr --sysconfdir=/etc --host=$MY_TARGET --disable-static'       \
    '--deploy-sdk=/usr/include /usr/lib'    \
    '--deploy-rootfs=/usr/bin /usr/lib -/usr/lib/*.la -/usr/lib/pkgconfig'
    
##############################
# 编译 ncurses
#    build_native_ncurses
NCURSESFILE=ncurses-6.0
generate_script  native_ncurses     $NCURSESFILE     \
    --build-native                 \
    --make-before-install   \
    '--config=--prefix=$DEVDIR/usr --with-shared --without-normal --without-debug --enable-relocatable --without-ada --without-manpages --without-tests'       \
    '--deploy-dev=/'

generate_script  ncurses     $NCURSESFILE     \
    --make-before-install   \
    '--config=--host=$MY_TARGET --prefix=/usr --without-ada --without-manpages --without-tests --without-progs'       \
    '--deploy-sdk=/'

generate_script  ncursesw     $NCURSESFILE     \
    --make-before-install   \
    '--config=--host=$MY_TARGET --prefix=/usr --enable-widec --without-ada --without-manpages --without-tests --without-progs'       \
    '--deploy-sdk=/'

##############################
# 编译 gettext-0.19.8
GETTEXT=gettext-0.19.8
generate_script  cross_gettext     $GETTEXT     \
    --build-native                 \
    '--config=--prefix=$DEVDIR/usr --disable-static --without-emacs --without-git --disable-acl --disable-openmp --disable-java'       \
    '--depends=native_expat native_ncurses' \
    '--deploy-dev=/'    \
    '--deploy-sdk=/usr/bin /usr/lib/gettext'

generate_script  native_gettext     $GETTEXT     \
    --build-native                 \
    '--config=--prefix=$DEVDIR/usr --disable-static --without-emacs --without-git --disable-acl --disable-openmp --disable-java'       \
    '--depends=native_expat native_ncurses' \
    '--deploy-dev=/' \
    '--deploy-sdk=/usr/bin /usr/lib/gettext'

##############################
# 编译 Python
PYTHON27FILE=Python-2.7.14
generate_script     cross_python   $PYTHON27FILE                    \
    --build-native                  \
    '--depends=native_expat native_gettext'                         \
    '--config=--prefix=/usr --with-system-expat --without-pydebug ' \
    '--deploy-sdk=/usr/bin /usr/lib -/usr/lib/*.a'  
    
generate_script     native_python   $PYTHON27FILE                    \
    --build-native                                                  \
    '--depends=native_expat native_gettext'                         \
    '--config=--prefix=$DEVDIR/usr --with-system-expat --without-pydebug '                                 \
    '--deploy-dev=/' 