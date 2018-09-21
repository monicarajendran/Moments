//
//  FontManager.swift
//  AWW
//
//  Created by Karthik on 11/3/17.
//  Copyright © 2017 AnywhereWorks. All rights reserved.
//

import Foundation
import UIKit

let AppFontFamily: FontFamily = .sanFrancisco

enum FontFamily: String {

    case lato = "Lato"
    case sanFrancisco = "SFProDisplay"
    
    var name: String {
        return self.rawValue
    }
}

struct FontManager {
    
    enum FontType {
        case installed(FontStyle)
        case custom(String)
        case system
        case systemBold
        case systemItatic
    }
    //semibold, medium, regular, bold, right, sembold italic
    enum FontStyle: String {
        
        case regular = "Regular"
        
        case light = "Light"
        case lightItalic = "LightItalic"
        
        case medium = "Medium"
        case mediumItalic = "MediumItalic"
        
        case bold = "Bold"
        case boldItalic = "BoldItalic"
        
        case semiBold = "Semibold"
        case semiboldItalic = "SemiboldItalic"
        
        case thin = "Thin"
        case thinItalic = "ThinItalic"
        
        case black = "Black"
        case blackItalic = "BlackItalic"
        
        case hairline = "Hairline"
        case hairlineItalic = "HairlineItalic"
        
        case heavy = "Heavy"
        case heavyItalic = "HeavyItalic"
    }
    
    enum FontSize {
        case standard(StandardSize)
        case custom(CGFloat)
        var value: CGFloat {
            switch self {
            case .standard(let size):
                return size.rawValue
            case .custom(let customSize):
                return customSize
            }
        }
    }
    
    enum StandardSize: CGFloat {
        case h1 = 20.0
        case h2 = 18.0
        case h3 = 16.0
        case h4 = 14.0
        case h5 = 12.0
        case h6 = 10.0
    }
    
    var type: FontType
    var size: FontSize
    
    init(_ type: FontType, size: FontSize) {
        self.type = type
        self.size = size
    }
}

extension FontManager {
    
    var instance: UIFont {
        
        var instanceFont: UIFont!
        
        switch type {
            
        case .custom(let fontName):
            guard let font =  UIFont(name: fontName, size: size.value) else {
                fatalError("\(fontName) font is not installed.")
            }
            instanceFont = font
            
        case .installed(let fontStyle):
            
            guard let font =  UIFont(name: "\(AppFontFamily.rawValue)-\(fontStyle.rawValue)", size: size.value) else {
                fatalError("\(AppFontFamily.rawValue)-\(fontStyle.rawValue) font is not installed.")
            }
            instanceFont = font
            
        case .system:
            instanceFont = UIFont.systemFont(ofSize: CGFloat(size.value))
        case .systemBold:
            instanceFont = UIFont.boldSystemFont(ofSize: CGFloat(size.value))
        case .systemItatic:
            instanceFont = UIFont.italicSystemFont(ofSize: CGFloat(size.value))
        }
        
        return instanceFont
    }
    
    /* Usage Examples
     
     let system12            = Font(.system, size: .standard(.h5)).instance
     let robotoThin20        = Font(.installed(.RobotoThin), size: .standard(.h1)).instance
     let robotoBlack14       = Font(.installed(.RobotoBlack), size: .standard(.h4)).instance
     let helveticaLight13    = Font(.custom("Helvetica-Light"), size: .custom(13.0)).instance
     
     */
}
