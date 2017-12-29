//
//  OrderTableViewCell.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit
import Alamofire

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderDescriptionLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet var orderImgView: UIImageView!
    @IBOutlet var loadingIndicator: UIActivityIndicatorView!
    
    var request: Request?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithOrder(order :Order) {
        self.orderImgView.image = nil
        self.request?.cancel()
        self.orderDescriptionLabel.text = order.orderDescription as String
        self.orderPriceLabel.text = "\(order.price) euro"
        self.deliverToLabel.text = order.deliverTo as String
        
        if let image = OrdersManager.shared().cachedImage(for: order.imageUrl!) {
            self.loadingIndicator.stopAnimating()
            self.orderImgView.image = image
            return
        }
        loadingIndicator.startAnimating()
        request = OrdersManager.shared().retrieveImage(for: order.imageUrl!) { image in
            self.loadingIndicator.stopAnimating()
            self.orderImgView.image = image
        }
        
    }

}
