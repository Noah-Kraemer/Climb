//
//  ClimbPageContentController.swift
//  Climb
//
//  Created by Noah Kraemer on 30/9/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit
import CoreData

class ClimbPageContentController: UIViewController {

    @IBOutlet weak var climbParentView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var gradientView: GradientView!
    @IBOutlet weak var detailScrollView: UIScrollView!
    
    @IBOutlet weak var climbImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var styleImageView: UIImageView!
    @IBOutlet weak var pitchCountImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var pitchCountLabel: UILabel!
    @IBOutlet weak var styleLabel: UILabel!
    
    @IBOutlet weak var infoSummaryViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var scrollViewTopPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradeLabelBottomPaddingConstraint: NSLayoutConstraint!
    @IBOutlet weak var gradeLabelTopPaddingConstraint: NSLayoutConstraint!
    
    var swipeDownGesureRecognizer: UISwipeGestureRecognizer?
    
    var dismissCallback: (() -> Void)?
    
    var fullScreenImage: Bool = false
    
    let maxHeaderHeight: CGFloat = 90
    let minHeaderHeight: CGFloat = 50
    
    let minGradePadding: CGFloat = 0
    let maxGradePadding: CGFloat = 15
    
    var previousScrollOffset: CGFloat = 0
    
    var pageViewIndex: Int?
    var climbImageName: String?
    var style: String?
    var name: String?
    var grade: String?
    var length: String?
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.detailScrollView.delegate = self
        
        climbImageView.image = UIImage.init(named: climbImageName!)
        overlayImageView.image = UIImage.init(named: "overlay_" + climbImageName!)
        styleImageView.image = UIImage.init(named: style!.lowercased() + ".png")
        
        nameLabel.text = name
        gradeLabel.text = grade
        lengthLabel.text = length
        detailLabel.text = detail
        styleLabel.text = style
        
        swipeDownGesureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(self.handleSwipeDown(_:)))
        swipeDownGesureRecognizer?.direction = .down
        
        if (canAnimateHeader(detailScrollView)) {
            overlayImageView.addGestureRecognizer(swipeDownGesureRecognizer!)
        } else {
            climbParentView.addGestureRecognizer(swipeDownGesureRecognizer!)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.infoSummaryViewHeightConstraint.constant = self.maxHeaderHeight
    }
    
    @objc func handleSwipeDown(_ sender: UISwipeGestureRecognizer) {
        self.dismissCallback!()
    }
}

extension ClimbPageContentController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if canAnimateHeader(scrollView) {
            let absoluteTop: CGFloat = 0;
            let absoluteBottom: CGFloat = scrollView.contentSize.height - scrollView.frame.size.height;
            let scrollDiff = scrollView.contentOffset.y - self.previousScrollOffset
            
            let isScrollingDown = scrollDiff > 0 && scrollView.contentOffset.y > absoluteTop
            let isScrollingUp = scrollDiff < 0 && scrollView.contentOffset.y < absoluteBottom
            
            var newHeight = self.infoSummaryViewHeightConstraint.constant
            var newGradePadding = self.gradeLabelTopPaddingConstraint.constant
            
            if isScrollingDown {
                newHeight = max(self.minHeaderHeight, self.infoSummaryViewHeightConstraint.constant - abs(scrollDiff))
                newGradePadding = max(self.minGradePadding, self.gradeLabelTopPaddingConstraint.constant - abs(scrollDiff))
            } else if isScrollingUp {
                newHeight = min(self.maxHeaderHeight, self.infoSummaryViewHeightConstraint.constant + abs(scrollDiff))
                newGradePadding = min(self.maxGradePadding, self.gradeLabelTopPaddingConstraint.constant + abs(scrollDiff))
            }
            
            if newHeight != self.infoSummaryViewHeightConstraint.constant {
                self.infoSummaryViewHeightConstraint.constant = newHeight
                self.gradeLabelTopPaddingConstraint.constant = newGradePadding
                self.gradeLabelBottomPaddingConstraint.constant = newGradePadding
                self.updateHeader()
                self.setScrollPosition(position: self.previousScrollOffset)
            }
            
            self.previousScrollOffset = scrollView.contentOffset.y
        }
    }
    
    func canAnimateHeader(_ scrollView: UIScrollView) -> Bool {
        // Calculate the size of the scrollView when header is collapsed
        let scrollViewMaxHeight = scrollView.frame.height + self.infoSummaryViewHeightConstraint.constant - minHeaderHeight
        
        // Make sure that when header is collapsed, there is still room to scroll
        return scrollView.contentSize.height > scrollViewMaxHeight
    }
    
    func setScrollPosition(position: CGFloat) {
        self.detailScrollView.contentOffset = CGPoint(x: self.detailScrollView.contentOffset.x, y: position)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        scrollViewDidStopScrolling()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            scrollViewDidStopScrolling()
        }
    }
    
    func scrollViewDidStopScrolling() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let midPoint = self.minHeaderHeight + (range / 2)
        
        if self.infoSummaryViewHeightConstraint.constant > midPoint {
            expandHeader()
        } else {
            collapseHeader()
        }
    }
    
    func collapseHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.infoSummaryViewHeightConstraint.constant = self.minHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func expandHeader() {
        self.view.layoutIfNeeded()
        UIView.animate(withDuration: 0.2, animations: {
            self.infoSummaryViewHeightConstraint.constant = self.maxHeaderHeight
            self.updateHeader()
            self.view.layoutIfNeeded()
        })
    }
    
    func updateHeader() {
        let range = self.maxHeaderHeight - self.minHeaderHeight
        let openAmount = self.infoSummaryViewHeightConstraint.constant - self.minHeaderHeight
        let percentage = openAmount / range
        
        let scale = 0.5 + percentage * 0.5
        
        self.gradeLabel.transform = CGAffineTransform(scaleX: scale, y: scale)
    }
}
