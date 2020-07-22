add_library(
MathFunctions
mysqrt.cxx
${CMAKE_CURRENT_BINARY_DIR}/Table.h
)

# state that anybody linking to us needs to include the current source dir
# to find MathFunctions.h, while we don't.
target_include_directories(MathFunctions
          INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
          PRIVATE ${CMAKE_CURRENT_BINARY_DIR}
          )

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


# ========= System introspection Check for features in system ===========
# # If the platform has log and exp then we will use them to compute the square root in the mysqrt function. We first test for the availability of these functions using the CheckSymbolExists module in the top-level CMakeLists.txt. On some platforms, we will need to link to the m library. If log and exp are not initially found, require the m library and try again.
#
# # <check_symbol_exists(<symbol> <files> <variable>)> Check that the <symbol> is available after including given header <files> and store the result in a <variable>. Specify the list of files in one argument as a semicolon-separated list. <variable> will be created as an internal cache variable.
# # consider include(CheckCXXSymbolExists), check_cxx_symbol_exists for C++
# include(CheckSymbolExists)
# check_symbol_exists(log "math.h" HAVE_LOG)
# check_symbol_exists(exp "math.h" HAVE_EXP)
# if(NOT (HAVE_LOG AND HAVE_EXP))
#   unset(HAVE_LOG CACHE)
#   unset(HAVE_EXP CACHE)
#   set(CMAKE_REQUIRED_LIBRARIES "m")
#   check_symbol_exists(log "math.h" HAVE_LOG)
#   check_symbol_exists(exp "math.h" HAVE_EXP)
#   if( HAVE_LOG AND HAVE_EXP )
#     target_link_libraries(MathFunctions PRIVATE m)
#   endif()
# endif()
#
# # add compile definitions
# if(HAVE_LOG AND HAVE_EXP)
#   target_compile_definitions(MathFunctions
#                              PRIVATE "HAVE_LOG" "HAVE_EXP")
# endif()

# install rules
install(TARGETS MathFunctions DESTINATION lib)
install(FILES MathFunctions.h DESTINATION include)
install(FILES ${CMAKE_CURRENT_BINARY_DIR}/Table.h DESTINATION include)
