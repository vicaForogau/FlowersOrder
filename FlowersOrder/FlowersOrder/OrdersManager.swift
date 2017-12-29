//
//  OrdersManager.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import Foundation
import Alamofire
import AlamofireImage

extension UInt64 {
    
    func megabytes() -> UInt64 {
        return self * 1024 * 1024
    }
}

public protocol OrdersManagerProtocol : NSObjectProtocol {
    
    func didUpdatedOrders(orders:NSArray)
}

class OrdersManager {
    
    private static var sharedOrdersManager: OrdersManager = {
        let orderManager = OrdersManager.init()
        return orderManager
    }()
    
    // MARK: -
    let baseURL = "http://demo8679132.mockable.io/getOrders"
    var orders = [Order]()
    var delegate: OrdersManagerProtocol?
    
    let imageCache = AutoPurgingImageCache(
        memoryCapacity: UInt64(100).megabytes(),
        preferredMemoryUsageAfterPurge: UInt64(60).megabytes()
    )
    
    // Initialization
    private init() {
        self.loadOrders()
    }
    
    // MARK: - Accessors
    class func shared() -> OrdersManager {
        return sharedOrdersManager
    }
    
    func loadOrders(){
        
        Alamofire.request(
            URL(string: baseURL)!,
            method: .get)
            .validate()
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    return
                }
                
                guard let value = response.result.value as? [String: Any],
                    let ordersArray = value["orders"] as? NSArray else {
                        print("Malformed data received from fetchAllRooms service")
                        return
                }
                
                for ord in ordersArray {
                    //converting the element to a dictionary
                    if let orderDict = ord as? NSDictionary {
                        if let order = Order.init(data: orderDict) {
                            //adding the order to the array
                            self.orders.append(order)
                        }
                    }
                }
                
                self.delegate?.didUpdatedOrders(orders: self.orders as NSArray)
            }
        }
    
    func updateOrderState(orderId:NSNumber) {
        for order in self.orders {
            if (order.orderId.isEqual(to: orderId)) {
                order.delivered = true
                break
            }
        }
        self.delegate?.didUpdatedOrders(orders: self.orders as NSArray)
    }
    
    //MARK: - Image Downloading
    
    func retrieveImage(for url: String, completion: @escaping (UIImage) -> Void) -> Request {
        return Alamofire.request(url, method: .get).responseImage { response in
            guard let image = response.result.value else { return }
            completion(image)
            self.cache(image, for: url)
        }
    }
    
    //MARK: - Image Caching
    
    func cache(_ image: Image, for url: String) {
        imageCache.add(image, withIdentifier: url)
    }
    
    func cachedImage(for url: String) -> Image? {
        return imageCache.image(withIdentifier: url)
    }
        

}
