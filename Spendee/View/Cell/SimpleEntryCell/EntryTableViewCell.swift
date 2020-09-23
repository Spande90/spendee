//
//  EntryTableViewCell.swift
//  Spendee
//
//  Created by Siddharth on 7/29/19.
//  Copyright © 2019 TechnoPear. All rights reserved.
//

import UIKit

class EntryTableViewCell: UITableViewCell {

    @IBOutlet weak var lblAmount1:UILabel!
    @IBOutlet weak var lblAmount2:UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureDataForCell(entry:Entry,selectedMode:String){
        if entry.Operation == "+"{
            print("Entry Amount: \(Int(entry.Amount)?.delimiter)")
            self.lblAmount2.text = String("\(Defaults.rupee) \(entry.Amount)")
            //String("-\(Defaults.rupee)\(String(Int(entry.Amount)?.delimiter ?? "0.00").description)")
            self.lblAmount2.isHidden = false
            self.lblAmount1.isHidden = true
        }else{
             self.lblAmount1.text = String("\(Defaults.rupee) \(entry.Amount)")
                //String("+\(Defaults.rupee)\(String(Int(entry.Amount)?.delimiter ?? "0.00").description)")
            self.lblAmount2.isHidden = true
            self.lblAmount1.isHidden = false
        }
    }
    
}
extension Int {
    private static var numberFormatter: NumberFormatter = {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 2
        numberFormatter.minimumFractionDigits = 0
        return numberFormatter
    }()
    
    var delimiter: String {
        return Int.numberFormatter.string(from: NSNumber(value: self)) ?? ""
    }
}
