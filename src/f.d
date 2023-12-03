import std.stdio;

void main(string[] args) {
    writeln(args);
    foreach (df; args[1 .. $]) {
        parse(df);
    }
}

void parse(string scriptfile) {

}
