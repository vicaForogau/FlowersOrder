//
//  OrdersTableViewController.swift
//  FlowersOrder
//
//  Created by Vica Forogau on 28/12/2017.
//  Copyright © 2017 Vica Forogau. All rights reserved.
//

import UIKit

class OrdersTableViewController: UITableViewController, OrdersManagerProtocol {
    
    
    var orders = [Order]()

    override func viewDidLoad() {
        super.viewDidLoad()

        OrdersManager.shared().delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.orders.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let order = orders[indexPath.row]
        var cellIdentifier = "orderTableViewCell"
        if order.delivered == true {
            // if the order is delivered display different
            cellIdentifier = "orderDeliveredTableViewCell"
        }
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? OrderTableViewCell  else {
            fatalError("The dequeued cell is not an instance of OrderTableViewCell.")
        }
        cell.updateWithOrder(order:order)

        return cell
    }
    
    func didUpdatedOrders(orders:NSArray) {
        OperationQueue.main.addOperation({
            self.orders = OrdersManager.shared().orders
            self.tableView.reloadData()
        })
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        (segue.destination as! OrderTableViewController).order = self.orders[self.tableView.indexPathsForSelectedRows![0].row]
    }

}
