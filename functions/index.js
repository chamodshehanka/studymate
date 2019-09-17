const functions = require('firebase-functions');

const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope CurrentUser
// 
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

//New Activity Push Notification
// exports.newActivityNotification = functions.firestore
//     .document('Activities/{id}')
//     .onCreate((change, context) => {

//     });

// New SignUp
exports.addNewRole = functions.https.onCall((data, context) => {
    // Get user and add custom claim (admin)
    return admin.auth().getUserByEmail(data.email).then(user => {
        return admin.auth().setCustomUserClaims(user.uid, {
            admin: true
        });
    }).then(() => {
        return {
            message: `Admin added Success! ${data.email}`
        }
    }).catch(err => {
        return err;
    })
});