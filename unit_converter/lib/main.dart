import 'package:flutter/material.dart';

void main() {
  runApp(const MeasuresConverterApp());
}

/// Main application widget that sets up the MaterialApp
class MeasuresConverterApp extends StatelessWidget {
  const MeasuresConverterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measures Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: false, // Using Material 2 for exact match
        scaffoldBackgroundColor: Colors.grey[100],
      ),
      home: const MeasuresConverterScreen(),
    );
  }
}

/// Main screen widget containing the conversion interface
class MeasuresConverterScreen extends StatefulWidget {
  const MeasuresConverterScreen({super.key});

  @override
  State<MeasuresConverterScreen> createState() => _MeasuresConverterScreenState();
}

class _MeasuresConverterScreenState extends State<MeasuresConverterScreen> {
  // Controllers for input text field
  final TextEditingController _valueController = TextEditingController();
  
  // Current conversion units
  String _fromUnit = 'meters';
  String _toUnit = 'feet';
  
  // Result of the conversion
  String _result = '';
  
  // Available units for conversion
  final List<String> _availableUnits = [
    // Distance units
    'meters', 'feet', 'inches', 'yards', 'kilometers', 'miles', 'centimeters', 'millimeters',
    // Weight units  
    'kilograms', 'pounds', 'ounces', 'grams', 'stones', 'milligrams',
    // Temperature units
    'celsius', 'fahrenheit', 'kelvin',
    // Volume units
    'liters', 'gallons', 'quarts', 'pints', 'fluid ounces', 'milliliters',
  ];

  @override
  void initState() {
    super.initState();
    // Set initial value
    _valueController.text = '0';
    _performConversion();
  }

  @override
  void dispose() {
    _valueController.dispose();
    super.dispose();
  }

  /// Perform the actual conversion calculation
  void _performConversion() {
    if (_valueController.text.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    final double? inputValue = double.tryParse(_valueController.text);
    if (inputValue == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    if (_fromUnit == _toUnit) {
      setState(() {
        _result = '$inputValue $_fromUnit are $inputValue $_toUnit';
      });
      return;
    }

    try {
      double convertedValue = _convertValue(inputValue, _fromUnit, _toUnit);
      setState(() {
        _result = '${_valueController.text} $_fromUnit are ${convertedValue.toStringAsFixed(3)} $_toUnit';
      });
    } catch (e) {
      setState(() {
        _result = 'Conversion not supported';
      });
    }
  }

  /// Convert value from one unit to another
  double _convertValue(double value, String fromUnit, String toUnit) {
    // Convert to base unit first, then to target unit
    double baseValue = _convertToBase(value, fromUnit);
    return _convertFromBase(baseValue, toUnit);
  }

  /// Convert from any unit to the base unit of its category
  double _convertToBase(double value, String unit) {
    switch (unit.toLowerCase()) {
      // Distance conversions to meters
      case 'meters':
        return value;
      case 'feet':
        return value * 0.3048;
      case 'inches':
        return value * 0.0254;
      case 'yards':
        return value * 0.9144;
      case 'kilometers':
        return value * 1000;
      case 'miles':
        return value * 1609.34;
      case 'centimeters':
        return value * 0.01;
      case 'millimeters':
        return value * 0.001;
      
      // Weight conversions to grams
      case 'grams':
        return value;
      case 'kilograms':
        return value * 1000;
      case 'pounds':
        return value * 453.592;
      case 'ounces':
        return value * 28.3495;
      case 'stones':
        return value * 6350.29;
      case 'milligrams':
        return value * 0.001;
      
      // Temperature conversions to celsius
      case 'celsius':
        return value;
      case 'fahrenheit':
        return (value - 32) * 5 / 9;
      case 'kelvin':
        return value - 273.15;
      
      // Volume conversions to liters
      case 'liters':
        return value;
      case 'gallons':
        return value * 3.78541;
      case 'quarts':
        return value * 0.946353;
      case 'pints':
        return value * 0.473176;
      case 'fluid ounces':
        return value * 0.0295735;
      case 'milliliters':
        return value * 0.001;
      
      default:
        throw ArgumentError('Unknown unit: $unit');
    }
  }

  /// Convert from base unit to target unit
  double _convertFromBase(double baseValue, String unit) {
    switch (unit.toLowerCase()) {
      // Distance conversions from meters
      case 'meters':
        return baseValue;
      case 'feet':
        return baseValue / 0.3048;
      case 'inches':
        return baseValue / 0.0254;
      case 'yards':
        return baseValue / 0.9144;
      case 'kilometers':
        return baseValue / 1000;
      case 'miles':
        return baseValue / 1609.34;
      case 'centimeters':
        return baseValue / 0.01;
      case 'millimeters':
        return baseValue / 0.001;
      
      // Weight conversions from grams
      case 'grams':
        return baseValue;
      case 'kilograms':
        return baseValue / 1000;
      case 'pounds':
        return baseValue / 453.592;
      case 'ounces':
        return baseValue / 28.3495;
      case 'stones':
        return baseValue / 6350.29;
      case 'milligrams':
        return baseValue / 0.001;
      
      // Temperature conversions from celsius
      case 'celsius':
        return baseValue;
      case 'fahrenheit':
        return (baseValue * 9 / 5) + 32;
      case 'kelvin':
        return baseValue + 273.15;
      
      // Volume conversions from liters
      case 'liters':
        return baseValue;
      case 'gallons':
        return baseValue / 3.78541;
      case 'quarts':
        return baseValue / 0.946353;
      case 'pints':
        return baseValue / 0.473176;
      case 'fluid ounces':
        return baseValue / 0.0295735;
      case 'milliliters':
        return baseValue / 0.001;
      
      default:
        throw ArgumentError('Unknown unit: $unit');
    }
  }

  /// Handle from unit change
  void _onFromUnitChanged(String? newUnit) {
    if (newUnit != null && newUnit != _fromUnit) {
      setState(() {
        _fromUnit = newUnit;
      });
      // Don't auto-convert when unit changes
    }
  }

  /// Handle to unit change
  void _onToUnitChanged(String? newUnit) {
    if (newUnit != null && newUnit != _toUnit) {
      setState(() {
        _toUnit = newUnit;
      });
      // Don't auto-convert when unit changes
    }
  }

  /// Convert button pressed
  void _onConvertPressed() {
    _performConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Measures Converter',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        backgroundColor: const Color(0xFF2196F3), // Blue color matching screenshot
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.grey[100],
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Value Section
            const Text(
              'Value',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            TextField(
              controller: _valueController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              style: const TextStyle(
                fontSize: 24,
                color: Color(0xFF2196F3),
                fontWeight: FontWeight.w500,
              ),
              decoration: const InputDecoration(
                border: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2196F3),
                    width: 2.0,
                  ),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2196F3),
                    width: 2.0,
                  ),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(
                    color: Color(0xFF2196F3),
                    width: 2.0,
                  ),
                ),
                contentPadding: EdgeInsets.symmetric(vertical: 8.0),
              ),
              onChanged: (value) => _performConversion(),
            ),
            
            const SizedBox(height: 40),
            
            // From Section
            const Text(
              'From',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF2196F3),
                    width: 2.0,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _fromUnit,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w500,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF2196F3),
                    size: 28,
                  ),
                  isExpanded: true,
                  items: _availableUnits.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: _onFromUnitChanged,
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // To Section
            const Text(
              'To',
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 8),
              decoration: const BoxDecoration(
                border: Border(
                  bottom: BorderSide(
                    color: Color(0xFF2196F3),
                    width: 2.0,
                  ),
                ),
              ),
              child: DropdownButtonHideUnderline(
                child: DropdownButton<String>(
                  value: _toUnit,
                  style: const TextStyle(
                    fontSize: 20,
                    color: Color(0xFF2196F3),
                    fontWeight: FontWeight.w500,
                  ),
                  icon: const Icon(
                    Icons.keyboard_arrow_down,
                    color: Color(0xFF2196F3),
                    size: 28,
                  ),
                  isExpanded: true,
                  items: _availableUnits.map((String unit) {
                    return DropdownMenuItem<String>(
                      value: unit,
                      child: Text(unit),
                    );
                  }).toList(),
                  onChanged: _onToUnitChanged,
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Convert Button
            Center(
              child: ElevatedButton(
                onPressed: _onConvertPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: const Color(0xFF2196F3),
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  elevation: 0,
                ),
                child: const Text(
                  'Convert',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 40),
            
            // Result Section
            if (_result.isNotEmpty)
              Center(
                child: Text(
                  _result,
                  style: const TextStyle(
                    fontSize: 18,
                    color: Colors.grey,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }
}