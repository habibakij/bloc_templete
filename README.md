## Flutter Bloc Template

A starter Flutter project template using the BLoC (Business Logic Component) state management pattern — designed to help you kickstart new Flutter apps with a scalable feature based architecture.

## Contents

- [Features](#features)
- [Project Structure](#project-structure)
- [Prerequisites](#prerequisites)
- [Setup](#setup)
- [How to Use](#how-to-use)
- [Testing](#testing)
- [Recommended](#recommended)
- [Linting](#linting)
- [Contributing](#contributing)
- [License](#license)


## Features

This template provides:

🔹 Flutter + BLoC architecture for clean separation of business logic and UI

🔹 Cross-platform support: Android, iOS, Web, Desktop

🔹 Preconfigured folder structure for scalable apps

🔹 Sample folder placeholders for your blocs, models, services, and screens

🔹 Basic flutter project boilerplate you can extend for any app type

## Project Structure

```bash
bloc_templete/
├── android/                  # Android project files
├── ios/                      # iOS project files
├── lib/                      # lib folder
│   ├── blocs/                # BLoC files (events, states, blocs)
│   ├── data/                 # Data layer (models, repositories, services)
│   ├── ui/                   # UI screens & widgets
│   ├── utils/                # Utility classes/helpers
│   └── main.dart             # App entrypoint
├── test/                     # Unit & widget tests
├── assets/                   # App assets (images/fonts)
├── web/                      # Flutter Web files
├── pubspec.yaml              # Dependencies & assets config
├── analysis_options.yaml     # Lint & analyzer settings
├── .gitignore                # Git ignore file
└── README.md
```
This structure gives a clean separation between UI, state management, and data — which makes scaling and testing easier.

## Prerequisites

Before getting started, make sure you have installed:

📌 Flutter SDK (stable channel)

📌 Dart SDK (comes with Flutter)

📌 A code editor like VS Code or Android Studio

📌 Connected device or emulator

## Setup:

```bash
flutter doctor
git clone https://github.com/habibakij/bloc_templete.git
cd bloc_templete
flutter pub get
flutter run
```
## How to Use
Add a New BLoC

Create events:
```bash
abstract class MyEvent {}
class LoadData extends MyEvent {}
```
Create states:
```bash
abstract class MyState {}
class Loading extends MyState {}
class Loaded extends MyState {}
```

Create BLoC:
```bash
class MyBloc extends Bloc<MyEvent, MyState> {
  MyBloc() : super(Loading());
}
```
# Connect UI with Bloc
Wrap your widget tree using:
```bash
BlocProvider(
  create: (_) => MyBloc(),
  child: MyHomeWidget(),
)
```
Use BlocBuilder to update UI based on state:
```bash
BlocBuilder<MyBloc, MyState>(
  builder: (context, state) {
    if (state is Loading) return CircularProgressIndicator();
    return Text("Loaded!");
  },
);
```
This pattern keeps your UI clean and makes testing easier.

## Testing

You can add unit and widget tests in the test/ directory.
Run tests with:
```bash
flutter test
```

## Recommended
This template pairs well with the following packages:

- flutter_bloc — BLoC state management
- equatable — Simple value comparison for events/states
- bloc_test — Testing BLoCs
- provider or get_it (optional) — Dependency management
- Include them in your pubspec.yaml as needed.

## Linting

This project includes analyzer settings (analysis_options.yaml) to help enforce consistent code style and best practices.

## Contributing

- Feel free to:
- Add new BLoC features
- Improve documentation
- Add tests
- Suggest improvements via Issues or Pull Requests


## License

Add your license here (e.g., MIT, Apache 2.0).
(If not already included in this repo — consider adding one)

