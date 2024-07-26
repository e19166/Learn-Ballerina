import ballerina/io;

public function main() {

    int m = 1;

    int n = 0xFFFF;

    n += m;

    io:println(n);

}