//
//  MenuItem.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import Foundation

struct MenuItem: Codable,Hashable {
    
    let id: Int
    let name: String
    let price: Double
    let details: String
    let image: String
    var quantity: Int
    
    let protein: [Protein]
    let garnishes: [Garnishes]
    
    var totalPrice: Double {
        
        return (price*Double(quantity))
    }
    
    var formattedPrice: String {
        
        return String(format: "( $%.2f )", price)
    }
    
    var formattedQuantity: String {
        
        return String(format: "x %d", quantity)
    }
    
    var formattedTotalPrice: String {
        
        return String(format: "$%.2f", totalPrice)
    }
    
    init(id:Int,name:String,price:Double,details:String,image:String,quantity:Int,protein:[Protein],garnishes:[Garnishes]){
        
        self.id = id
        self.name = name
        self.price = price
        self.details = details
        self.image = image
        self.quantity = quantity
        self.protein = protein
        self.garnishes = garnishes
    }
    
    init?(from restaurant:Restaurant,itemIndex index:Int){
        
        guard index < restaurant.menuItem.count else {return nil}
        
        let source = restaurant.menuItem[index]
        
        self.init(id: source.id, name: source.name, price: source.price, details: source.details, image: source.image, quantity: source.quantity, protein: source.protein, garnishes: source.garnishes)
    }
}
