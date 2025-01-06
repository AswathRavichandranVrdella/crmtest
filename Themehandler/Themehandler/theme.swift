//
//  theme.swift
//  Themehandler
//
//  Created by Aswath Ravichandran on 17/12/24.
//
import SwiftUI
public class Theme {
    public static let shared = Theme()
    
    // Default colors (light and dark mode)
    private(set) var lightModeColors: [String: Color?]
    private(set) var darkModeColors: [String: Color?]
    
    private init() {
        // Default colors (hex values converted to Color)
        lightModeColors = [
            "primary": Color(hex: "#2F95DC"),
            "secondary": Color(hex: "#502799"),
            "tertiary" : Color(hex: "#33C3FF"),
            "background": Color(hex: "#F2EFF8"),
            "surface" : Color(hex: "#FFFFFF"),
            "error" : Color(hex: "#FF6F61"),
            "textPrimary" : Color(hex: "#2A2D33"),
            "textSecondary":  Color(hex: "#FF6F61")
        ]
        darkModeColors = [
            "primary": Color(hex: "#FF6F61"),
            "secondary": Color(hex: "#823CFF"),
            "tertiary" : Color(hex: "#33C3FF"),
            "background": Color(hex: "#1E1E1E"),
            "surface" : Color(hex: "#FFFFFF"),
            "error" : Color(hex: "#FF6F61"),
            "textPrimary" : Color(hex: "#FFFFFF"),
            "textSecondary":  Color(hex: "#FF6F61")
            ]
    }
    
    // Function to update colors
    public func updateColors(light: [String: String], dark: [String: String]) {
        lightModeColors = light.mapValues { Color(hex: $0) }
        darkModeColors = dark.mapValues { Color(hex: $0) }
        
        
        print("________________________")
        print( lightModeColors)
        
        
        print("________________________")
        print(darkModeColors)
        
        print("________________________")
    }
    
}



extension Color {
    init?(hex: String) {
        let hex = hex.trimmingCharacters(in: .whitespacesAndNewlines).trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int: UInt64 = 0
        Scanner(string: hex).scanHexInt64(&int)
        
        let r, g, b, a: UInt64
        switch hex.count {
        case 6: // RGB (24-bit)
            (r, g, b, a) = (int >> 16, int >> 8 & 0xFF, int & 0xFF, 255)
        case 8: // ARGB (32-bit)
            (r, g, b, a) = (int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF, int >> 24 & 0xFF)
        default:
            return nil // Invalid hex format
        }
        
        self.init(
            .sRGB,
            red: Double(r) / 255,
            green: Double(g) / 255,
            blue: Double(b) / 255,
            opacity: Double(a) / 255
        )
    }
}
