ADD_SUBDIRECTORY(bindings/lua/SWIG)



ADD_EXECUTABLE(runscript runscript.cpp)
target_include_directories(runscript PRIVATE ${LUA_INCLUDE_DIR} ${LIBXML2_INCLUDE_DIR})
target_link_libraries(runscript PRIVATE ${LUA_LIBRARIES} ${LIBXML2_LIBRARIES})

