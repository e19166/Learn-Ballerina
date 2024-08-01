import ballerina/http;
import ballerina/log;

type Doctor record {|
    string name;
    string hospital;
    string category;
    string availability;
    decimal fee;
|};

configurable string healthcareBackend = "http://localhost:9090/healthcare";

http:Client queryDoctorEP;

service /healthcare on new http:Listener(8290) {

    resource function get doctors/[string category]() 
            returns Doctor[]|http:NotFound|http:InternalServerError {
        log:printInfo("Retrieving information", specialization = category);

        Doctor[]|http:ClientError resp = queryDoctorEP->get("/" + category);
        if (resp is Doctor[]) {
            return resp;
        }

        log:printError("Retrieving doctor information failed", resp);
        if (resp is http:ClientRequestError) {
            return <http:NotFound> {body: string `category not found: ${category}`};
        }

        return <http:InternalServerError> {body: resp.message()};
    }
}

function init() returns error? {
    queryDoctorEP = check new(healthcareBackend);
}

function start() returns error? {
    queryDoctorEP = check initializeHttpClient();
}

function initializeHttpClient() returns http:Client|error {
    return new (healthcareBackend);
}
