//
//  File.swift
//  Status Bank
//
//  Created by admin on 4/14/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit

struct HomeData : Codable {
    var message : String?
    var status : String?
    var data : [Homedatadic]?
}

struct Homedatadic : Codable {
    var post_decription : String?
    var post_file : String?
    var post_id : String?
    var post_title : String?
    var post_type : String?
    
}


 var postcatid = ""

