//
//  Cart.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import Foundation

struct Cart {
    
    var title: String?
    var items = [MenuItem]()
    
    var subTotal: Double {
        
        return items.reduce(0, {$0 + $1.totalPrice})
    }
    
    var formattedSubTotal: String {
        
        return String(format: "$%.2f", subTotal)
    }
    
    mutating func addItem(_ item: MenuItem) {
        
        
        if let index = items.firstIndex(where: { (arrayItem) -> Bool in
            return arrayItem.id == item.id
        }) {
            items[index].quantity += 1
        } else {
            var newItem = item
            newItem.quantity = 1
            items.append(newItem)
        }
    }
    
    mutating func removeItem(_ item: MenuItem) {
        
        if let index = items.firstIndex(where: { (arrayItem) -> Bool in
            return arrayItem.id == item.id
        }) {
            if items[index].quantity > 1 {
                items[index].quantity -= 1
            } else {
                items.remove(at: index)
            }
        }
    }
    
    var totalItems: Int {
        
        return items.count
    }
    
    var cartTotal: Double {
        
        var total: Double = 0
        
        items.forEach{ total += $0.price * Double($0.quantity) }
        
        return total
    }
}
