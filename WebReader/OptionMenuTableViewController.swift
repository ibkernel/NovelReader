//
//  OptionMenuTableViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit


class OptionMenuTableViewController: UITableViewController {
    
    // initialize 2d array, change count to 2 if new section needed
    var UserOptions: [[Options]] = Array(repeating: [], count: 1)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let isNightMode: Bool! = UserDefaults.standard.bool(forKey: "isNightMode")
        let isTraditional: Bool! = UserDefaults.standard.bool(forKey: "isTraditional")
        let isReverseChapterList: Bool! = UserDefaults.standard.bool(forKey: "isReverseChapterList")
        UserOptions[0].append(PickerOptions("字體顏色", fontColorOptions, keyName: "FontColor"))
        UserOptions[0].append(PickerOptions("字體大小", fontSizeOptions, keyName: "FontSize"))
        UserOptions[0].append(SwitcherOptions("轉成繁體", isTraditional, keyName: "isTraditional"))
        UserOptions[0].append(SwitcherOptions("夜間模式", isNightMode, keyName: "isNightMode"))
        UserOptions[0].append(SwitcherOptions("目錄倒序", isReverseChapterList, keyName: "isReverseChapterList"))
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()

        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return UserOptions[section].count
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
        case 0:
            return "閱讀設定"
        case 1:
            return "通知設定"
        default:
            return "其他設定"
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let optionDataType = UserOptions[indexPath.section][indexPath.row].type
        switch optionDataType {
        case .picker:
            return 88
        case .switcher:
            return 44
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell
        
        let optionData = UserOptions[indexPath.section][indexPath.row]
        
        switch optionData.type {
        case .picker:
            cell = tableView.dequeueReusableCell(withIdentifier: "pickerOptionCell", for: indexPath)
            (cell as! PickerTableViewCell).pickerName.text = optionData.optionName
            (cell as! PickerTableViewCell).pickerName.sizeToFit()
            (cell as! PickerTableViewCell).pickerOptions = (optionData as! PickerOptions).value
            (cell as! PickerTableViewCell).pickerKey = optionData.keyName
            let (currentOption, arrayOption) = getParameters(keyName: optionData.keyName!)
            (cell as! PickerTableViewCell).picker.reloadAllComponents()
            (cell as! PickerTableViewCell).picker.selectRow(getAtRowNum(currentOption: currentOption, arrayOption: arrayOption), inComponent: 0, animated: false)
            
            break;
        case .switcher:
            cell = tableView.dequeueReusableCell(withIdentifier: "switcherOptionCell", for: indexPath)
            (cell as! SwitcherTableViewCell).switcherName.text = optionData.optionName
            (cell as! SwitcherTableViewCell).switcherName.sizeToFit()
            (cell as! SwitcherTableViewCell).switcherKey = optionData.keyName
            (cell as! SwitcherTableViewCell).switchOption.isOn = (optionData as! SwitcherOptions).value
            break;
        }
        
        return cell
    }
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
