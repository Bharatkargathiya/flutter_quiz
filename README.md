
# flutter_quiz

flutter_quiz is a Flutter-based application designed to provide an interactive quiz experience. 
The app allows users to answer a series of questions, calculates their score, and displays it at the end.

---

## Features

- Present questions and options to the user.
- Allow the user to select an answer for each question.
- Calculate and display the total score at the end of the quiz.
- Robust error handling using `BaseResponse` and `QuizService`.

---

## Project Setup

### Prerequisites

- **Flutter SDK**: Version 3.24.4  
  Ensure Flutter is installed and added to your system's PATH. You can verify the installation with:
  ```bash
  flutter --version
  ```

### Clone the Repository

Clone the repository and switch to the development branch:
```bash
git clone <repository-url>
cd <repository-folder>
git checkout bharat_devlopment
```

### Install Dependencies

Run the following command to install the required dependencies:
```bash
flutter pub get
```

---

## Development Details

### Packages Used

- **dio**: For API calls.
- **get**: For state management using GetX.
- **google_fonts**: For applying custom font styles.

### Utilities

- **String, Color, and Image Utils**: Common utility classes for consistent styling and references.
- **Error Handling**: Managed through `BaseResponse` and `QuizService`.

---

## Running the Project

To run the project, use:
```bash
flutter run
```
Ensure you have a connected device or an emulator running.

---

## Code Structure

- **lib/utils/**: Contains utility classes for strings, colors, and images.
- **lib/services/**: Manages API calls and error handling.
- **lib/screens/**: Contains UI components for the quiz flow.


## License

This project is licensed under the MIT License.

---

Happy coding! 🎉
