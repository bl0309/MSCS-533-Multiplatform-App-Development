# Flutter Unit Converter App

A comprehensive Flutter application for converting between metric and imperial units across multiple measurement categories.

## Features

### Conversion Categories

- **Distance**: Miles, Yards, Feet, Inches ⟷ Kilometers, Meters, Centimeters, Millimeters  
- **Weight**: Pounds, Ounces, Stones ⟷ Kilograms, Grams, Milligrams  
- **Temperature**: Fahrenheit ⟷ Celsius, Kelvin  
- **Volume**: Gallons, Quarts, Pints, Fluid Ounces ⟷ Liters, Milliliters  

### Key Functionality

- Real-time conversion as you type  
- Swap units with one tap  
- Clear all inputs easily  
- Support for decimal values  
- Accurate conversion algorithms  
- Clean, intuitive Material Design UI  
- Responsive layout for different screen sizes  

## Run the app:

git clone the repo and then run:

    flutter pub get

    flutter run

## Screenshot Example:
[Click to see Screenshot](Screenshot_Example.png)

## Code Architecture

### Key Components

- **ConversionApp**: Main application widget  
- **ConversionScreen**: Main UI screen with conversion logic  

### Conversion Logic

- Base unit conversion system  
- Accurate conversion factors  
- Error handling for invalid inputs  

## Best Practices Implemented

- **Dart Conventions**: Following effective Dart guidelines  
- **Widget Separation**: Clear separation of concerns  
- **State Management**: Proper use of `StatefulWidget`  
- **Memory Management**: Proper disposal of controllers  
- **Error Handling**: Robust input validation  
- **Comments**: Comprehensive code documentation  
- **Responsive Design**: Adaptive UI elements  

## Conversion Accuracy

- **Distance**: Based on international standards  
- **Weight**: Using standard metric/imperial ratios  
- **Temperature**: Accurate formulas for F/C/K conversion  
- **Volume**: US customary units to metric  

## Acknowledgments

- Flutter team for the amazing framework  
- Material Design guidelines  
- Community for Flutter best practices