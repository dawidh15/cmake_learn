add_library(MathFunctions MathFunctions.cxx)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
# ============= Step 11 Export ========================
target_include_directories(MathFunctions
                           INTERFACE
                            $<BUILD_INTERFACE:${CMAKE_CURRENT_SOURCE_DIR}>
                            $<INSTALL_INTERFACE:include>
                           )
# Use gen expr to use paths that will be valid in other machines.
# =========================================================================
# Should we use our own math functions.
option(USE_MYMATH "Use tutorial provided math implementation" ON)

if(USE_MYMATH)

  target_compile_definitions(MathFunctions PRIVATE "USE_MYMATH")

# ================== Make table of values ====================
  # Create exe to construct Table
add_executable(MakeTable MakeTable.cxx)

  # run exe to create table as part of the build.
#MakeTable.exe takes path of Table.h as argument. See COMMAND below
add_custom_command(
  OUTPUT ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  COMMAND MakeTable ${CMAKE_CURRENT_BINARY_DIR}/Table.h
  DEPENDS MakeTable
)
#=============================================================

# State that we depend on our binary dir to find Table.h
add_library(SqrtLibrary STATIC
  mysqrt.cxx
  ${CMAKE_CURRENT_BINARY_DIR}/Table.h
)


# Library that just make the sqrt
target_include_directories(SqrtLibrary PRIVATE
${CMAKE_CURRENT_BINARY_DIR}
)

# state that SqrtLibrary need PIC when the default is shared libraries
 set_target_properties(SqrtLibrary PROPERTIES
                       POSITION_INDEPENDENT_CODE ${BUILD_SHARED_LIBS}
                       )
#MathFunctions target depends on SqrtLibrary
target_link_libraries(MathFunctions PRIVATE SqrtLibrary)

endif()

# define the symbol stating we are using the declspec(dllexport) when
# building on windows
target_compile_definitions(MathFunctions PRIVATE "EXPORTING_MYMATH")

# install rules
#install(TARGETS MathFunctions DESTINATION lib)
# ============= Step 11 Export =============
install(TARGETS MathFunctions tutorial_compiler_flags
        DESTINATION lib
        EXPORT MathFunctionsTargets)
install(EXPORT MathFunctionsTargets
  FILE MathFunctionsTargets.cmake
  DESTINATION lib/cmake/MathFunctions
)
# ==============================================
install(FILES MathFunctions.h DESTINATION include)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/Table.h DESTINATION include)
include(GNUInstallDirs) #contains GNUInstallDirs Variabl (CMAKE_INSTALL_BINDIR)
install(FILES ${PROJECT_BINARY_DIR}/$<CONFIG>/MathFunctions.dll
DESTINATION bin)
