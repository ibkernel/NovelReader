//
//  BookContentViewController.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/6.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class BookContentViewController: UIViewController {

    @IBOutlet weak var chapterContentText: UITextView!
    var chapterUrl : NSString!
    var bookInfo : Book!
    var selectedBook: Book!
    
    @IBAction func returnToChapterList(_ sender: Any) {
        print("You have returned!")
        if let navController = self.navigationController {
            navController.popViewController(animated: true)
        }
    }
    
//    @IBAction func handlePanGesture(_ gestureRecognizer: UIPanGestureRecognizer) {
//        if gestureRecognizer.state == .began || gestureRecognizer.state == .changed {
//            
//            let translation = gestureRecognizer.translation(in: self.view)
//            // note: 'view' is optional and need to be unwrapped
//            gestureRecognizer.view!.center = CGPoint(x: gestureRecognizer.view!.center.x + translation.x, y: gestureRecognizer.view!.center.y + translation.y)
//            gestureRecognizer.setTranslation(CGPoint.zero, in: self.view)
//        }
//        
//    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //self.navigationController?.isNavigationBarHidden = true
        //self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: #selector(self.handleSwipeGesture))
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = true
        chapterContentText.isEditable = false
        chapterContentText.backgroundColor = UIColor.black
        chapterContentText.textColor = UIColor.white
        chapterContentText.font = UIFont(name: (chapterContentText?.font?.fontName)!, size: 24)
        // Do any additional setup after loading the view.
        print(chapterUrl)
        let methodStart = Date()
        print("Starting: \(methodStart)");
        getChapterContent(url: chapterUrl as String){ content in
            self.chapterContentText.text = content
            let methodFinish = Date()
            let executionTime = methodFinish.timeIntervalSince(methodStart)
            print("Execution time: \(executionTime)")
            
        }
        
        // Do any additional setup after loading the view.
    }

   // func handleSwipeGesture(gesture: UIGestureRecognizer) -> Void {
        /*if(gesture.state == UIGestureRecognizerState.began) {
            print("some gesture here")
        }else {
            //print("???123123?????")
        }*/
    //}
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // hide status bar only on this screen
    override var prefersStatusBarHidden: Bool {
        return true
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
