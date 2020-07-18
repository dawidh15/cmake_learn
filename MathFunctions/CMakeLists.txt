add_library(MathFunctions mysqrt.cxx)

target_include_directories(
	MathFunctions
	INTERFACE ${CMAKE_CURRENT_SOURCE_DIR}
)

# Install lib in folder Lib
install(TARGETS MathFunctions DESTINATION lib)

#Install header file in 'include'
install(FILES MathFunctions.h DESTINATION include)
