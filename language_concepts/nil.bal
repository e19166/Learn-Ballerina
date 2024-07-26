import ballerina/io;

int? v = ();

int? n = v == () ? 0 : v;

int m = v ?: 0;

function foo() returns () {

    return ();

}

public function main() {
    io:println(v);
}