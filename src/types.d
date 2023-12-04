module types;

class O { ///< Object
    string value;

    this() {
        this.value = "";
    }

    this(string V) {
        this.value = V;
    }
}

class Atom : O {
}

class Word : Atom {
}

class Number : Atom {
    int value;
    this(int N) {
        this.value = N;
    }
}
