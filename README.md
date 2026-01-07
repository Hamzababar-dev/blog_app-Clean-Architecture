Flutter Clean Blog App

This is a Flutter-based blog application developed using Clean Architecture and the MVVM pattern. The app uses Supabase for authentication and backend services, supports offline access using Hive, and applies BLoC for global state management. Dependency injection is handled using GetIt to keep the codebase scalable and maintainable.

Features

User authentication (login, signup, logout)

Create and upload blog posts

Offline blog access when the internet is not available

Automatic data synchronization when connectivity is restored

Clean and scalable architecture

Global state management using BLoC

Architecture

The project follows Clean Architecture principles with MVVM to ensure separation of concerns and maintainability.

Architecture layers include:

Presentation layer (UI and BLoC)

Domain layer (entities and use cases)

Data layer (repositories and data sources)

Technologies Used

Flutter

Dart

BLoC

MVVM Architecture

Supabase (authentication and backend)

Hive (local storage for offline support)

GetIt (dependency injection)

Offline Support

Hive is used for local data persistence, allowing users to view their blogs even when there is no internet connection. This improves user experience in low-connectivity environments.

Project Structure

lib/

core/

features/

main.dart

Getting Started

Prerequisites:

Flutter SDK

Dart

Supabase project configuration

Steps to run the project:

Clone the repository

Install dependencies using flutter pub get

Run the application using flutter run

Future Enhancements

Blog comments

Likes and bookmarks

Push notifications

Dark mode support

Unit and widget testing

Contributing

Contributions are welcome. Feel free to fork the repository and submit a pull request.

License

This project is open source and available under the MIT License.

Author

Flutter Developer focused on building scalable and maintainable mobile applications.
