//
//  PCModel.swift
//  PcParts
//
//  Created by user141824 on 11/3/19.
//  Copyright © 2019 Playground. All rights reserved.
//

import Foundation

struct PCModel: Decodable {
    var section: String
    var categories: [Category]
}

struct Category: Decodable {
    var name: String
    var detail: [ProductDetail]
}
struct ProductDetail: Decodable {
    var title: String
    var price: String
    var image: String
    var description: String
    var link: String
}
