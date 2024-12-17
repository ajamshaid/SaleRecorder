// lib/styles.dart
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';


String dtFormat = 'dd-MMM-yyyy';

class AppUtils{
  static String formatCurrency(double value){
    return NumberFormat.currency(locale: 'ur_PK', symbol:'').format(value);
  } 
}


class AppStyles {
   static const Color _primaryColor = Color(0xFF4A154B);  // Slack's signature purple
   static const Color _secondaryColor = Color(0xFF1264A3);  // Slack blue
   static const Color _tertiaryColor = Color(0xFF2EB67D);  

 static const MaterialColor appPrimaryMaterialColor =  MaterialColor(
  0xFF4A154B, // Base color
  <int, Color>{
    50: Color(0xFFF2E5F3),
    100: Color(0xFFE6B3D6),
    200: Color(0xFFDA80B8), // You can change this shade as needed
    300: Color(0xFFCF4D9A),
    400: Color(0xFFC13A8C),
    500: Color(0xFFB3277D), // Primary color (Base color)
    600: Color(0xFF9F216F),
    700: Color(0xFF8D1D61),
    800: Color(0xFF7B1953),
    900: Color(0xFF681445),
  },
);



  static const TextStyle textStyle = TextStyle(
    color: Colors.black,
  );


  static const InputDecoration inputDecoration = InputDecoration(
    labelStyle: TextStyle(color: Colors.grey), 
    filled: true,
    fillColor:  Colors.white,
    enabledBorder: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 1.0), // Blue border when not focused
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: BorderSide(color: Colors.blue, width: 0.5), // Blue border when focused
    ),
    border: UnderlineInputBorder(
      borderSide: BorderSide(color: Colors.blue , width: 1.0), // Border for the default state
    ),
  );

  static ButtonStyle loginBtnStyle = ElevatedButton.styleFrom(
    backgroundColor: Colors.blue[600],
    foregroundColor: Colors.white,
    minimumSize: const Size(double.infinity, 60),
    shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(20)), // This removes the rounded corners
  ),
  );

static BoxDecoration borderedDecoration = BoxDecoration(
          border: Border.all(
            color: Colors.blue, // Border color
            width: 2, // Border width
          ),
);

   // Define a container style
  static BoxDecoration containerDecoration = BoxDecoration(
    color: Colors.white, 
    borderRadius: const BorderRadius.all(Radius.circular(50)), // Rounded corners
    boxShadow: [
      BoxShadow(
        color: Colors.grey.withOpacity(0.3),
        spreadRadius: 10,
        blurRadius: 15,
        offset: const Offset(0, 3), // Shadow position
      ),
    ],
  );

  static EdgeInsets containerPadding = const EdgeInsets.all(16); // Padding inside the container
  static EdgeInsets containerMargin = const EdgeInsets.all(20);
}


class SlackInspiredTheme {
  // Color palette
  static const Color _primaryColor = Color(0xFF4A154B);  // Slack's signature purple
  static const Color _secondaryColor = Color(0xFF1264A3);  // Slack blue
  static const Color _tertiaryColor = Color(0xFF2EB67D);  // Slack green
  
  // Create a custom color scheme
  static ColorScheme _createColorScheme(Brightness brightness) {
    return ColorScheme(
      brightness: brightness,
      primary: _primaryColor,
      onPrimary: Colors.white,
      secondary: _secondaryColor,
      onSecondary: Colors.white,
      tertiary: _tertiaryColor,
      onTertiary: Colors.white,
      error: Colors.red,
      onError: Colors.white,
      background: brightness == Brightness.light 
          ? const Color(0xFFF8F8F8) 
          : const Color(0xFF121212),
      onBackground: brightness == Brightness.light 
          ? Colors.black 
          : Colors.white,
      surface: brightness == Brightness.light 
          ? Colors.white 
          : const Color(0xFF1E1E1E),
      onSurface: brightness == Brightness.light 
          ? Colors.black 
          : Colors.white,
    );
  }

  // Light Theme
  static ThemeData lightTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _createColorScheme(Brightness.light),
      
      // Appbar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor,
        foregroundColor: Colors.white,
        elevation: 2,
        scrolledUnderElevation: 4,
        titleTextStyle: const TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
      ),

      // Text Theme with Material 3 typography
      textTheme: TextTheme(
        displayLarge: TextStyle(
          fontSize: 57,
          fontWeight: FontWeight.bold,
          color: _createColorScheme(Brightness.light).onBackground,
        ),
        displayMedium: TextStyle(
          fontSize: 45,
          fontWeight: FontWeight.w600,
          color: _createColorScheme(Brightness.light).onBackground,
        ),
        titleLarge: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: _createColorScheme(Brightness.light).onBackground,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: _createColorScheme(Brightness.light).onBackground,
        ),
      ),

      // Elevated Button Theme
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: _secondaryColor,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),

      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(
            color: _secondaryColor,
            width: 2,
          ),
        ),
        labelStyle: TextStyle(
          color: Colors.grey.shade600,
        ),
      ),

      // Card Theme
      cardTheme: CardTheme(
        color: Colors.white,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),

      // Floating Action Button Theme
      floatingActionButtonTheme: FloatingActionButtonThemeData(
        backgroundColor: _tertiaryColor,
        foregroundColor: Colors.white,
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Bottom Navigation Bar Theme
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: _primaryColor.withOpacity(0.1),
        labelTextStyle: MaterialStateProperty.resolveWith((states) {
          return TextStyle(
            color: states.contains(MaterialState.selected) 
                ? _primaryColor 
                : Colors.grey.shade600,
          );
        }),
      ),

      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: _secondaryColor.withOpacity(0.1),
        selectedColor: _secondaryColor,
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
   
   // dataTable Theme
      dataTableTheme:  DataTableThemeData(
      headingTextStyle: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.bold,
        color: Color(0xFF4A154B), // Slack purple
      ),
      dataTextStyle: const TextStyle(
        fontSize: 14,
        color: Color(0xFF1D1C1D), // Slack dark gray
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color(0xFFEBEBEB), // Slack light gray
          width: 0.5,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      columnSpacing: 30,
      horizontalMargin: 10,
      dividerThickness: 0.5,
     // dividerColor: const Color(0xFFEBEBEB), // Slack light gray
      dataRowColor: MaterialStateProperty.resolveWith((states) {
        if (states.contains(MaterialState.selected)) {
          return const Color(0xFFE8F0F9); // Slack blue tint
        }
        return Colors.transparent;
      }),
      dataRowHeight: 35,
      headingRowColor: MaterialStateProperty.all(
        const Color(0xFFF8F8F8), // Slack background
      ),
      headingRowHeight: 40,
    )
    );
  }

  // Dark Theme
  static ThemeData darkTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: _createColorScheme(Brightness.dark),
      brightness: Brightness.dark,
      
      // Most properties will be similar to light theme, 
      // but with dark mode colors
      appBarTheme: AppBarTheme(
        backgroundColor: _primaryColor.withOpacity(0.9),
        foregroundColor: Colors.white,
        elevation: 2,
        scrolledUnderElevation: 4,
      ),
    );
  }
}

class TransparentFab extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final Color iconColor;
  final String tooltip;

  const TransparentFab({
    Key? key,
    required this.onPressed,
    this.icon = Icons.add,
    this.iconColor = AppStyles._primaryColor,
    this.tooltip = "Add",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip, // The text to show on hover/long-press
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent, // Fully transparent background
          shape: BoxShape.circle,
          border: Border.all(color: iconColor, width: 1), // Optional border
        ),
        child: InkWell(
          onTap: onPressed,
          borderRadius: BorderRadius.circular(100),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(
              icon,
              color: iconColor,
            ),
          ),
        ),
      ),
    );
  }
}
