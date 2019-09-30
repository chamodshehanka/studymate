import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

admin.initializeApp();

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

// exports.sendPushNotification = functions.firestore.document('Activities').onCreate(event => {
//     var request = event.data;
//     var playload = {
//        data: {
//            username: 'Random',
//            email: 'studymate@gmail.com'
//        } 
//     }
//     admin.messaging().sendToDevice(playload);
// });