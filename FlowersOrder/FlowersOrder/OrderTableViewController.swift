//
//  OrderTableViewController.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit
import Alamofire

class DetailTableViewCell : UITableViewCell {
    @IBOutlet weak var detailTypeLabel: UILabel!
    @IBOutlet weak var detailValueLabel: UILabel!
}

enum DetailSections: Int {
    case DetailSectionData = 0
    case DetailSectionAction // 1
    case DetailSectionLast
}

enum SectionData: Int {
    case SectionDataOrderDetails = 0
    case SectionDataOrderPrice // 1
    case SectionDataOrderOwner
    case SectionDataOrderAddress
    case SectionDataOrderState
    case SectionDataLast
}

class OrderTableViewController: UITableViewController  {
    
    @IBOutlet var orderImgView: UIImageView!
    
    var request: Request?
    
    var order : Order?
    let dataTitles = [ ["Order", "Price", "Owner", "Address", "State"], ["Deliver"] ]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let image = OrdersManager.shared().cachedImage(for: (self.order?.imageUrl)!) {
            self.orderImgView.image = image
            return
        }
        request = OrdersManager.shared().retrieveImage(for: (self.order?.imageUrl)!) { image in
            self.orderImgView.image = image
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return DetailSections.DetailSectionLast.rawValue
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == DetailSections.DetailSectionData.rawValue {
            return SectionData.SectionDataLast.rawValue
        } else if (self.order?.delivered == false) {
            return 1
        }
        return 0
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case DetailSections.DetailSectionData.rawValue:
            do {
                let title = dataTitles[indexPath.section][indexPath.row] as String
                var value: String?
                switch indexPath.row {
                case SectionData.SectionDataOrderDetails.rawValue :
                    value = self.order?.orderDescription
                    break
                case SectionData.SectionDataOrderPrice.rawValue :
                    value = "\(self.order?.price ?? 0) euro"
                    break
                case SectionData.SectionDataOrderOwner.rawValue :
                    value = self.order?.deliverTo
                case SectionData.SectionDataOrderAddress.rawValue :
                    value = self.order?.address
                case SectionData.SectionDataOrderState.rawValue :
                    if (self.order?.delivered == false) {
                        value = "In progress"
                    } else {
                        value = "Delivered"
                    }
                default:
                    break
                }
                guard let cell = tableView.dequeueReusableCell(withIdentifier: "detailCell", for: indexPath) as? DetailTableViewCell  else {
                    fatalError("The dequeued cell is not an instance of OrderTableViewCell.")
                }
                cell.detailTypeLabel.text = title
                cell.detailValueLabel.text = value
                
                return cell
            }
        case DetailSections.DetailSectionLast.rawValue:
            do {
                let cell = tableView.dequeueReusableCell(withIdentifier: "deliverCell", for: indexPath)
                cell.textLabel?.text = dataTitles[indexPath.section][indexPath.row]
                return cell
            }
        default:
            break
        }
        
       let cell = tableView.dequeueReusableCell(withIdentifier: "deliverCell", for: indexPath)

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if (indexPath.section == DetailSections.DetailSectionAction.rawValue && indexPath.row == 0) {
            self.order?.delivered = true;
            self.tableView.reloadData()
            OrdersManager.shared().updateOrderState(orderId: (self.order?.orderId)!)
        }
        
    }
}
