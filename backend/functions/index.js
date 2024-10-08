/**
 * Import function triggers from their respective submodules:
 *
 * const {onCall} = require("firebase-functions/v2/https");
 * const {onDocumentWritten} = require("firebase-functions/v2/firestore");
 *
 * See a full list of supported triggers at https://firebase.google.com/docs/functions
 */

const {onRequest} = require("firebase-functions/v2/https");
const logger = require("firebase-functions/logger");

// Create and deploy your first functions
// https://firebase.google.com/docs/functions/get-started

// exports.helloWorld = onRequest((request, response) => {
//   logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

const admin = require('firebase-admin');
admin.initializeApp();

const db = admin.firestore();

exports.addLike = functions.firestore.document('/posts/{postId}/likes/{userId}')
.onCreate((snap, context) => {
    return db
    .collection("posts")
    .doc(context.params.postId)
    .update(
        {
            likesCount: admin.firestore.FieldValue.increment(1) //increase the like count by one if the post is being liked
        })
})

exports.deleteLike = functions.firestore.document('/posts/{postId}/likes/{userId}')
.onDelete((snap, context) => {
    return db
    .collection("posts")
    .doc(context.params.postId)
    .update(
        {
            likesCount: admin.firestore.FieldValue.increment(-1) //remove the like count by one if the post is being liked
        })
})