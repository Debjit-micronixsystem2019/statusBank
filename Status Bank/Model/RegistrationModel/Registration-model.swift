//
//  Registration-model.swift
//  Status Bank
//
//  Created by admin on 4/13/20.
//  Copyright © 2020 admin. All rights reserved.
//

import Foundation
import UIKit


struct RegistrationData : Codable{
    var data : RegistrationDataDic?
}
struct RegistrationDataDic : Codable{
    var message : String?
    var status : String?
    var user_name : String?
    var email : String?
    var user_id : String?

}
