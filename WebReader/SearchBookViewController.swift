//
//  SearchBookViewController2.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class SearchBookViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet weak var SearchBar: UISearchBar!
    
    var url1 = "https://cse.google.com/cse?cx=008945028460834109019%3Akn_kwux2xms&q=no#gsc.tab=0&gsc.q="
    var url2 = "&gsc.sort="
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        SearchBar.placeholder = "搜尋書名"
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("user submitting")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print("!User submitted")
//        print(SearchBar.text!)
//        if let encoded = SearchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
//            let url = url1 + encoded + url2
//            getBookList(url:url)
//        }
        getBookList(url: "https://cse.google.com/cse?cx=008945028460834109019%3Akn_kwux2xms&q=%E7%BE%8E%E9%A3%9F%E4%BE%9B%E5%BA%94%E5%95%86#gsc.tab=0&gsc.q=%E7%BE%8E%E9%A3%9F%E4%BE%9B%E5%BA%94%E5%95%86&gsc.page=1")
        
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("User submitted")
        //print(SearchBar.text!)
    }
    
    
    
    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

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


