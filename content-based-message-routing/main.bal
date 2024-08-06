import ballerina/http;
import ballerina/log;

enum HospitalId {
    grandoak,
    clemency,
    pinevalley
}

type Doctor record {
    string name;
    string hospital;
    string category;
    string availability;
    decimal fee;
};

type Patient record {
    string name;
    string dob;
    string ssn;
    string address;
    string phone;
    string email;
};

type ReservationResponse\.json record {
    int appointmentNumber;
    Doctor doctor;
    Patient patient;
    string hospital;
    boolean confirmed;
    string appointmentDate;
};

type ReservationRequest record {
    Patient patient;
    string doctor;
    HospitalId hospital_id;
    string hospital;
    string appointment_date;
};

service /healthcare on new http:Listener(8290) {
    resource function post categories/[string category]/reserve(ReservationRequest reservation) returns ReservationResponse\.json|http:NotFound|http:InternalServerError {
        http:Client hospitalEP;
        match reservation.hospital_id {
            grandoak => {
                hospitalEP = grandOakEP;
            }
            clemency => {
                hospitalEP = clemencyEP;
            }
            _ => {
                hospitalEP = pineValleyEP;
            }
        }

        ReservationResponse\.json|http:ClientError resp = hospitalEP->/[category]/reserve.post({
            patient: reservation.patient,
            doctor: reservation.doctor,
            hospital: reservation.hospital,
            appointment_date: reservation.appointment_date
        });

        if resp is ReservationResponse\.json {
            return resp;
        }

        log:printError("Reservation request failed", resp);

        if resp is http:ClientRequestError {
            return <http:NotFound> {body: "Unknown hospital, doctor or category"};
        }

        return <http:InternalServerError> {body: resp.message()};
    }
}

public final http:Client grandOakEP = check new ("http://localhost:9090/grandoak/categories");
public final http:Client clemencyEP = check new ("http://localhost:9090/clemency/categories");
public final http:Client pineValleyEP = check new ("http://localhost:9090/pinevalley/categories");