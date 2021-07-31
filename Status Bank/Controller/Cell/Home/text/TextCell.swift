//
//  TextCell.swift
//  Status Bank
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class TextCell: UITableViewCell {
    
    @IBOutlet weak var textLblDescription : UILabel!
    @IBOutlet weak var textLblTitle : UILabel!
       
       
             @IBOutlet weak var favouriteBtn : UIButton!
             @IBOutlet weak var repoprtBtn : UIButton!
             @IBOutlet weak var shareeBtn : UIButton!
             @IBOutlet weak var timeLbl : UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
