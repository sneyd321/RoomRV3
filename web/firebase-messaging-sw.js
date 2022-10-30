importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-app.js");
importScripts("https://www.gstatic.com/firebasejs/8.10.0/firebase-messaging.js");

// Initialize the Firebase app in the service worker by passing in
// your app's Firebase config object.
// https://firebase.google.com/docs/web/setup#config-object
firebase.initializeApp({
    apiKey: 'AIzaSyBxpgJlnz2e5NV03gFfDQQjd0NVv8RvD0w',
    appId: '1:959426188245:android:32150f37668273de50a35c',
    messagingSenderId: '959426188245',
    projectId: 'roomr-222721',
    databaseURL: 'https://roomr-222721.firebaseio.com',
    storageBucket: 'roomr-222721.appspot.com',
});

// Retrieve an instance of Firebase Messaging so that it can handle background
// messages.
const messaging = firebase.messaging();
