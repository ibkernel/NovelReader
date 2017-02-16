//
//  SearchBookViewController2.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/12.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit
import CoreData

class SearchBookViewController: UITableViewController, UISearchBarDelegate {

    @IBOutlet var SearchListTable: UITableView!
    @IBOutlet weak var SearchBar: UISearchBar!
    var resultList: [chapterTuple] = []
    var demoUrl = "http://t.hjwzw.com/List/"
    var bkList: [String] = []
    var previewBook : Book!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "線上搜尋"
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
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return resultList.count
    }

    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("user submitting")
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.SearchBar.endEditing(true)
        print("!User submitted")
        print(SearchBar.text!)
        if let encoded = SearchBar.text!.addingPercentEncoding(withAllowedCharacters: .urlFragmentAllowed){
            let url = demoUrl + encoded
            getBookList(url:url){ BookInfo in
                self.resultList = BookInfo
                self.SearchListTable.reloadData()
            }
        }

    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        print("User submitted")
        //print(SearchBar.text!)
    }
    
    // Add already-have checker
    
    override func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        
        if (bkList.contains(resultList[indexPath.row].text!) == false){
            let favorite = UITableViewRowAction(style: .destructive, title: "加入最愛") { action, index in
                let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
                let myEntityName = "BookList"
                let entity =  NSEntityDescription.entity(forEntityName: myEntityName, in: context)
                let bk = NSManagedObject(entity: entity!, insertInto: context)
                bk.setValue(self.resultList[indexPath.row].text, forKey: "bookTitle")
                bk.setValue(self.resultList[indexPath.row].url, forKey: "bookUrl")
                
                //save the object
                do {
                    try context.save()
                    print("saved!")
                } catch let error as NSError  {
                    print("Could not save \(error), \(error.userInfo)")
                } catch {
                    
                }
                let alert = UIAlertController(title: "Favorite", message: "已加入最愛", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .destructive))
                self.present(alert, animated: true)
                tableView.isEditing = false
                self.bkList.append(self.resultList[indexPath.row].text!)
            }
            favorite.backgroundColor = UIColor(red: 255/255, green: 110/255, blue: 50/255, alpha: 1)
            return [favorite]
        }else {
            let favorite = UITableViewRowAction(style: .destructive, title: "已加入最愛") { action, index in
                tableView.isEditing = false
            }
            favorite.backgroundColor = UIColor(red: 255/255, green: 0/255, blue: 0/255, alpha: 1)
            return [favorite]
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseCell", for: indexPath)
        
        cell.textLabel?.text = resultList[indexPath.row].text

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("\(resultList[indexPath.row].text!), \(resultList[indexPath.row].url!)")
        previewBook = DemoBook(bookUrl: resultList[indexPath.row].url!, bookTitle: resultList[indexPath.row].text!)
        self.performSegue(withIdentifier: "previewChapterSegue", sender: self)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "previewChapterSegue" {
            let secondViewController = segue.destination as! BookTableContentViewController
            secondViewController.bookInfo = previewBook
            
        }
    }
    
    
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


