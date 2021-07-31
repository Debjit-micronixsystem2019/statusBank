//
//  ImageCell.swift
//  Status Bank
//
//  Created by admin on 4/17/20.
//  Copyright © 2020 admin. All rights reserved.
//

import UIKit

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var Img : UIImageView!
    @IBOutlet weak var textLblTitle : UILabel!
    
    
          @IBOutlet weak var favouriteBtn : UIButton!
          @IBOutlet weak var repoprtBtn : UIButton!
          @IBOutlet weak var shareeBtn : UIButton!
          @IBOutlet weak var timeLbl : UILabel!
      
    override func awakeFromNib() {
        super.awakeFromNib()
            }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}
