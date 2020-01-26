//
//  PCTableViewController.swift
//  PcParts
//
//  Created by user141824 on 11/3/19.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit

class PCTableViewController: UITableViewController {
    var pcModelArray: [PCModel]?
    var category: Category?
    
    
    @IBAction func handleMyPC(_ sender: Any) {
        let mainStoryboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let selectedProductsViewController =  mainStoryboard.instantiateViewController(withIdentifier: "SelectedProductsViewController") as? SelectedProductsViewController {
            guard var pcModels = pcModelArray else {
                return
            }
            var pcModelIndex = 0
            var categoryIndex = 0
            var productIndex = 0
            var selectedProductDetails:[ProductDetail?] = []
            for pcModel in pcModels {
                //pcModelIndex = 0
                let categories = pcModel.categories
                categoryIndex = 0
                for category in categories {
                    let productDetails = category.detail
                    productIndex = 0
                    for productDetail in productDetails {
                        if productDetail.selected == true {
                            let selectedProductDetail = pcModelArray?[pcModelIndex].categories[categoryIndex].detail[productIndex]
                            selectedProductDetails.append(selectedProductDetail)
                        }
                        productIndex += 1
                    }
                    categoryIndex += 1
                }
                pcModelIndex += 1
            }
            selectedProductsViewController.selectedProductDetails = selectedProductDetails
            present(selectedProductsViewController, animated: true, completion: nil)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPCParts()
    tableView.backgroundView?.backgroundColor = UIColor.black
      //  tableView.backgroundView?.tintColor = UIColor.black
    
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        
        return pcModelArray?.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return pcModelArray?[section].categories.count ?? 0
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "pcPartsCell", for: indexPath) 
        cell.textLabel?.font = UIFont(name: "Futura", size: 18)
        cell.textLabel?.textColor = .black
        // Configure the cell...
        cell.textLabel?.text = pcModelArray?[indexPath.section].categories[indexPath.row].name
        
        cell.textLabel?.numberOfLines = 0
        //let colorView = UIView(frame: cell.frame)
        cell.backgroundColor = UIColor(red: 17/255, green: 138/255, blue: 178/255, alpha: 0.5)
        //cell.selectedBackgroundView = colorView
        
        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pcModelArray?[section].section
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 39/255, green: 71/255, blue: 110/255, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Futura-Bold", size: 20)
    }
}
extension PCTableViewController {
    func loadPCParts() {
        guard let url = Bundle.main.url(forResource: "PCParts", withExtension: "json"),
            let data = try? Data(contentsOf: url)
            else {
                return
        }
        do {
            let model = try JSONDecoder().decode([PCModel].self, from: data)
            self.pcModelArray = model
        } catch {
            print(error)
        }
        print(self.pcModelArray)
    }
}

extension PCTableViewController {
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        category = pcModelArray?[indexPath.section].categories[indexPath.row]
        self.performSegue(withIdentifier: "productSegue", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print("calling segue")
        
        if let destinationController = segue.destination as? ProductTableViewController {
            destinationController.delegate = self
            destinationController.category = category
        }
    }
}
extension PCTableViewController: ProductTableViewControllerDelgate {
    func select(productName: String, selected: Bool) {
        print("product name = \(productName)")
        guard var pcModels = pcModelArray else {
            return
        }
        var pcModelIndex = 0
        var categoryIndex = 0
        var productIndex = 0
        for pcModel in pcModels {
            //pcModelIndex = 0
            let categories = pcModel.categories
            categoryIndex = 0
            for category in categories {
                var productDetails = category.detail
                productIndex = 0
                for productDetail in productDetails {
                    if productDetail.title == productName {
                        pcModelArray?[pcModelIndex].categories[categoryIndex].detail[productIndex].selected = selected
                    }
                    productIndex += 1
                }
                categoryIndex += 1
            }
            pcModelIndex += 1
        }
        
        print(pcModels.first)
        
    }
    
    
}





