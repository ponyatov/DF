module parser;

import pegged.grammar;

mixin(grammar(`
    FORTH:
        Term    <- ( comment / Number / Word / space )*
        comment <- '#' (!'\n' .)*
        Number  <- [+\-]?[0-9]+
        Word    <- (![ \t\r\n\f] .)+
        space   <- [ \t\r\n\f]+
`));

import std.stdio;
import std.file;

void parse(string scriptfile) {
    auto src = readText(scriptfile);
    writeln(FORTH(src));
}
