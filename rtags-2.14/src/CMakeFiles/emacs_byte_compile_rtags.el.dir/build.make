# CMAKE generated file: DO NOT EDIT!
# Generated by "Unix Makefiles" Generator, CMake Version 3.11

# Delete rule output on recipe failure.
.DELETE_ON_ERROR:


#=============================================================================
# Special targets provided by cmake.

# Disable implicit rules so canonical targets will work.
.SUFFIXES:


# Remove some rules from gmake that .SUFFIXES does not remove.
SUFFIXES =

.SUFFIXES: .hpux_make_needs_suffix_list


# Suppress display of executed commands.
$(VERBOSE).SILENT:


# A target that is always out of date.
cmake_force:

.PHONY : cmake_force

#=============================================================================
# Set environment variables for the build.

# The shell in which to execute make rules.
SHELL = /bin/sh

# The CMake executable.
CMAKE_COMMAND = /usr/local/Cellar/cmake/3.11.3/bin/cmake

# The command to remove a file.
RM = /usr/local/Cellar/cmake/3.11.3/bin/cmake -E remove -f

# Escaping for special characters.
EQUALS = =

# The top-level source directory on which CMake was run.
CMAKE_SOURCE_DIR = /Users/macbook/.emacs.d/rtags-2.14

# The top-level build directory on which CMake was run.
CMAKE_BINARY_DIR = /Users/macbook/.emacs.d/rtags-2.14

# Utility rule file for emacs_byte_compile_rtags.el.

# Include the progress variables for this target.
include src/CMakeFiles/emacs_byte_compile_rtags.el.dir/progress.make

src/CMakeFiles/emacs_byte_compile_rtags.el: src/rtags.elc


src/rtags.elc: src/rtags.el
	@$(CMAKE_COMMAND) -E cmake_echo_color --switch=$(COLOR) --blue --bold --progress-dir=/Users/macbook/.emacs.d/rtags-2.14/CMakeFiles --progress-num=$(CMAKE_PROGRESS_1) "Creating byte-compiled Emacs lisp /Users/macbook/.emacs.d/rtags-2.14/src/rtags.elc"
	cd /Users/macbook/.emacs.d/rtags-2.14/src && /Applications/emacs.app/Contents/MacOS/Emacs -batch -l /Users/macbook/.emacs.d/rtags-2.14/src/compile-shim.elisp -l /Users/macbook/.emacs.d/rtags-2.14/src/rtags.el -f batch-byte-compile /Users/macbook/.emacs.d/rtags-2.14/src/rtags.el

emacs_byte_compile_rtags.el: src/CMakeFiles/emacs_byte_compile_rtags.el
emacs_byte_compile_rtags.el: src/rtags.elc
emacs_byte_compile_rtags.el: src/CMakeFiles/emacs_byte_compile_rtags.el.dir/build.make

.PHONY : emacs_byte_compile_rtags.el

# Rule to build all files generated by this target.
src/CMakeFiles/emacs_byte_compile_rtags.el.dir/build: emacs_byte_compile_rtags.el

.PHONY : src/CMakeFiles/emacs_byte_compile_rtags.el.dir/build

src/CMakeFiles/emacs_byte_compile_rtags.el.dir/clean:
	cd /Users/macbook/.emacs.d/rtags-2.14/src && $(CMAKE_COMMAND) -P CMakeFiles/emacs_byte_compile_rtags.el.dir/cmake_clean.cmake
.PHONY : src/CMakeFiles/emacs_byte_compile_rtags.el.dir/clean

src/CMakeFiles/emacs_byte_compile_rtags.el.dir/depend:
	cd /Users/macbook/.emacs.d/rtags-2.14 && $(CMAKE_COMMAND) -E cmake_depends "Unix Makefiles" /Users/macbook/.emacs.d/rtags-2.14 /Users/macbook/.emacs.d/rtags-2.14/src /Users/macbook/.emacs.d/rtags-2.14 /Users/macbook/.emacs.d/rtags-2.14/src /Users/macbook/.emacs.d/rtags-2.14/src/CMakeFiles/emacs_byte_compile_rtags.el.dir/DependInfo.cmake --color=$(COLOR)
.PHONY : src/CMakeFiles/emacs_byte_compile_rtags.el.dir/depend

