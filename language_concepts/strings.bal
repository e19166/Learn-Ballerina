import ballerina/io;

public function main() {

    string grin = "\u{1F600}";

    string greeting = "Hello " + grin;

    io:println(greeting);

    io:println(greeting[1]);

}