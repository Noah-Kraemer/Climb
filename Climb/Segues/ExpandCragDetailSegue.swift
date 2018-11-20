//
//  ExpandCragDetailSegue.swift
//  Climb
//
//  Created by Noah Kraemer on 18/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class ExpandCragDetailSegue: UIStoryboardSegue {
    
    var cellIndexPath: IndexPath?
    
    override func perform() {
        // Get required references
        let listViewController = self.source as! CragListViewController
        let detailViewController = self.destination as! CragDetailViewController
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
        window?.insertSubview(detailViewController.view, belowSubview: listViewController.view)
        detailViewController.view.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
        
        // Calculate y offset
        let yOffset = selectedCell.frame.minY - listViewController.cragTableView.contentOffset.y
        
        // Store destination positions
        let topPanelFrame = detailViewController.topPanel.frame
        let bottomPanelFrame = detailViewController.bottomPanel.frame
        let gutterPanelFrame = detailViewController.gutterPanel.frame
        let gradientViewFrame = detailViewController.gradientView.frame
        let cragNameLabelFrame = detailViewController.cragTitleLabel.frame
        let backButtonFrame = detailViewController.backButton.frame
        
        let cellAboveFrame = cellAbove?.frame
        let cellTwoAboveFrame = cellTwoAbove?.frame
        let cellBelowFrame = cellBelow?.frame
        let cellTwoBelowFrame = cellTwoBelow?.frame
        
        // Move components to starting positions
        detailViewController.topPanel.frame = detailViewController.topPanel.frame.offsetBy(dx: 0, dy: yOffset)
        detailViewController.bottomPanel.frame = detailViewController.bottomPanel.frame.offsetBy(dx: 0, dy: yOffset + 60)
        detailViewController.gutterPanel.frame = detailViewController.gutterPanel.frame.offsetBy(dx: 0, dy: 60)
        detailViewController.gradientView.frame = detailViewController.gradientView.frame.offsetBy(dx: 0, dy: 60)
        detailViewController.cragTitleLabel.frame = detailViewController.cragTitleLabel.frame.offsetBy(dx: 0, dy: 160)
        detailViewController.backButton.frame = detailViewController.backButton.frame.offsetBy(dx: 0, dy: 160)
        
        // Bring relevant views to front
        window?.bringSubviewToFront(listViewController.view)
        
        selectedCell.isHidden = true
        detailViewController.backButton.alpha = 0
        
        // Animate the transition.
        UIView.animate(withDuration: 0.6, animations: { () -> Void in
    
            detailViewController.topPanel.frame = topPanelFrame
            detailViewController.bottomPanel.frame = bottomPanelFrame
            detailViewController.gutterPanel.frame = gutterPanelFrame
            detailViewController.gradientView.frame = gradientViewFrame
            detailViewController.cragTitleLabel.frame = cragNameLabelFrame
            detailViewController.backButton.frame = backButtonFrame
            
            detailViewController.backButton.alpha = 1
            
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
            
        }) { (Finished) -> Void in
            self.source.present(self.destination as UIViewController, animated: false, completion: {
                selectedCell.isHidden = false
                
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
            })
        }
    }
}
