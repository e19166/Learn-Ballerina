import ballerina/io;

int value;

final string name;

function init() returns error? {

    value = 5;

    name = "James";

    if value > 3 {

        return error("Value should less than 3");

    }
}

public function main() {

    io:println(name);

}

