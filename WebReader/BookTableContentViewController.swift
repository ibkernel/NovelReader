//
//  BookTableContentViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/6.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class BookTableContentViewController: UITableViewController {

    @IBOutlet var chapterListTable: UITableView!
    var bookInfo : Book!
    var chapters: [chapterTuple] = []
    var selectedChapter: NSString!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In tableContentView")
        print("message sent from previous controller: \(bookInfo.bookUrl)")
        
        getBookChapterList(url: bookInfo.bookUrl){ chapterInfo in
            self.chapters = chapterInfo
            self.chapterListTable.reloadData()
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterContentSegue" {
            let secondViewController = segue.destination as! BookContentViewController
            secondViewController.chapterUrl = selectedChapter
            secondViewController.selectedBook = bookInfo
            
        }
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
        return chapters.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Table content:::You clicked me at \(indexPath.row)")
        
        selectedChapter = chapters[chapters.count - indexPath.row - 1].url as NSString!
        self.performSegue(withIdentifier: "showChapterContentSegue", sender: self)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.chapterListTable.rowHeight = 44
        
        
        let cell: UITableViewCell
        let chapterTitle = chapters[chapters.count - indexPath.row - 1].text
        //let chapterUrl = chapters[indexPath.row].url
        
        cell = tableView.dequeueReusableCell(withIdentifier: "chapterTitleCell", for: indexPath)
        //let titleData = books[indexPath.row].bookTitle
        //cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        cell.textLabel?.text = chapterTitle
        return cell
        
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
