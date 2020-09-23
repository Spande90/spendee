//
//  MasterEntryTableCell.swift
//  Spendee
//
//  Created by Siddharth on 7/26/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import UIKit

class MasterEntryTableCell: UITableViewCell {
    
    @IBOutlet weak var cellBackgroundView:UIView!
    @IBOutlet weak var cellSeperator:UIView!
    @IBOutlet weak var lblAmount:UILabel!
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var lblDescription:UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
//    func configureDataForCell(entry:Entry,selectedMode:String){
//        self.lblAmount.text = entry.Amount < 0 ? String("-\(Defaults.rupee)\(entry.Amount)") : String("+\(Defaults.rupee)\(entry.Amount)")
//        self.lblDescription.text = entry.Notes
//        if selectedMode == Mode.darkMode{
//            self.lblTitle.text = entry.Amount < 0 ? "Expense" : "Income"
//            
//            if entry.Amount < 0{
//                self.lblTitle.textColor = UIColor(named: "color_6")
//                self.lblAmount.textColor = UIColor(named: "color_6")
//                self.cellSeperator.backgroundColor = UIColor(named: "color_6")
//            }else{
//                self.lblTitle.textColor = UIColor(named: "color_5")
//                self.lblAmount.textColor = UIColor(named: "color_5")
//                self.cellSeperator.backgroundColor = UIColor(named: "color_5")
//            }
//            self.lblDescription.textColor = UIColor(named: "color_7")
//            self.cellBackgroundView.backgroundColor = UIColor(named: "color_4")
//        }else{
//            self.lblTitle.text = entry.Amount < 0 ? "Expense" : "Income"
//            if entry.Amount < 0{
//                self.lblTitle.textColor = UIColor(named: "color_6")
//                self.lblAmount.textColor = UIColor(named: "color_6")
//                self.cellSeperator.backgroundColor = UIColor(named: "color_6")
//            }else{
//                self.lblTitle.textColor = UIColor(named: "color_5")
//                self.lblAmount.textColor = UIColor(named: "color_5")
//                self.cellSeperator.backgroundColor = UIColor(named: "color_5")
//            }
//            self.lblDescription.textColor = UIColor(named: "color_7")
//            self.cellBackgroundView.backgroundColor = UIColor(named: "color_2")
//        }
//       
//    }
}
