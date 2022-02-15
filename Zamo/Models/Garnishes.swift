//
//  Garnishes.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import Foundation

struct Garnishes: Codable,Hashable {
    
    let name: String
    let price: Double
    
    var isSelected: Bool
    
    var formattedPrice: String {
        
        return String(format: "$%.0f", price)
    }
}
