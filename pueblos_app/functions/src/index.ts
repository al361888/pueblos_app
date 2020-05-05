import * as functions from 'firebase-functions';

import * as admin from 'firebase-admin';
admin.initializeApp();

const fcm = admin.messaging();

export const sendToTopic = functions.firestore
  .document('proclamations/{proclamationId}')
  .onCreate(async snapshot => {
    //const proclamation = snapshot.data();

    const payload: admin.messaging.MessagingPayload = {
      notification: {
        title: '¡Se ha creado un nuevo bando!',
        body: `Nuevo bando en Villanueva de Viver`,
        //icon: 'your-icon-url',
        click_action: 'FLUTTER_NOTIFICATION_CLICK'
      }
    };

    return fcm.sendToTopic('VillanuevaDeViver', payload);
  });
// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });
