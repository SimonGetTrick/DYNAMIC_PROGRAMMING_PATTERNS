//
//  1.2Builder.swift
//  Dynamic_Examples
//
//  Created by Simon Getrik on 11.05.2025.
//

import Foundation
import Foundation

// Model for the app theme
struct AppTheme {
    let backgroundColor: String
    let textColor: String
    let fontName: String
    let fontSize: Double
    let isDarkMode: Bool
    
    // Display the theme details
    func describe() -> String {
        return """
        Theme Details:
        - Background Color: \(backgroundColor)
        - Text Color: \(textColor)
        - Font: \(fontName) (Size: \(fontSize))
        - Dark Mode: \(isDarkMode)
        """
    }
}

// Protocol for the theme builder
protocol AppThemeBuilderProtocol {
    func setBackgroundColor(_ color: String) -> Self
    func setTextColor(_ color: String) -> Self
    func setFontName(_ fontName: String) -> Self
    func setFontSize(_ size: Double) -> Self
    func enableDarkMode(_ enabled: Bool) -> Self
    func build() -> AppTheme?
}

// Builder class for creating AppTheme
class AppThemeBuilder: AppThemeBuilderProtocol {
    private var backgroundColor: String?
    private var textColor: String?
    private var fontName: String?
    private var fontSize: Double?
    private var isDarkMode: Bool = false
    
    // Set the background color
    @discardableResult
    func setBackgroundColor(_ color: String) -> Self {
        self.backgroundColor = color
        return self
    }
    
    // Set the text color
    @discardableResult
    func setTextColor(_ color: String) -> Self {
        self.textColor = color
        return self
    }
    
    // Set the font name
    @discardableResult
    func setFontName(_ fontName: String) -> Self {
        self.fontName = fontName
        return self
    }
    
    // Set the font size
    @discardableResult
    func setFontSize(_ size: Double) -> Self {
        self.fontSize = size
        return self
    }
    
    // Enable or disable dark mode
    @discardableResult
    func enableDarkMode(_ enabled: Bool) -> Self {
        self.isDarkMode = enabled
        return self
    }
    
    // Build the theme with validation
    func build() -> AppTheme? {
        guard let backgroundColor = backgroundColor,
              let textColor = textColor,
              let fontName = fontName,
              let fontSize = fontSize else {
            print("Error: Missing required theme properties")
            return nil
        }
        return AppTheme(
            backgroundColor: backgroundColor,
            textColor: textColor,
            fontName: fontName,
            fontSize: fontSize,
            isDarkMode: isDarkMode
        )
    }
}

// Demo function to showcase Builder pattern
func demo_pattert_1_2_ThemeBuilder() {
    // Create a dark theme
    let darkTheme = AppThemeBuilder()
        .setBackgroundColor("Black")
        .setTextColor("White")
        .setFontName("Helvetica")
        .setFontSize(16.0)
        .enableDarkMode(true)
        .build()
    
    if let darkTheme = darkTheme {
        print(darkTheme.describe())
    }
    
    // Create a light theme
    let lightTheme = AppThemeBuilder()
        .setBackgroundColor("White")
        .setTextColor("Black")
        .setFontName("Arial")
        .setFontSize(14.0)
        .enableDarkMode(false)
        .build()
    
    if let lightTheme = lightTheme {
        print(lightTheme.describe())
    }
    
    // Example with missing properties
    let invalidTheme = AppThemeBuilder()
        .setBackgroundColor("Gray")
        .setTextColor("Blue")
        .build() // Will fail due to missing font properties
}
