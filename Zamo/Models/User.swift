//
//  User.swift
//  Zamo
//
//  Created by Macbook Pro on 2/14/22.
//

import Foundation

struct User {
    
    var cart = Cart()
    var restaurantsLastViewed = [Restaurant]()
    var orderHistory = [Order]()
    
    mutating func saveViewedRestaurant(_ restaurant: Restaurant) -> Void {

        if let existingIndex = restaurantsLastViewed.firstIndex(where: { (element) -> Bool in
                return (element.name == restaurant.name)
            }) {
                restaurantsLastViewed.remove(at: existingIndex)
            }

            restaurantsLastViewed.insert(restaurant, at: 0)

            // Store only the last 3 viewed restaurants
            if restaurantsLastViewed.count > 3 {
                restaurantsLastViewed = Array(restaurantsLastViewed.prefix(upTo: 3))
            }
        }

        mutating func saveOrder(_ newOrder: Order) -> Void {

            orderHistory.insert(newOrder, at: 0)

            // Store only the last 10 orders
            if orderHistory.count > 10 {
                orderHistory = Array(orderHistory.prefix(upTo: 10))
            }

            // Wipe off the Cart
            cart = Cart(title: nil, items: [MenuItem]())
        }

}
