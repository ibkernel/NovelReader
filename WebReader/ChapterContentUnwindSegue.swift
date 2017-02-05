//
//  ChapterContentUnwindSegue.swift
//  WebReader
//
//  Created by Wayne Chang on 2017/2/5.
//  Copyright © 2017年 WayneChang. All rights reserved.
//

import UIKit

class ChapterContentUnwindSegue: UIStoryboardSegue {

    override func perform() {
        // Assign the source and destination views to local variables.
        let firstVCView = self.source.view as UIView!
        let secondVCView = self.destination.view as UIView!
        
        // Get the screen width and height.
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        // Specify the initial position of the destination view.
        secondVCView?.frame = CGRect(x:-screenWidth, y:0,width: screenWidth, height: screenHeight)
        
        
        // Access the app's key window and insert the destination view above the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(secondVCView!, aboveSubview: firstVCView!)
        
        // Animate the transition.
        UIView.animate(withDuration: 0.2, animations: { () -> Void in
            firstVCView?.frame = (firstVCView?.frame.offsetBy(dx: screenWidth, dy: 0.0))!
            secondVCView?.frame = (secondVCView?.frame.offsetBy(dx: screenWidth, dy: 0.0))!
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController,animated: false, completion: nil)
        }
        
    }
    
}
