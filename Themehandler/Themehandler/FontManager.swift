//
//  FontManager.swift
//  
//
//  Created by Aswath Ravichandran on 31/12/24.
//

import SwiftUI
import Combine

public class FontManager: ObservableObject {
    
    public static let shared = FontManager()
    
    private init() {
    }
    
   public  func registerCustomFonts() {
       
     
      
      
        let fontNames = ["Poppins-Medium", "Poppins-Regular","Poppins-MediumItalic","Poppins-Italic","Poppins-Bold","Poppins-SemiBold","Poppins-BoldItalic","Poppins-ExtraBoldItalic","Poppins-ExtraBold","Poppins-Black","Poppins-BlackItalic","Poppins-LightItalic","Poppins-Light","Poppins-ThinItalic","Poppins-ExtraLight","Poppins-SemiBoldItalic","Poppins-Thin"]
        
        for fontName in fontNames {
            guard let fontURL = Bundle.main.url(forResource: fontName, withExtension: "ttf") else {
                print("❌ Font not found: \(fontName)")
                continue
            }
            
            guard let fontDataProvider = CGDataProvider(url: fontURL as CFURL),
                  let font = CGFont(fontDataProvider) else {
                print("❌ Failed to load font: \(fontName)")
                continue
            }
            
            var error: Unmanaged<CFError>?
            if !CTFontManagerRegisterGraphicsFont(font, &error) {
                print("❌ Error registering font: \(fontName) - \(String(describing: error?.takeUnretainedValue()))")
            } else {
                print("✅ Successfully registered font: \(fontName)")
            }
        }
    }
    
}
