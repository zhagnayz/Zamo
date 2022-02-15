//
//  Order.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import Foundation

struct Order: Hashable {
    
    let reference: String
    let title: String
    let date: String
    
    let items: [MenuItem]
    
    var subTotal: Double {
        
        return items.reduce(0, {$0 + $1.totalPrice})
    }
    
    var formattedSubTotal: String {
        
        return String(format: "$%.2f", subTotal)
    }
    
    let deliveryCharge: Double
    
    var formattedDeliveryCharge: String {
        
        return String(format: "$%.2f", deliveryCharge)
    }
    
    var tax: Double{
        
        return (subTotal*0.0875)
    }
    
    var formattedTax: String {
        
        return String(format: "$%.2f", tax)
    }
    
    var grandTotal: Double {
        
        return subTotal + tax + deliveryCharge
    }
    
    var formattedGrandTotal: String {
        
        return String(format: "$%.2f", grandTotal)
    }
    
    init(reference:String?,title:String?,date:String?,deliveryCharge:Double,items:[MenuItem]){
        
        if let orderRef = reference {
            
            self.reference = orderRef
        }else{
            
            self.reference = Order.generateOrderNumber()
        }
        
        if let orderTitle = title {
            
            self.title = orderTitle
        }else{
            
            self.title = "No Title"
        }
        
        if let orderDate = date {
            
            self.date = orderDate
        }else{
            
            let dateFormatter = DateFormatter()
            
            dateFormatter.locale = Locale(identifier: "en_US")
            dateFormatter.setLocalizedDateFormatFromTemplate("MMMdYYYY")
            
            self.date = dateFormatter.string(from: Date())
        }
        
        self.deliveryCharge = deliveryCharge
        self.items = items
    }
    
    init?(cart:Cart,deliveryCharge:Double){
        
        guard cart.items.count > 0 else {return nil}
        
        var items = [MenuItem]()
        
        for item in cart.items {
            
            items.append(item)
        }
        
        self.init(reference: nil, title: nil, date: nil, deliveryCharge: deliveryCharge, items: items)
    }
    
    static func generateOrderNumber() -> String {
        
        func transform(_ source: Double) -> Int {
            
            let a = 89.8
            let b = 39.8
            let c = 83.9
            
            return Int(((source*b)+a)/c)
        }
        
        var firstComponent = Double(arc4random())
        firstComponent.formTruncatingRemainder(dividingBy: 1000)
        
        var secondComponent = Double(arc4random())
        secondComponent.formTruncatingRemainder(dividingBy: 1000)
        
        return "O\(transform(firstComponent))\(transform(secondComponent))"
    }
    
}
