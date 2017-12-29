//
//  Order.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit

class Order: NSObject {
    var orderId : NSNumber
    var orderDescription: String
    var price : NSNumber
    var deliverTo : String
    var delivered : Bool?
    var address : String
    var imageUrl: String?
    
    init?(data : NSDictionary) {
        
        // The id must not be empty
        guard data["id"] != nil else {
            return nil
        }
        // The description must not be empty
        guard data["description"] != nil else {
            return nil
        }
        // The deliver_to must not be empty
        guard data["deliver_to"] != nil else {
            return nil
        }
        // The address must not be empty
        guard data["address"] != nil else {
            return nil
        }
        
        self.orderId = data["id"] as! NSNumber
        self.orderDescription = data["description"] as! String
        self.price = data["price"] as! NSNumber
        self.deliverTo = data["deliver_to"] as! String
        self.delivered = data["deliverd"] as? Bool
        self.address = data["address"] as! String
        self.imageUrl = data["imgUrl"] as? String
    }
}
