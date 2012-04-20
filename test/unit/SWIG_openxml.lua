require "lua_libxml2"

local xml = lua_libxml2

xml_fixture = [[
<xml>
  <foo>bar</foo>
</xml>
]]

findByName = function(nodeName, rootNode)

  local node = rootNode
  print("Checking node '" .. node.name .. "'")
  while node do
    repeat
      if not node.name then break end
 
      -- if lua_libxml2.xmlStrcasecmp(node.name, nodeName) == 0 then
      if node.name == nodeName then
        return node
      elseif node.children then
        res = findByName(nodeName, node.children)
        if res then return res end
      end
  
      node = node.next
    until true
  end

  return nil
end

-- for m in pairs(lua_libxml2) do print(m) end

local xmlAddOption = xml.xmlAddOption

print("Reading XML...")

local opts = 0
xmlAddOption(opts, lua_libxml2.HTML_PARSE_RECOVER)
xmlAddOption(opts, lua_libxml2.HTML_PARSE_NOBLANKS)
xmlAddOption(opts, lua_libxml2.HTML_PARSE_NOERROR)
xmlAddOption(opts, lua_libxml2.HTML_PARSE_NOWARNING)
xmlAddOption(opts, lua_libxml2.HTML_PARSE_NONET)

print("Options: " .. opts)
-- doc = lua_libxml2.xmlReadMemory(xml_fixture, xml_fixture:len(), nil, nil, opts)
doc = xml.xmlReadFile("../test/fixture/some_document.xml", nil, opts)

if not doc then print("Reading XML failed, aborting"); return; end

print("XML read!")

node = findByName("foo", lua_libxml2.xmlDocGetRootElement(doc))
if node then 
  print("Node found! " .. node.name .. ", contents: " .. node.children.content)
  node.children.content = "foobar"
else 
  print("Node not found!")
end

xf_xml = ""
xf_xmlsz = 0

xml.xmlSaveFile("out.xml", doc)

xml.xmlFreeDoc(doc)
xml.xmlCleanupParser()

print("XML freed!")
