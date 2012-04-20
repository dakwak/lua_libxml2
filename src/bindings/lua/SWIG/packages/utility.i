%module lua_libxml2
%{
  #include <libxml/tree.h>
  #include <libxml/HTMLtree.h>

  int xmlAddOption(int field, int opt) {
    return field | opt;
  }

  static xmlChar* __dump(xmlDocPtr doc, int isHTML, int isFormatted) {
    xmlChar *str = NULL;
    int strsz = 0;

    if (isHTML)
      if (isFormatted)
        htmlDocDumpMemoryFormat(doc, &str, &strsz, 1);
      else
        htmlDocDumpMemory(doc, &str, &strsz);
    else
      if (isFormatted)
        xmlDocDumpFormatMemory(doc, &str, &strsz, 1);
      else
        xmlDocDumpMemory(doc, &str, &strsz);

    return str;
  }

  xmlChar* xmlDump(xmlDocPtr doc) {
    return __dump(doc, 0, 0);
  }
  xmlChar* xmlDumpFormatted(xmlDocPtr doc) {
    return __dump(doc, 0, 1);
  }
  xmlChar* htmlDump(xmlDocPtr doc) {
    return __dump(doc, 1, 0);
  }
  xmlChar* htmlDumpFormatted(xmlDocPtr doc) {
    return __dump(doc, 1, 1);
  }

%}

int xmlAddOption(int field, int opt);

%newobject xmlDump;
%newobject xmlDumpFormatted;
%newobject htmlDump;
%newobject htmlDumpFormatted;

xmlChar* xmlDump(xmlDocPtr doc);
xmlChar* htmlDump(xmlDocPtr doc);
xmlChar* xmlDumpFormatted(xmlDocPtr doc);
xmlChar* htmlDumpFormatted(xmlDocPtr doc);
