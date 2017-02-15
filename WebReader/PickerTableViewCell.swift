//
//  PickerCellTableViewCell.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class PickerTableViewCell: UITableViewCell {

    var pickerOptions: [String?]!
    var pickerKey: String!
    @IBOutlet weak var pickerName: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    
    
    //@IBOutlet weak var pickerOptions: UIPickerView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        picker.delegate = self
        picker.dataSource = self
        print("initialized!")

    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

extension PickerTableViewCell: UIPickerViewDataSource {
    
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if (pickerOptions != nil){
            return pickerOptions.count
        }
        return 0
    }
}

extension PickerTableViewCell: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?
    {
        if (pickerOptions == nil){
            return nil
        }else {
            return pickerOptions[row]
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        UserDefaults.standard.set(pickerOptions[row], forKey: pickerKey)
        print("Changed Successfully", row)
    }
}
