//
//  OrderTableViewCell.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit

class OrderTableViewCell: UITableViewCell {
    
    @IBOutlet weak var orderDescriptionLabel: UILabel!
    @IBOutlet weak var orderPriceLabel: UILabel!
    @IBOutlet weak var deliverToLabel: UILabel!
    @IBOutlet weak var statusImg: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateWithOrder(order :Order) {
        self.orderDescriptionLabel.text = order.orderDescription as String
        self.orderPriceLabel.text = "\(order.price) euro"
        self.deliverToLabel.text = order.deliverTo as String
        
        if order.delivered == true {
            self.statusImg.isHidden = false
        } else {
            self.statusImg.isHidden = true
        }
    }

}
