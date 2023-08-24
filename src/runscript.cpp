#include <iostream>
extern "C" {
#include <lua.h>
#include <lauxlib.h>
#include <lualib.h>
}

int main(int argc, char** argv) {
  if (argc < 2) { // You want to check for less than 2 arguments since the first argument is the program name itself
    std::cout << "Usage: runscript LUA_SCRIPT_PATH\n";
    return 0;
  }

  lua_State *lua = luaL_newstate(); // create a new state
  if (!lua) {
    std::cerr << "Cannot create Lua state: not enough memory\n";
    return 2;
  }
  
  luaL_openlibs(lua); // open standard libraries

  int rc = luaL_loadfile(lua, argv[1]) || lua_pcall(lua, 0, 0, 0); // load and run the file
  if (rc != LUA_OK) {
    std::cerr << "Lua Error: " << lua_tostring(lua, -1) << '\n';
    lua_pop(lua, 1); // pop error message from the stack
  }

  lua_close(lua); // close the Lua state

  return rc == LUA_OK ? 0 : 1; // Return 0 if everything was successful
}

