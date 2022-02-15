//
//  Restaurant.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import Foundation

struct Restaurant: Codable,Hashable {
    
    let name: String
    let image: String
    let description: String
    let cuisine: String
    let address: String
    let distance: Double
    let reviewRating: Int
    let costRating: Int
    let operationHours: String
    
    let menuItem: [MenuItem]
    
    var formattedDistance: String {
        
        return String(format: "%.2f mi", distance)
    }
}
