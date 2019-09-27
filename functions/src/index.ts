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
    if (context.auth.token.moderator !== true) {
        return {
            error: "Request not authrized. User must be a Moderator to fulfil the request."
        };
    }

    const email = data.email;
    return grantModeratorRole(email).then(() => {
        return {
            result: `Request fullfilled! ${email} is now moderator`
        }
    });
})

async function grantModeratorRole(email: string): Promise<void> {
    const user = await admin.auth().getUserByEmail(email);
    if (user.customClaims && (user.customClaims as any).moderator === true) {
        return;
    }

    return admin.auth().setCustomUserClaims(user.uid, {
        moderator: true
    });
}