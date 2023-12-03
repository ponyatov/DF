module parser;

import pegged.grammar;

mixin(grammar(`
FORTH:
    Term    < ( Comment / Number / Word / WS )*
    Comment < '#' [^\n]*
    Number  < [0-9]+
    Word    < [^ \t\r\n\f]+
    WS      < [ \t\r\n\f]+
`));

import std.stdio;
import std.file;

void parse(string scriptfile) {
    auto src = readText(scriptfile);
    writeln(FORTH(src));
}
