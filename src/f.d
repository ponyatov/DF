import std.stdio;
import std.file;

void main(string[] args) {
    writeln(args);
    foreach (df; args[1 .. $]) {
        parse(df);
    }
}

void parse(string scriptfile) {
    auto src = readText(scriptfile);
    writeln(src);
}
