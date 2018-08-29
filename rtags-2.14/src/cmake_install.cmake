# Install script for directory: /Users/macbook/.emacs.d/rtags-2.14/src

# Set the install prefix
if(NOT DEFINED CMAKE_INSTALL_PREFIX)
  set(CMAKE_INSTALL_PREFIX "/usr/local")
endif()
string(REGEX REPLACE "/$" "" CMAKE_INSTALL_PREFIX "${CMAKE_INSTALL_PREFIX}")

# Set the install configuration name.
if(NOT DEFINED CMAKE_INSTALL_CONFIG_NAME)
  if(BUILD_TYPE)
    string(REGEX REPLACE "^[^A-Za-z0-9_]+" ""
           CMAKE_INSTALL_CONFIG_NAME "${BUILD_TYPE}")
  else()
    set(CMAKE_INSTALL_CONFIG_NAME "Release")
  endif()
  message(STATUS "Install configuration: \"${CMAKE_INSTALL_CONFIG_NAME}\"")
endif()

# Set the component getting installed.
if(NOT CMAKE_INSTALL_COMPONENT)
  if(COMPONENT)
    message(STATUS "Install component: \"${COMPONENT}\"")
    set(CMAKE_INSTALL_COMPONENT "${COMPONENT}")
  else()
    set(CMAKE_INSTALL_COMPONENT)
  endif()
endif()

# Is this installation the result of a crosscompile?
if(NOT DEFINED CMAKE_CROSSCOMPILING)
  set(CMAKE_CROSSCOMPILING "FALSE")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  message("Installing rtags...")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/macbook/.emacs.d/rtags-2.14/bin/rdm")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    execute_process(COMMAND /usr/bin/install_name_tool
      -add_rpath "/usr/local/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rdm")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/macbook/.emacs.d/rtags-2.14/bin/rc")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    execute_process(COMMAND /usr/bin/install_name_tool
      -add_rpath "/usr/local/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rc")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xrtagsx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE EXECUTABLE FILES "/Users/macbook/.emacs.d/rtags-2.14/bin/rp")
  if(EXISTS "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp" AND
     NOT IS_SYMLINK "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    execute_process(COMMAND /usr/bin/install_name_tool
      -add_rpath "/usr/local/lib"
      "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    if(CMAKE_INSTALL_DO_STRIP)
      execute_process(COMMAND "/Applications/Xcode.app/Contents/Developer/Toolchains/XcodeDefault.xctoolchain/usr/bin/strip" "$ENV{DESTDIR}${CMAKE_INSTALL_PREFIX}/bin/rp")
    endif()
  endif()
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/bin" TYPE FILE PERMISSIONS OWNER_READ OWNER_WRITE OWNER_EXECUTE GROUP_READ GROUP_EXECUTE WORLD_READ WORLD_EXECUTE FILES "/Users/macbook/.emacs.d/rtags-2.14/src/../bin/gcc-rtags-wrapper.sh")
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  file(INSTALL DESTINATION "${CMAKE_INSTALL_PREFIX}/share/man/man7" TYPE FILE FILES
    "/Users/macbook/.emacs.d/rtags-2.14/src/../man/man7/rc.7"
    "/Users/macbook/.emacs.d/rtags-2.14/src/../man/man7/rdm.7"
    )
endif()

if("x${CMAKE_INSTALL_COMPONENT}x" STREQUAL "xUnspecifiedx" OR NOT CMAKE_INSTALL_COMPONENT)
  list(APPEND CMAKE_ABSOLUTE_DESTINATION_FILES
   "/usr/local/share/emacs/site-lisp/rtags/rtags.el;/usr/local/share/emacs/site-lisp/rtags/rtags.elc;/usr/local/share/emacs/site-lisp/rtags/ac-rtags.el;/usr/local/share/emacs/site-lisp/rtags/ac-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/helm-rtags.el;/usr/local/share/emacs/site-lisp/rtags/helm-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/ivy-rtags.el;/usr/local/share/emacs/site-lisp/rtags/ivy-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/company-rtags.el;/usr/local/share/emacs/site-lisp/rtags/company-rtags.elc;/usr/local/share/emacs/site-lisp/rtags/flycheck-rtags.el;/usr/local/share/emacs/site-lisp/rtags/flycheck-rtags.elc")
  if(CMAKE_WARN_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(WARNING "ABSOLUTE path INSTALL DESTINATION : ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
  if(CMAKE_ERROR_ON_ABSOLUTE_INSTALL_DESTINATION)
    message(FATAL_ERROR "ABSOLUTE path INSTALL DESTINATION forbidden (by caller): ${CMAKE_ABSOLUTE_DESTINATION_FILES}")
  endif()
file(INSTALL DESTINATION "/usr/local/share/emacs/site-lisp/rtags" TYPE FILE FILES
    "/Users/macbook/.emacs.d/rtags-2.14/src/rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/rtags.elc"
    "/Users/macbook/.emacs.d/rtags-2.14/src/ac-rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/ac-rtags.elc"
    "/Users/macbook/.emacs.d/rtags-2.14/src/helm-rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/helm-rtags.elc"
    "/Users/macbook/.emacs.d/rtags-2.14/src/ivy-rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/ivy-rtags.elc"
    "/Users/macbook/.emacs.d/rtags-2.14/src/company-rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/company-rtags.elc"
    "/Users/macbook/.emacs.d/rtags-2.14/src/flycheck-rtags.el"
    "/Users/macbook/.emacs.d/rtags-2.14/src/flycheck-rtags.elc"
    )
endif()

