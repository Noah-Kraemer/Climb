//
//  CragPageViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 7/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class CragPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    var crags: [String] = ["flinders.jpg", "kp.jpg", "frog.jpg"]
    var cragNames: [String] = ["Flinders\nCave", "Kangaroo\nPoint", "Frog\nButtress"]
    
    var currentContentViewController: CragPageContentController? = nil
    var nextContentViewController: CragPageContentController? = nil
    
    override func viewDidLoad() {
        self.dataSource = self
        self.delegate = self
        
        let initalController = viewControllerFor(index: 0)
        currentContentViewController = (initalController as! CragPageContentController)
        currentContentViewController!.isInitialView = true
        
        let viewControllers = [initalController]
        
        self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
        
        super.viewDidLoad()
    }
    
    // MARK - UIPageViewControllerDelegate
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        nextContentViewController = (pendingViewControllers[0] as! CragPageContentController)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if (completed) {
            currentContentViewController!.clearAnimations()
            nextContentViewController?.animatePan()
            currentContentViewController = nextContentViewController
        } else {
            nextContentViewController!.clearAnimations()
        }
    }
    
    // MARK - UIPageViewControllerDatasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! CragPageContentController
        let currentIndex = currentViewController.pageViewIndex!
        
        let nextIndex = (currentIndex == 0) ? crags.count - 1 : currentIndex - 1
        return viewControllerFor(index: nextIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! CragPageContentController
        let currentIndex = currentViewController.pageViewIndex!
        
        let nextIndex = (currentIndex == crags.count - 1) ? 0 : currentIndex + 1
        return viewControllerFor(index: nextIndex)
    }
    
    func viewControllerFor(index: Int) -> UIViewController {
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "CragPageContentController") as! CragPageContentController
        
        controller.pageViewIndex = index
        controller.cragImageName = crags[index]
        controller.cragName = cragNames[index]
        
        return controller
    }
}
