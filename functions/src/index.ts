import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// import * as Twilio from 'twilio';
// import * as secretKeys from '../secrets/keys'

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

// const twilioNumber = secretKeys.twilioNumber;
// const accountSid = secretKeys.accountSid;
// const authToken = secretKeys.authToken;

// const client = Twilio(accountSid, authToken);

admin.initializeApp();

const fcm = admin.messaging();

// Add New Admin Function
exports.addAdmin = functions.https.onCall((data, context) => {
    // if (context.auth.token.moderator !== true) {
    //     return {
    //         error: "Request not authrized. User must be a Moderator to fulfil the request."
    //     };
    // }

    const email = data.email;
    return grantModeratorRole(email).then(() => {
        return {
            result: `Request fullfilled! ${email} is now moderator`
        }
    });
});

async function grantModeratorRole(email: string): Promise<void> {
    const user = await admin.auth().getUserByEmail(email);
    // if (user.customClaims && (user.customClaims as any).moderator === true) {
    //     return;
    // }

    return admin.auth().setCustomUserClaims(user.uid, {
        moderator: true,
        doctor: true,
        student: true
    });
}


// Add Doctor
exports.addDoctor = functions.https.onCall((data, context) => {
    // if (context.auth.token.doctor !== true) {
    //     return {
    //         error: "Request not authrized. User must be a Doctor to fulfil the request."
    //     }
    // }

    const email = data.email;
    return grantDoctorRole(email).then(() => {
        return {
            result: `Request fullfilled! ${email} is now doctor`
        }
    });
});

async function grantDoctorRole(email: string): Promise<void> {
    const user = await admin.auth().getUserByEmail(email);
    // if (user.customClaims && (user.customClaims as any).doctor === true) {
    //     return;
    // }

    return admin.auth().setCustomUserClaims(user.uid, {
        doctor: true,
        student: true
    });
}


// Add Student
exports.addStudent = functions.https.onCall((data, context) => {
    // if (context.auth.token.student !== true) {
    //     return {
    //         error: "Request not authrized. User must be a Moderator to fulfil the request."
    //     };
    // }

    const email = data.email;
    return grantStudentRole(email).then(() => {
        return {
            result: `Request fullfilled! ${email} is now student`
        }
    });
});

async function grantStudentRole(email: string): Promise<void> {
    const user = await admin.auth().getUserByEmail(email);
    // if (user.customClaims && (user.customClaims as any).student === true) {
    //     return;
    // }

    return admin.auth().setCustomUserClaims(user.uid, {
        student: true
    });
}

//this func won't deploy until billing enabled
// exports.scheduledFunction = functions.pubsub.schedule('every 1 minutes').onRun(async (context) => {
//     const inActiveStudents = await getInActiveStudents();
//     console.log('In active users : ' + inActiveStudents.length);
// });

export const tempScheduleFunction = functions.https.onRequest((request, response) => {
    admin.auth().listUsers().then((userRecords) => {
        userRecords.users.forEach((user) => console.log(user.toJSON()));
        response.end('Retrieved users list successfully.');
    }).catch((error) => console.log(error));
});

// In active adolecents push notification function 
exports.cloudNotificatinFunction = functions.https.onCall(async (data, context) => {
    const querySnapshot = await admin.firestore().collection('admins')
        .doc(data.authId).collection('tokens').get();

    const token = querySnapshot.docs.map(snap => snap.id);
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: 'We missed you!',
            body: 'Please come back and complete rings ',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'

        }
    };
    return fcm.sendToDevice(token, payload);
});

// Doctor Appointment notification function
exports.doctorNotificatinFunction = functions.https.onCall(async (data, context) => {
    const querySnapshot = await admin.firestore().collection('students')
        .doc(data.authId).collection('tokens').get();

    const token = querySnapshot.docs.map(snap => snap.id);
    const payload: admin.messaging.MessagingPayload = {
        notification: {
            title: 'You have an appointment',
            body: 'Please come to see the doctor ',
            clickAction: 'FLUTTER_NOTIFICATION_CLICK'

        }
    };
    return fcm.sendToDevice(token, payload);
});


exports.dailyLeisureProgressFunction = functions.firestore
    .document('dailyLogs/{documentId}/{dayCollection}/{dayDocId}/{tasks}/{tasks}/{collectionName}/{docId}')
    .onWrite(async (change, context) => {

        const newData = change.after.data();
        const oldData = change.before.data();
        if (newData !== null && oldData !== null) {
            const documentId = context.params.documentId;
            const dayCollection = context.params.dayCollection;
            const difference = newData.completed - oldData.completed;
            const collectionName = context.params.collectionName;

            const doc = await admin.firestore().collection('dailyLogs').doc(documentId)
                .collection(dayCollection).doc(dayCollection).collection('tasks').doc('tasks').get();

            const docData = doc.data();

            let progress;

            switch (collectionName) {
                case "Leisure": {
                    progress = docData.totalLeisure + difference;
                    admin.firestore().collection('dailyLogs')
                        .doc(documentId).collection(dayCollection)
                        .doc(dayCollection).collection("tasks").doc("tasks")
                        .update({ dailyLeisure: progress })
                        .then(() => console.log('Success'))
                        .catch(err => console.log(err));
                }
                    break;
                case "Social": {
                    progress = docData.totalSocial + difference;
                    admin.firestore().collection('dailyLogs')
                        .doc(documentId).collection(dayCollection)
                        .doc(dayCollection).collection("tasks").doc("tasks")
                        .update({ dailySocial: progress })
                        .then(() => console.log('Success'))
                        .catch(err => console.log(err));
                }
                    break;
                default: {
                    progress = docData.totalStudy + difference;
                    admin.firestore().collection('dailyLogs')
                        .doc(documentId).collection(dayCollection)
                        .doc(dayCollection).collection("tasks").doc("tasks")
                        .update({ dailyStudy: progress })
                        .then(() => console.log('Success'))
                        .catch(err => console.log(err));
                }
            }

            return ("Updated Daily Progress");
        }
        else {
            return {
                error: 'Something went wrong'
            }
        }
    });