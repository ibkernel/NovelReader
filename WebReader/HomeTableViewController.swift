//
//  HomeTableViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/6.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit
import CoreData

class HomeTableViewController: UITableViewController {

    @IBOutlet var BookListTable: UITableView!
    var books: [Book] = [Book]()
    var bkList: [String] = []
    var selectedBook: Book!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("in home table view")
        let searchBookButton = UIBarButtonItem(title: "搜尋", style: UIBarButtonItemStyle.done, target: self, action: #selector(HomeTableViewController.goToSearch(sender:)))
        self.navigationItem.rightBarButtonItem = searchBookButton
        
        BookListTable.estimatedRowHeight = 88
        //BookListTable.separatorColor = UIColor.clear
        BookListTable.separatorStyle = UITableViewCellSeparatorStyle.none

        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func viewWillAppear(_ animated: Bool) {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
        do {
            let results = try context.fetch(fetchRequest)
            print("num of results = \(results.count)")
            if results.count > 0 {
                for result in results as [NSManagedObject] {
                    print("\(result.value(forKey:"bookTitle") as! String), \(result.value(forKey: "bookUrl") as! String)")
                    
                    if (bkList.contains(result.value(forKey: "bookTitle") as! String)){
                        continue
                    }else {
                        books.append(DemoBook(bookUrl: result.value(forKey: "bookUrl") as! String, bookTitle: result.value(forKey: "bookTitle") as! String))
                        bkList.append(result.value(forKey: "bookTitle") as! String)
                    }
                }
            }
        }catch {
            print("Error : \(error)")
        }
        
        self.BookListTable.reloadData()
        
    }
    
    func goToSearch(sender: UIBarButtonItem) {
        print("In goToSearch")
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "SearchBook") as! SearchBookViewController
        vc.bkList = self.bkList
        navigationController?.pushViewController(vc,animated: true)
        
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
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
            let fetchRequest: NSFetchRequest<BookList> = BookList.fetchRequest()
            do {
                let results = try context.fetch(fetchRequest)
                for result in results as [NSManagedObject] {
                    print("\(result.value(forKey:"bookTitle") as! String), \(result.value(forKey: "bookUrl") as! String)")
                    if (result.value(forKey: "bookUrl") as! String == books[indexPath.row].bookUrl){
                        context.delete(result)
                        books.remove(at: indexPath.row)
                        self.BookListTable.reloadData()
                        break
                    }
                }
                
            }catch {
                print("Error : \(error)")
            }
            
            
        }
    }

    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        self.BookListTable.rowHeight = 88
        
        let cell: UITableViewCell
        let titleData = books[indexPath.row].bookTitle
        cell = tableView.dequeueReusableCell(withIdentifier: "bookTitleCell", for: indexPath)
        
        (cell as! BookTitleCell).textLabel?.text = titleData
        (cell as! BookTitleCell).imageView?.image = UIImage(named: "book.png")
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //return core data book count
        return books.count
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
