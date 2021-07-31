//
//  Catagory-model.swift
//  Status Bank
//
//  Created by admin on 4/13/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit


struct CatagoryData : Codable {
    var message : String?
    var status : String?
    var data : [Catagorydatadic]?
}

struct Catagorydatadic : Codable {
    var category_title : String?
    var post_cat_id : String?
    
}
