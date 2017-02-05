//
//  ChapterContentViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/5.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class ChapterContentViewController: UIViewController {
    @IBOutlet weak var chapterContentText: UITextView!
    var chapterUrl : NSString!
    var bookInfo : Book!
    var selectedBook: Book!
    
    @IBAction func returnToChapter(_ sender: UISwipeGestureRecognizer) {
        if (sender.direction == UISwipeGestureRecognizerDirection.left)
        {
            print("left")
        }else if sender.direction == .right {
            print("right")
            //self.performSegue(withIdentifier: "", sender: self)
        }else {
            print("other")
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        chapterContentText.isEditable = false
        chapterContentText.font = UIFont(name: (chapterContentText?.font?.fontName)!, size: 24)
        // Do any additional setup after loading the view.
        print(chapterUrl)
        getChapterContent(url: chapterUrl as String){ content in
            self.chapterContentText.text = content
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showChapterContentUnwind" {
            let secondViewController = segue.destination as! TableContentViewController
            secondViewController.bookInfo = selectedBook
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}



