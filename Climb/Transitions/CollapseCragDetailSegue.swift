//
//  CollapseCragDetailSegue.swift
//  Climb
//
//  Created by Noah Kraemer on 20/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class CollapseCragDetailSegue: UIStoryboardSegue {

    var cellIndexPath: IndexPath?
    
    override func perform() {
        // Get required references
        let detailViewController = self.source as! CragDetailViewController
        let listViewController = self.destination as! CragListViewController
        let selectedCell = listViewController.cragTableView.cellForRow(at: self.cellIndexPath!) as! CragTableViewCell
        
        let screenWidth = UIScreen.main.bounds.size.width
        let screenHeight = UIScreen.main.bounds.size.height
        
        var cellAbove: UITableViewCell? = nil
        var cellTwoAbove: UITableViewCell? = nil
        var cellBelow: UITableViewCell? = nil
        var cellTwoBelow: UITableViewCell? = nil
        
        if (cellIndexPath!.row > 0) {
            let indexPath = IndexPath(item: self.cellIndexPath!.row - 1, section: self.cellIndexPath!.section)
            cellAbove = listViewController.cragTableView.cellForRow(at: indexPath)
        }
        
        if (cellIndexPath!.row > 1) {
            let indexPath = IndexPath(item: self.cellIndexPath!.row - 2, section: self.cellIndexPath!.section)
            cellTwoAbove = listViewController.cragTableView.cellForRow(at: indexPath)
        }
        
        var indexPath = IndexPath(item: self.cellIndexPath!.row + 1, section: self.cellIndexPath!.section)
        cellBelow = listViewController.cragTableView.cellForRow(at: indexPath)
        
        indexPath = IndexPath(item: self.cellIndexPath!.row + 2, section: self.cellIndexPath!.section)
        cellTwoBelow = listViewController.cragTableView.cellForRow(at: indexPath)
        
        // Access the app's key window and insert the destination view behind the current (source) one.
        let window = UIApplication.shared.keyWindow
        window?.insertSubview(listViewController.view, aboveSubview: detailViewController.view)
        
        // Create gradient view to emulate crag cell gradient
        let tempGradientView = GradientView()
        tempGradientView.startColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0)
        tempGradientView.endColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.75)
        tempGradientView.fadeStartLocation = 0.5
        tempGradientView.fadeEndLocation = 1
        tempGradientView.frame = CGRect(x: 0, y: 125, width: screenWidth, height: 250)
        detailViewController.topPanel.insertSubview(tempGradientView, at: 1)
        
        // Calculate y offset
        let yOffset = selectedCell.frame.minY - listViewController.cragTableView.contentOffset.y
        
        // Store positions
        let cellAboveFrame = cellAbove?.frame
        let cellTwoAboveFrame = cellTwoAbove?.frame
        let cellBelowFrame = cellBelow?.frame
        let cellTwoBelowFrame = cellTwoBelow?.frame
        
        // Move components to starting positions
        if (cellAbove != nil) {
            cellAbove!.frame = cellAboveFrame!.offsetBy(dx: 0, dy: -yOffset)
        }
        if (cellTwoAbove != nil) {
            cellTwoAbove!.frame = cellTwoAboveFrame!.offsetBy(dx: 0, dy: -yOffset)
        }
        if (cellBelow != nil) {
            cellBelow!.frame = cellBelowFrame!.offsetBy(dx: 0, dy: screenHeight - yOffset)
        }
        if (cellTwoBelow != nil) {
            cellTwoBelow!.frame = cellTwoBelowFrame!.offsetBy(dx: 0, dy: screenHeight - yOffset)
        }
        
        selectedCell.isHidden = true
        detailViewController.backButton.alpha = 1
        
        // Animate the transition.
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
            
            detailViewController.topPanel.transform = CGAffineTransform(translationX: 0, y: yOffset)
            detailViewController.bottomPanel.transform = CGAffineTransform(translationX: 0, y: yOffset + 60)
            detailViewController.gutterPanel.transform = CGAffineTransform(translationX: 0, y: 125)
            detailViewController.bottomGradientView.transform = CGAffineTransform(translationX: 0, y: 125)
            detailViewController.topGradientView.transform = CGAffineTransform(translationX: 0, y: -100)
            detailViewController.cragTitleLabel.transform = CGAffineTransform(translationX: 0, y: 170)
            detailViewController.backButton.transform = CGAffineTransform(translationX: 0, y: 170)
            
            tempGradientView.transform = CGAffineTransform(translationX: 0, y: -125)
            
            detailViewController.backButton.alpha = 0
            
            if (cellAbove != nil) {
                cellAbove!.frame = cellAboveFrame!
            }
            if (cellTwoAbove != nil) {
                cellTwoAbove!.frame = cellTwoAboveFrame!
            }
            if (cellBelow != nil) {
                cellBelow!.frame = cellBelowFrame!
            }
            if (cellTwoBelow != nil) {
                cellTwoBelow!.frame = cellTwoBelowFrame!
            }
        }) { (Finished) -> Void in
            selectedCell.isHidden = false
            tempGradientView.removeFromSuperview()
            self.source.dismiss(animated: false, completion: nil)
        }
    }
}
