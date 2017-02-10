//
//  HomeTableViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/6.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class HomeTableViewController: UITableViewController {

    @IBOutlet var BookListTable: UITableView!
    var books: [Book] = [Book]()
    var selectedBook: Book!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in home table view")
        
        BookListTable.estimatedRowHeight = 88
        //BookListTable.separatorColor = UIColor.clear
        BookListTable.separatorStyle = UITableViewCellSeparatorStyle.none
        //BookListTable.rowHeight = UITableViewAutomaticDimension
        
        books.append(UUBook(bookUrl: "http://sj.uukanshu.com/book.aspx?id=39314"))
        books.append(UUBook(bookUrl: "http://sj.uukanshu.com/book.aspx?id=48319"))
        
        for book in books {
            book.setBookInfo(){ bookName in
                self.BookListTable.reloadData()
            }
        }
        
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterListsSegue" {
            let secondViewController = segue.destination as! BookTableContentViewController
            secondViewController.bookInfo = selectedBook
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You clicked me at \(indexPath.row)")
        selectedBook = books[indexPath.row]
        
        self.performSegue(withIdentifier: "showChapterListsSegue", sender: self)
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.BookListTable.rowHeight = 88
        
        let cell: UITableViewCell
        let titleData = books[indexPath.row].bookTitle
        cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        (cell as! BookTitleCell).textLabel?.text = titleData
        //(cell as! BookTitleCell).detailTextLabel?.text = "Author: 作者"
        (cell as! BookTitleCell).imageView?.image = UIImage(named: "test2.jpg")
        
        //var url:NSURL = NSURL(string:"http://img.uukanshu.net/fengmian/2016/4/635965541375948990.jpg")!
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Urls.count
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
