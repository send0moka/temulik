# temulik

A new Flutter project.

## Firestore Data Structure

users (collection)
├── {userId} (document - automatically created from Firebase Auth UID)
    ├── email (string)
    ├── photoUrl (string)
    ├── fullName (string)
    ├── nim (string)
    ├── faculty (string)
    ├── department (string)
    ├── year (number)
    ├── whatsapp (string)
    ├── address (string)
    └── createdAt (timestamp)