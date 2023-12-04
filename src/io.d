module io;

import types;

class IO : O {
}

class Path : IO {
    this(string V) {
        this.value = V;
    }
}

class Dir : IO {
    Path path;
}

class File : IO {
    Path path;
}
