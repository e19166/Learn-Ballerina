import ballerina/io;

public function main() {

    float x = 1.0;

    int n = 5;

    var f = 12345f;
    io:println(f is float);

    float y = x + <float>n;

    io:println(y);
    

}