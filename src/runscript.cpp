#include <iostream>
#include <lua.hpp>

int main(int argc, char** argv) {
  if (argc < 1) {
    std::cout << "Usage: runscript LUA_SCRIPT_PATH\n";
    return 0;
  }

  lua_State *lua = lua_open();
  luaL_openlibs(lua);

  int rc = luaL_dofile(lua, argv[1]);
  if (rc == 1) {
    std::cerr << "Lua Error: " << lua_tostring(lua, -1) << '\n';
    lua_pop(lua, -1);
  }

  lua_close(lua);

  return 1;
}