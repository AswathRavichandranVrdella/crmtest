//
//  ColorManagers.swift
//  Themehandler
//
//  Created by Aswath Ravichandran on 19/12/24.
//

//import SwiftUI

// MARK: - ColorManager Class
//public class ColorManagers {
//    public static let shared = ColorManagers()
//    
//    private let theme = Theme.shared
//    
//    private init() {}
//    
//    // Get color based on current interface style
//    public func getColor(for key: String) -> Color {
//        let userInterfaceStyle = UITraitCollection.current.userInterfaceStyle
//        switch userInterfaceStyle {
//        case .dark:
//            return (theme.darkModeColors[key] ?? .clear)!
//        default:
//            return (theme.lightModeColors[key] ?? .clear)!
//        }
//    }
//    
//    // Update colors from API
//    public func updateColorsFromAPI(light: [String: String], dark: [String: String]) {
//        theme.updateColors(light: light, dark: dark)
//    }
//}



import SwiftUI
import Combine

public class ColorManagers: ObservableObject {
    public static let shared = ColorManagers()
    
    @Published private(set) var currentColors: [String: Color] = [:]
    
    private let theme = Theme.shared
    private var cancellables = Set<AnyCancellable>()
    
    private init() {
        // Observe light/dark mode changes using Combine
        NotificationCenter.default.publisher(for: UIScene.willEnterForegroundNotification)
            .sink { [weak self] _ in
                self?.updateCurrentColors()
            }
            .store(in: &cancellables)

        // Initial setup
        updateCurrentColors()
    }
    
    // Get color for a key
    public func getColor(for key: String) -> Color {
        currentColors[key] ?? .clear
    }
    
    // Update colors from API
    public func updateColorsFromAPI(light: [String: String], dark: [String: String]) {
        theme.updateColors(light: light, dark: dark)
        updateCurrentColors() // Reflect the new colors
    }
    
    public func getFont(for name: String, size: CGFloat) -> Font {
            // You can use a method in your font manager or fetch the font using name and size
            return Font.custom(name, size: size)
        }
    
    // Update current colors based on the current interface style
    public func updateCurrentColors() {
        let userInterfaceStyle = UITraitCollection.current.userInterfaceStyle
        switch userInterfaceStyle {
        case .dark:
            currentColors = theme.darkModeColors.compactMapValues { $0 }
        default:
            currentColors = theme.lightModeColors.compactMapValues { $0 }
        }
    }
}
