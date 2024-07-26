import ballerina/io;

decimal nanos = 1d/1000000000d;

function floatSurprise() {

    float f = 100.10 - 0.01;
    io:println(f);

}

public function main() {

    floatSurprise();
    io:println(nanos);

    var d = 12345d;
    io:println(d is decimal);
    
}