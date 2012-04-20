ADD_SUBDIRECTORY(bindings/lua/SWIG)

ADD_EXECUTABLE(runscript runscript.cpp)
TARGET_LINK_LIBRARIES(runscript lua)
