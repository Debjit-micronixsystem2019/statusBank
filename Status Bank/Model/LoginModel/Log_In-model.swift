//
//  File.swift
//  Status Bank
//
//  Created by admin on 4/12/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit


struct loginData : Codable{
    var data : datadic?
}
struct datadic : Codable{
    var message : String?
    var status : String?
    var user_name : String?
    var email : String?
    var user_id : String?

}
/*enum jsonDataa : String, CodingKey {
    case message = "a"
    case status = "b"
    case user_name = "c"
    case email = "d"
    case user_id = "e"
}*/
//Refer:- https://www.appcoda.com/json-codable-swift/
 var store_User_id : String = ""

