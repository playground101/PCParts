//
//  ProductTableViewController.swift
//  PcParts
//
//  Created by user141824 on 11/17/19.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit

protocol ProductTableViewControllerDelgate: class {
    func select(productName:String, selected:Bool)
}
class ProductTableViewController: UITableViewController {
    var category: Category?
    weak var delegate: ProductTableViewControllerDelgate?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return category?.detail.count ?? 0
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "productCell", for: indexPath) as! PCTableViewCell
        cell.productDetail = category?.detail[indexPath.row]
        cell.productName.text = category?.detail[indexPath.row].title
        cell.productDescription.text = category?.detail[indexPath.row].description
    
        cell.productImage.image = UIImage(named: category?.detail[indexPath.row].image ?? "case")
        cell.productLink.text = category?.detail[indexPath.row].link
        cell.productPrice.text = category?.detail[indexPath.row].price
        cell.productSelected.isOn = category?.detail[indexPath.row].selected ?? false
        cell.delegate = self
        
        return cell
    }
    
}
extension ProductTableViewController: PCTableViewCellDelegate {
    func selectProduct(productName: String, selected: Bool) {
        delegate?.select(productName: productName, selected: selected)
    }
    
}
