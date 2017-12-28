//
//  OrderTableViewController.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit

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

class OrderTableViewController: UITableViewController {
    
    var order : Order?
    let dataTitles = [ ["Order", "Price", "Owner", "Address", "State"], ["Deliver"] ]

    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
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


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
