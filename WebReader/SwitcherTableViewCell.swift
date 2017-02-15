//
//  SwitcherTableViewCell.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class SwitcherTableViewCell: UITableViewCell {

    @IBOutlet weak var switcherName: UILabel!
    @IBOutlet weak var switchOption: UISwitch!
    var switcherKey: String!
    
    
    @IBAction func isToggled(_ sender: Any) {
        print("You have toggled me")
        
        switch switcherKey {
        case "isTraditional":
            UserDefaults.standard.set(switchOption.isOn, forKey: switcherKey)
            break
        case "isNightMode":
            UserDefaults.standard.set(switchOption.isOn, forKey: switcherKey)
            switchOption.isOn ? UserDefaults.standard.set("white", forKey: "FontColor") : UserDefaults.standard.set("black", forKey: "FontColor")
            break
        default:
            print("do nothing")
        }

    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }

}
