import { initializeApp } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-app.js";
import { getAnalytics } from "https://www.gstatic.com/firebasejs/11.3.1/firebase-analytics.js";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
  apiKey: "AIzaSyDt2qsYmXCI19edz-GSX0w3_YJeXfppzqM",
  authDomain: "manitfirst.firebaseapp.com",
  projectId: "manitfirst",
  storageBucket: "manitfirst.firebasestorage.app",
  messagingSenderId: "582382995944",
  appId: "1:582382995944:web:6fb349b72d2134bc7a7c5d",
  measurementId: "G-3559KW0LJS",
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);
