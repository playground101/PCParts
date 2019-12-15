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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadPCParts()
        let color = UIColor(red: 120/255, green: 50/255, blue: 60/255, alpha: 1)
        tableView.backgroundView?.backgroundColor = color
        tableView.backgroundColor = color

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
        cell.backgroundColor = UIColor(red: 200/255, green: 120/255, blue: 120/255, alpha: 0.3)
        //cell.selectedBackgroundView = colorView

        return cell
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return pcModelArray?[section].section
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        view.tintColor = UIColor(red: 65/255, green: 50/255, blue: 60/255, alpha: 1)
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
        let destinationController = segue.destination as! ProductTableViewController
        destinationController.category = category
        
    }
}

