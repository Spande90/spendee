//
//  KeyboardCollCell.swift
//  Spendee
//
//  Created by Siddharth on 7/26/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import UIKit

class KeyboardCollCell: UICollectionViewCell {

    @IBOutlet weak var lblKeyboardName:UILabel!
    @IBOutlet weak var imgKeyboard:UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configureCell(value:String)
    {
        if value == "x"
        {
            self.imgKeyboard.isHidden = false
            self.lblKeyboardName.isHidden = true
        }
        else
        {
            self.imgKeyboard.isHidden = true
            self.lblKeyboardName.isHidden = false
            self.lblKeyboardName.text = value
        }
        
    }

}
