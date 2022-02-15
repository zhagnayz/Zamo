//
//  AppDataManager.swift
//  Zamo
//
//  Created by Macbook Pro on 2/13/22.
//

import Foundation

class AppDataManager{
    
    static let shared = AppDataManager()
    
    var restauarants: [Restaurant]
    
    var user = User(){
        
        didSet{
            
            NotificationCenter.default.post(name: AppDataManager.orderUpdateNotification, object: nil)
        }
    }
    
    static let orderUpdateNotification = Notification.Name("orderUpdated")
    
    private init(){
        
        guard let dataURL = Bundle.main.url(forResource: "Response", withExtension: "json") else {fatalError("Unable to locate file")}
        
        guard let data = try? Data(contentsOf: dataURL) else {fatalError("Unable to load Response")}
        
        guard let jsonData = try? JSONDecoder().decode([Restaurant].self, from: data) else {fatalError("Unable to decode Response")}
        
        restauarants = [Restaurant]()
        
        
        restauarants = jsonData
        
    }
}
