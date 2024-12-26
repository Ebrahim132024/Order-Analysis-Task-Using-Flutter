# Customer Orders Data Analysis App

This Flutter application reads a JSON file containing customer orders, parses the data, and displays it on the screen. The app includes a graph to visualize orders grouped by month, along with key metrics like total orders, average sales, and number of returns. The app supports both Arabic and English.

## Features:
1. **Graph Visualization**:
   - Displays a bar graph with dates of orders (grouped by month) on the X-axis and the number of orders for each month on the Y-axis.
   
2. **Key Metrics**:
   - Displays the total count of orders, average sales, and the number of returns at the top of the page.

3. **State Management**:
   - Uses `Cubit` for managing the state.

4. **Multi-Language Support**:
   - Supports both Arabic and English languages using the `easy_localization` package.

## Setup and Installation Instructions

### Prerequisites:
- Make sure you have the latest stable version of Flutter installed. If not, please refer to the [Flutter Installation Guide](https://flutter.dev/docs/get-started/install).
- Ensure that you have Android Studio or Visual Studio Code (with Flutter plugin) installed for running the application on Android and iOS simulators/emulators.

### Step 1: Clone the repository
Clone the repository to your local machine using the following command:
git clone <repository_url>

### Step 2: Install Dependencies
Make sure you have Flutter installed on your machine. Then, navigate to the project directory and run the following command to install the dependencies:

### Step 3: Add Assets
In the assets/ directory, ensure you have the following files:
orders_data.json: Contains the order data in JSON format.
Language files: en.json and ar.json inside the assets/lang/ directory for English and Arabic localization, respectively.

### Step 4: Run the App
After setting up the assets and dependencies, you can run the app using the following command:

flutter run

The app will be available on both Android and iOS platforms.

## Assumptions Made During Development
The JSON data contains orders in the format of a list of objects.
The date format used in the JSON file (e.g., yyyy-MM-ddTHH:mm:ssZ).
The number of orders per month is grouped by the order_date field.
The app uses the fl_chart package to display the bar chart for orders per month.
Key metrics such as total orders, average sales, and number of returns are calculated on the client side.

## Architecture
**Cubit for state management**: Cubit is used to manage the state of the orders and UI interactions.

**fl_chart for charts**: A bar chart is used to visualize the number of orders per month.

**intl package**: Used for date formatting and localization support (Arabic and English).

## Testing Code
The test you've written for calculating total orders, returns, and average sales looks good.

## Packages Used
- **flutter_bloc**: State management using Cubit.
- **json_annotation**: For JSON parsing.
- **equatable**: For comparing objects in Cubit states.
- **shared_preferences**: For storing local preferences.
- **easy_localization**: For multi-language support.
