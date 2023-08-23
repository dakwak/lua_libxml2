#  Find Lua header and library files
#
#  When called, this script tries to define:
#  Lua_INCLUDE_DIR    Header files directory
#  Lua_LIBRARIES      library files (or file when using lua 5.1)
#  Lua_FOUND          defined (true) if lua was found
#  Lua_VERSION        either 5.1 or 5.0 or undefined
#
#  authors: CHATGPT
#

FIND_PATH(Lua_INCLUDE_DIR_54 lua.h
  /usr/include/lua5.4)

FIND_LIBRARY(Lua_LIBRARY_54 NAMES lua5.4 liblua5.4 PATHS
  /usr/lib/x86_64-linux-gnu)

IF (Lua_INCLUDE_DIR_54 AND Lua_LIBRARY_54)
  # Found Lua 5.4 libs
  SET(Lua_FOUND TRUE)
  SET(Lua_VERSION "5.4" CACHE STRING "")
  SET(Lua_INCLUDE_DIR ${Lua_INCLUDE_DIR_54} CACHE PATH "")
  SET(Lua_LIBRARIES ${Lua_LIBRARY_54} CACHE FILEPATH "")
  SET(Lua_LIBRARY_NAMES "lua5.4 liblua5.4")
  MESSAGE(STATUS "Lua 5.4 was found.")
  IF (VERBOSE_FIND)
    MESSAGE(STATUS "  include path: ${Lua_INCLUDE_DIR}")
    MESSAGE(STATUS "  library path: ${Lua_LIBRARIES}")
    MESSAGE(STATUS "  libraries:    ${Lua_LIBRARY_NAMES}")
  ENDIF(VERBOSE_FIND)
ELSE (Lua_INCLUDE_DIR_54 AND Lua_LIBRARY_54)
  MESSAGE(SEND_ERROR "Lua 5.4 was not found.")
ENDIF (Lua_INCLUDE_DIR_54 AND Lua_LIBRARY_54)

