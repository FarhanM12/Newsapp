# NewsApp

## Introduction
Welcome to the NewsApp project! This Flutter-based application provides users with the latest news from around the world. The app includes engaging animations, support for both dark mode and light mode, and features for saving news articles to read later.

## Features
- **Global News Coverage**: Stay updated with the latest news from around the world.
- **User-Friendly Interface**: Enjoy a sleek, intuitive interface with smooth animations.
- **Dark Mode and Light Mode**: Switch between dark mode and light mode based on your preference.
- **Save Articles**: Save news articles to read them later at your convenience.

## Screenshots
### (Get Started Page)
![Home Screen Light](screenshots/getstarted.jpeg)

### News Screen (Light Mode)
![Home Screen Dark](screenshots/newslight.jpeg)

### News Screen(Dark Mode) 
![News Article](screenshots/newsdark.jpeg)


## Prerequisites
Before you get started, ensure you have the following installed:
- [Flutter SDK](https://flutter.dev/docs/get-started/install)
- [Dart SDK](https://dart.dev/get-dart)
- An IDE with Flutter support (e.g., Android Studio, Visual Studio Code)

## Installation
1. **Clone the Repository**:
   ```sh
   git clone https://github.com/your-username/NewsApp.git
   cd NewsApp
   flutter pub get
   flutter run
## API Integration 
API Integration

This app fetches news from a third-party API. Follow these steps to set up API integration:

   Get an API Key:
        Sign up on the news API provider's website (e.g., NewsAPI).
        Obtain your API key after signing up.

   Update Configuration:
        Open the configuration file (lib/config.dart) in your project.
        Replace YOUR_API_KEY with your actual API key:


   const String apiKey = 'YOUR_API_KEY';

Fetch Data:

   The API key is used in network requests to fetch news data. Ensure your app makes HTTP requests to the news API endpoints using this key.
