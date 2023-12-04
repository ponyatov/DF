module types;

class O { ///< Object
    string value;
}

class Atom : O {
}

class Word : Atom {
}

class Number : Atom {
    int value;
    this(int n) {
        this.value = n;
    }
}
