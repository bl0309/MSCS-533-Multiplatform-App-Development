import 'package:flutter/material.dart';

void main() {
  runApp(const ConversionApp());
}

/// Main application widget that sets up the MaterialApp
class ConversionApp extends StatelessWidget {
  const ConversionApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Unit Converter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          elevation: 4,
        ),
      ),
      home: const ConversionScreen(),
    );
  }
}

/// Main screen widget containing the conversion interface
class ConversionScreen extends StatefulWidget {
  const ConversionScreen({super.key});

  @override
  State<ConversionScreen> createState() => _ConversionScreenState();
}

class _ConversionScreenState extends State<ConversionScreen> {
  // Controllers for input text fields
  final TextEditingController _inputController = TextEditingController();
  
  // Current conversion type and units
  String _selectedConversionType = 'Distance';
  String _fromUnit = 'Miles';
  String _toUnit = 'Kilometers';
  
  // Result of the conversion
  String _result = '';
  
  // Available conversion types and their units
  final Map<String, Map<String, List<String>>> _conversionTypes = {
    'Distance': {
      'Imperial': ['Miles', 'Yards', 'Feet', 'Inches'],
      'Metric': ['Kilometers', 'Meters', 'Centimeters', 'Millimeters'],
    },
    'Weight': {
      'Imperial': ['Pounds', 'Ounces', 'Stones'],
      'Metric': ['Kilograms', 'Grams', 'Milligrams'],
    },
    'Temperature': {
      'Imperial': ['Fahrenheit'],
      'Metric': ['Celsius', 'Kelvin'],
    },
    'Volume': {
      'Imperial': ['Gallons', 'Quarts', 'Pints', 'Fluid Ounces'],
      'Metric': ['Liters', 'Milliliters'],
    },
  };

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_performConversion);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  /// Get all available units for the selected conversion type
  List<String> _getAllUnits() {
    final typeData = _conversionTypes[_selectedConversionType];
    if (typeData == null) return [];
    
    List<String> allUnits = [];
    typeData.forEach((system, units) {
      allUnits.addAll(units);
    });
    return allUnits;
  }

  /// Perform the actual conversion calculation
  void _performConversion() {
    if (_inputController.text.isEmpty) {
      setState(() {
        _result = '';
      });
      return;
    }

    final double? inputValue = double.tryParse(_inputController.text);
    if (inputValue == null) {
      setState(() {
        _result = 'Invalid input';
      });
      return;
    }

    double convertedValue;
    
    try {
      convertedValue = _convertValue(inputValue, _fromUnit, _toUnit);
      setState(() {
        _result = convertedValue.toStringAsFixed(4);
      });
    } catch (e) {
      setState(() {
        _result = 'Conversion error';
      });
    }
  }

  /// Convert value from one unit to another
  double _convertValue(double value, String fromUnit, String toUnit) {
    // If same units, return original value
    if (fromUnit == toUnit) return value;

    // Convert to base unit first, then to target unit
    double baseValue = _convertToBase(value, fromUnit);
    return _convertFromBase(baseValue, toUnit);
  }

  /// Convert from any unit to the base unit of its category
  double _convertToBase(double value, String unit) {
    switch (unit) {
      // Distance conversions to meters
      case 'Miles':
        return value * 1609.34;
      case 'Yards':
        return value * 0.9144;
      case 'Feet':
        return value * 0.3048;
      case 'Inches':
        return value * 0.0254;
      case 'Kilometers':
        return value * 1000;
      case 'Meters':
        return value;
      case 'Centimeters':
        return value * 0.01;
      case 'Millimeters':
        return value * 0.001;
      
      // Weight conversions to grams
      case 'Pounds':
        return value * 453.592;
      case 'Ounces':
        return value * 28.3495;
      case 'Stones':
        return value * 6350.29;
      case 'Kilograms':
        return value * 1000;
      case 'Grams':
        return value;
      case 'Milligrams':
        return value * 0.001;
      
      // Temperature conversions to Celsius
      case 'Fahrenheit':
        return (value - 32) * 5 / 9;
      case 'Celsius':
        return value;
      case 'Kelvin':
        return value - 273.15;
      
      // Volume conversions to liters
      case 'Gallons':
        return value * 3.78541;
      case 'Quarts':
        return value * 0.946353;
      case 'Pints':
        return value * 0.473176;
      case 'Fluid Ounces':
        return value * 0.0295735;
      case 'Liters':
        return value;
      case 'Milliliters':
        return value * 0.001;
      
      default:
        throw ArgumentError('Unknown unit: $unit');
    }
  }

  /// Convert from base unit to target unit
  double _convertFromBase(double baseValue, String unit) {
    switch (unit) {
      // Distance conversions from meters
      case 'Miles':
        return baseValue / 1609.34;
      case 'Yards':
        return baseValue / 0.9144;
      case 'Feet':
        return baseValue / 0.3048;
      case 'Inches':
        return baseValue / 0.0254;
      case 'Kilometers':
        return baseValue / 1000;
      case 'Meters':
        return baseValue;
      case 'Centimeters':
        return baseValue / 0.01;
      case 'Millimeters':
        return baseValue / 0.001;
      
      // Weight conversions from grams
      case 'Pounds':
        return baseValue / 453.592;
      case 'Ounces':
        return baseValue / 28.3495;
      case 'Stones':
        return baseValue / 6350.29;
      case 'Kilograms':
        return baseValue / 1000;
      case 'Grams':
        return baseValue;
      case 'Milligrams':
        return baseValue / 0.001;
      
      // Temperature conversions from Celsius
      case 'Fahrenheit':
        return (baseValue * 9 / 5) + 32;
      case 'Celsius':
        return baseValue;
      case 'Kelvin':
        return baseValue + 273.15;
      
      // Volume conversions from liters
      case 'Gallons':
        return baseValue / 3.78541;
      case 'Quarts':
        return baseValue / 0.946353;
      case 'Pints':
        return baseValue / 0.473176;
      case 'Fluid Ounces':
        return baseValue / 0.0295735;
      case 'Liters':
        return baseValue;
      case 'Milliliters':
        return baseValue / 0.001;
      
      default:
        throw ArgumentError('Unknown unit: $unit');
    }
  }

  /// Handle conversion type change
  void _onConversionTypeChanged(String? newType) {
    if (newType != null && newType != _selectedConversionType) {
      setState(() {
        _selectedConversionType = newType;
        // Reset units to first available ones
        final allUnits = _getAllUnits();
        if (allUnits.isNotEmpty) {
          _fromUnit = allUnits.first;
          _toUnit = allUnits.length > 1 ? allUnits[1] : allUnits.first;
        }
      });
      _performConversion();
    }
  }

  /// Handle from unit change
  void _onFromUnitChanged(String? newUnit) {
    if (newUnit != null && newUnit != _fromUnit) {
      setState(() {
        _fromUnit = newUnit;
      });
      _performConversion();
    }
  }

  /// Handle to unit change
  void _onToUnitChanged(String? newUnit) {
    if (newUnit != null && newUnit != _toUnit) {
      setState(() {
        _toUnit = newUnit;
      });
      _performConversion();
    }
  }

  /// Clear all inputs and results
  void _clearAll() {
    setState(() {
      _inputController.clear();
      _result = '';
    });
  }

  /// Swap from and to units
  void _swapUnits() {
    setState(() {
      String temp = _fromUnit;
      _fromUnit = _toUnit;
      _toUnit = temp;
    });
    _performConversion();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Measures Converter'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Conversion Type Selector
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Conversion Type',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedConversionType,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                      items: _conversionTypes.keys.map((String type) {
                        return DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        );
                      }).toList(),
                      onChanged: _onConversionTypeChanged,
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Input Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Enter Value',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    TextField(
                      controller: _inputController,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: 'Enter a number',
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 8,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Unit Selection Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Unit Conversion',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        IconButton(
                          onPressed: _swapUnits,
                          icon: const Icon(Icons.swap_horiz),
                          tooltip: 'Swap units',
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    
                    // From Unit
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('From:', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: _fromUnit,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: _getAllUnits().map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: _onFromUnitChanged,
                        ),
                      ],
                    ),
                    
                    const SizedBox(height: 16),
                    
                    // To Unit
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('To:', style: TextStyle(fontSize: 16)),
                        const SizedBox(height: 4),
                        DropdownButtonFormField<String>(
                          value: _toUnit,
                          decoration: const InputDecoration(
                            border: OutlineInputBorder(),
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                          ),
                          items: _getAllUnits().map((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(unit),
                            );
                          }).toList(),
                          onChanged: _onToUnitChanged,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 16),
            
            // Result Section
            Card(
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Result',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12.0),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(4.0),
                        color: Colors.grey[50],
                      ),
                      child: Text(
                        _result.isEmpty ? 'Enter a value to see the result' : '$_result $_toUnit',
                        style: TextStyle(
                          fontSize: 16,
                          color: _result.isEmpty ? Colors.grey : Colors.black,
                          fontWeight: _result.isEmpty ? FontWeight.normal : FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            
            const SizedBox(height: 20),
            
            // Action Buttons
            Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _clearAll,
                    icon: const Icon(Icons.clear),
                    label: const Text('Clear All'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: _swapUnits,
                    icon: const Icon(Icons.swap_horiz),
                    label: const Text('Swap Units'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}