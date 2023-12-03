import std.stdio;

import parser;

void main(string[] args) {
    writeln(args);
    foreach (df; args[1 .. $]) {
        parse(df);
    }
}
