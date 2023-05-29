README.md

# Flutter Item List App

This is a Flutter application that displays a list of items retrieved from a REST API. It allows you to view item details, add new items, and delete items from the list. The application uses the Provider package for state management, the http package for making API calls, and the dio package for handling API calls. It also utilizes the flutter_cache_manager package for image caching.

## Features

- Displays a list of items retrieved from a REST API.
- Allows you to pull down on the list to refresh the items.
- Tap on an item to view more details.
- Add a new item to the list.
- Delete an item by swiping left on it.
- Responsive design for different screen sizes and orientations.

## Getting Started

To run the application, follow these steps:

1. Make sure you have Flutter installed. For installation instructions, refer to the [Flutter documentation](https://flutter.dev/docs/get-started/install).

2. Clone this repository to your local machine using the following command:

   ```bash
   git clone https://github.com/Promss/test_assignments.git
   ```

3. Navigate to the project directory:

   ```bash
   cd test_assignments
   ```

4. Run the following command to fetch the project dependencies:

   ```bash
   flutter pub get
   ```

5. Connect your physical device or start an emulator.

6. Run the application:

   ```bash
   flutter run
   ```

## Configuration

To use a different REST API or customize the application further, you can make the following changes:

- Modify the API endpoint URL in the `ItemListProvider` class to fetch items from a different API.

- Customize the data model in the `Item` class to match the structure of the JSON data returned by your API.

- Adjust the UI and layout in the `ItemListScreen` and `ItemDetailScreen` widgets to fit your design requirements.


## Dependencies

The application uses the following dependencies:

- provider: ^6.0.5 - For state management.
- http: ^0.13.6 - For making HTTP requests.
- dio: ^5.1.2 - For handling API requests.
- flutter_cache_manager: ^3.3.0 - For caching images.

For more details on these dependencies, refer to the `pubspec.yaml` file.

## Contributing

Contributions are welcome! If you find any issues or have suggestions for improvement, please open an issue or submit a pull request.
