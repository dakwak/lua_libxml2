# Since FindPythonInterp and FindPythonLibs are outdated and messy,
# we'll resort to hacks involving calling the python interpreter
# to retrieve the user favorite's python version (as ${LIBNAME} works
# fine on Python 2 and 3) as well as the extensions directory (site-packages).

# Get the site-packages directory and store in PYTHON_SITE_PACKAGES
EXECUTE_PROCESS ( COMMAND python3 -c "import site; print(site.getsitepackages()[0])"
                  OUTPUT_VARIABLE PYTHON_SITE_PACKAGES OUTPUT_STRIP_TRAILING_WHITESPACE)

# Python include dirs
EXECUTE_PROCESS ( COMMAND python3-config --includes  OUTPUT_VARIABLE PYTHON_INCLUDE_DIRS OUTPUT_STRIP_TRAILING_WHITESPACE)

SET(LIBNAME "lua_libxml2")
SET(WRAPPERS_DIR ${CMAKE_CURRENT_SOURCE_DIR}/wrappers)
SET(WRAPPER "${WRAPPERS_DIR}/${LIBNAME}_wrap.c")
include_directories(${CMAKE_CURRENT_SOURCE_DIR}/packages)

# generate Python bindings
ADD_CUSTOM_COMMAND( OUTPUT ${WRAPPER} COMMAND ${CMAKE_CURRENT_SOURCE_DIR}/generate_wrappers.py ${CMAKE_CURRENT_SOURCE_DIR} "Generating Lua libxml2 bindings using SWIG")

SET(SWIG_COMMAND swig -c++ -lua -I${SWIG_INCLUDE_DIRS} ${SWIG_FLAGS} -o ${WRAPPER} ${INTERFACE_FILE})

set(CMAKE_CXX_STANDARD 17)


ADD_DEFINITIONS("-DLIBXML_EXPR_ENABLED")

# the bindings library
ADD_LIBRARY(${LIBNAME} SHARED ${WRAPPER})
SET_TARGET_PROPERTIES(${LIBNAME} PROPERTIES PREFIX "")
SET_SOURCE_FILES_PROPERTIES( ${WRAPPER} PROPERTIES GENERATED 1)
INCLUDE_DIRECTORIES(${PYTHON_INCLUDE_DIRS} ${LIBXML2_INCLUDE_DIR} )

TARGET_LINK_LIBRARIES(${LIBNAME} ${libxml2_LIBRARIES})

ADD_CUSTOM_TARGET(${LIBNAME}_SWIG DEPENDS ${WRAPPER})

IF(NOT EXISTS "${WRAPPER}")
  MESSAGE(STATUS "Lua libxml2 SWIG bindings are not yet generated, forcing generation. Generate manually using make ${LIBNAME}_SWIG")
  ADD_DEPENDENCIES(${LIBNAME} ${LIBNAME}_SWIG)
ENDIF()


INSTALL(TARGETS ${LIBNAME} DESTINATION lib)
