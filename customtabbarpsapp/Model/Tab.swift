//
//  Tab.swift
//  customtabbarpsapp
//
//  Created by Иван Чернокнижников on 13.06.2024.
//

import Foundation

// Enum tab cases
// Raw value asset, image, name


enum Tab: String, CaseIterable {
    case play = "Play"
    case explore = "Explore"
    case store = "Store"
    case library = "Library"
    case search = "Search"
    
    var index: CGFloat {
        return CGFloat(Tab.allCases.firstIndex(of: self) ?? 0)
    }
    
    static var count: CGFloat {
        return CGFloat(Tab.allCases.count)
    }
}
