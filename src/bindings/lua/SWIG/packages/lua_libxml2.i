%module lua_libxml2
%{
%}

%apply char*  {xmlChar*};
//%typemap(in, numinputs=0) (xmlDocPtr doc, char ** mem, int * size) (xmlDocPtr doc, char *temp, int templen) {
//  $1 = doc;
//  $2 = &temp;
//  $3 = &templen;
//}

%include "typemaps.i"
// %include "cstring.i"

%include "xmlexports.i"
%include "xmlversion.i"
%include "xmlregexp.i"
%include "xmlstring.i"
%include "parser.i"
%include "tree.i"
%include "HTMLparser.i"
%include "HTMLtree.i"
%include "utility.i"
