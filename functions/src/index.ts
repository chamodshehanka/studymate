import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';
// import * as Twilio from 'twilio';
// import * as secretKeys from '../secrets/keys'

// require('dotenv').config();
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


// exports.getStudentsNamesFunction = functions.https.onRequest((request, response) => {
//     const name = request.get.name;
//     response.send(name + 'Kusura');
// });

// exports.sendMessageToParent = functions.https.onCall((data, context) => {
//     const message = data.message;
//     const textContent = {
//         body: `${message}`,
//         to: '+94775633985',
//         from: twilioNumber
//     }
//     client.messages.create(textContent).then((msg) => {
//         console.log(msg);
//     }).catch((error) => {
//         console.log(error);
//     });
// });

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