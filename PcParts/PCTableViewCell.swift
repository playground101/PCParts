//
//  PCTableViewCell.swift
//  PcParts
//
//  Created by user141824 on 11/10/19.
//  Copyright © 2019 Playground. All rights reserved.
//

import UIKit
protocol PCTableViewCellDelegate: class {
    func selectProduct(productName:String, selected:Bool)
}
class PCTableViewCell: UITableViewCell {
    
    var productDetail: ProductDetail?
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productDescription: UILabel!
    @IBOutlet weak var productLink: UITextView!
    weak var delegate: PCTableViewCellDelegate?
    
    @IBAction func handleSelectedSwitch(_ sender: UISwitch) {
        if let product = productDetail {
            delegate?.selectProduct(productName: product.title, selected: sender.isOn)
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
