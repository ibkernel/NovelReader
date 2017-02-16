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
    var selectedChapterTitle: String!
    
    func refresh(sender: AnyObject) {
        print("refreshing table")
        bookInfo.getBookChapterList(url: bookInfo.bookUrl){ chapterInfo in
            self.chapters = chapterInfo
            self.chapterListTable.reloadData()
            print("refreshed")
            self.refreshControl?.endRefreshing()
            
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("In tableContentView")
        print("message sent from previous controller: \(bookInfo.bookUrl)")

        bookInfo.getBookChapterList(url: bookInfo.bookUrl){ chapterInfo in
            self.chapters = chapterInfo
            self.chapterListTable.reloadData()
        }
        self.refreshControl?.addTarget(self, action: #selector(self.refresh), for: UIControlEvents.valueChanged)
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.chapterListTable.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterContentSegue" {
            let secondViewController = segue.destination as! BookContentViewController
            secondViewController.chapterUrl = selectedChapter
            secondViewController.bookInfo = bookInfo
            secondViewController.chapterTitle = selectedChapterTitle
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chapters.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Table content:::You clicked me at \(indexPath.row)")
        if (UserDefaults.standard.bool(forKey: "isReverseChapterList")) {
            selectedChapter = chapters[chapters.count - indexPath.row - 1].url as NSString!
            selectedChapterTitle = chapters[chapters.count - indexPath.row - 1].text
        }else {
            selectedChapter = chapters[indexPath.row].url as NSString!
            selectedChapterTitle = chapters[indexPath.row].text
        }
        
        self.performSegue(withIdentifier: "showChapterContentSegue", sender: self)
        
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        self.chapterListTable.rowHeight = 44
        let cell: UITableViewCell
        var chapterTitle: String!
        if (UserDefaults.standard.bool(forKey: "isReverseChapterList")) {
            chapterTitle = chapters[chapters.count - indexPath.row - 1].text
        }else {
            chapterTitle = chapters[indexPath.row ].text
        }
        cell = tableView.dequeueReusableCell(withIdentifier: "chapterTitleCell", for: indexPath)
        
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
