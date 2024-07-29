
# Top Events
Top Events is a Flutter application designed to streamline event creation and ticket management. Users can create events, purchase tickets, and generate QR codes for their tickets. The app also includes an admin layout with various functionalities to manage and monitor events effectively.

## Features

### User Features
- **Create Events**: Users can create new events with relevant details such as name, date, time, location, and images.
- **Get Tickets**: Users can obtain tickets for events and receive a QR code for entry.
- **QR Code Generation**: Each ticket comes with a unique QR code for verification.

### Admin Features
- **Event Management**: Admins can change the status of an event from pending to rejected or accepted.
- **Edit Events**: Admins have the ability to modify event details.
- **QR Code Scanning**: Admins can scan ticket QR codes to verify ticket authenticity.

## Key Packages

- **[firebase_auth](https://pub.dev/packages/firebase_auth)**:
  - Provides authentication using email and password.

- **[cloud_firestore](https://pub.dev/packages/cloud_firestore)**:
  - Stores all data related to events, users, and tickets in Firestore.

- **[firebase_storage](https://pub.dev/packages/firebase_storage)**:
  - Stores event images and profile images in Cloud Storage.

- **[GetX](https://pub.dev/packages/get)**:
  - A state management library used for efficient state handling.

- **[google_maps_flutter](https://pub.dev/packages/google_maps_flutter)**:
  - Provides a Google Maps widget for determining event locations.

- **[date_time_picker](https://pub.dev/packages/date_time_picker)**:
  - Displays a date or clock dialog to allow users to select event date and time.

- **[image_picker](https://pub.dev/packages/image_picker)**:
  - Allows users to pick images from the image library and take new pictures with the camera to upload event images.

- **[barcode_widget](https://pub.dev/packages/barcode_widget)**:
  - Generates barcodes for event tickets.

- **[flutter_barcode_scanner](https://pub.dev/packages/flutter_barcode_scanner)**:
  - Scans barcodes for ticket verification.

- **[ticket_widget](https://pub.dev/packages/ticket_widget)**:
  - Implements the Ticket Widget.

- **[flutter_credit_card](https://pub.dev/packages/flutter_credit_card)**:
  - Implements the credit card UI for payment processing.
    
## Demonstration Video
[Wacth the video](https://drive.google.com/file/d/1KVVjGqpg27s9FyRnEYWTsojocZufIMjt/view?usp=sharing)

