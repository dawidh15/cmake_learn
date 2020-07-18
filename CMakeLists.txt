# Step 03. CMake tutorial
# https://cmake.org/cmake/help/latest/guide/tutorial/index.html#adding-usage-requirements-for-library-step-3

cmake_minimum_required(VERSION 3.10)

 # set the project name
 project(Tutorial VERSION 1.0)

 # Make MathFunctions Library Optional https://cmake.org/cmake/help/latest/command/option.html#command:option
 option(USE_MYMATH "Use tutorial provided math implementation" ON)

 # Add the math functions library https://cmake.org/cmake/help/latest/command/add_subdirectory.html#command:add_subdirectory
 if(USE_MYMATH)
   add_subdirectory(MathFunctions)
   list(APPEND EXTRA_LIBS MathFunctions)
 endif()

# Add the executable
 add_executable(Tutorial tutorial.cxx)

## Link REQUIRED libraries: https://cmake.org/cmake/help/latest/command/target_link_libraries.html#command:target_link_libraries
# target_link_libraries(Tutorial PUBLIC MathFunctions)

# Link OPTIONAL libraries
target_link_libraries(Tutorial PUBLIC ${EXTRA_LIBS})

 # Copies an <input> file to an <output> file and substitutes variable values referenced as @VAR@ or ${VAR} in the input file content. Each variable reference will be replaced with the current value of the variable, or the empty string if the variable is not defined.
# https://cmake.org/cmake/help/v3.18/command/configure_file.html#command:configure_file
 configure_file(TutorialConfig.h.in TutorialConfig.h)

 # specify the C++ standard
set(CMAKE_CXX_STANDARD 11)
set(CMAKE_CXX_STANDARD_REQUIRED True)


# # Specifies REQUIRED include directories to use when compiling a given target. The named <target> must have been created by a command such as add_executable() or add_library() and must not be an ALIAS target.
# # https://cmake.org/cmake/help/v3.18/command/target_include_directories.html#command:target_include_directories
# target_include_directories(
#                             Tutorial PUBLIC
#                             "${PROJECT_BINARY_DIR}"
#                             "${PROJECT_SOURCE_DIR}/MathFunctions"
#                           )

# Include directories and Optional includes...
target_include_directories(Tutorial PUBLIC
                           "${PROJECT_BINARY_DIR}"
                           )
