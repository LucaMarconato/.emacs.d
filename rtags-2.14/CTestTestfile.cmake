# CMake generated Testfile for 
# Source directory: /Users/macbook/.emacs.d/rtags-2.14
# Build directory: /Users/macbook/.emacs.d/rtags-2.14
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(SBRootTest "perl" "/Users/macbook/.emacs.d/rtags-2.14/tests/sbroot/sbroot_test.pl" "/usr/local/bin")
subdirs("src")
