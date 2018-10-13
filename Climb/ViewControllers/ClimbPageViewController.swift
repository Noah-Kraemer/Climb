//
//  ClimbPageViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 3/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class ClimbPageViewController: UIPageViewController, UIPageViewControllerDataSource {
    
    var climbs: [NSManagedObject] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO remove
        MockClimbData.resetClimbData(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        
        self.dataSource = self
        self.climbs = loadClimbs()
        
        let initalController = self.viewControllerFor(index: 0)
        
        let viewControllers = [initalController]
        
        self.setViewControllers(viewControllers, direction: .forward, animated: false, completion: nil)
    }
    
    func dismissSelf() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK - CoreData

    func loadClimbs() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Climb")
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch Climbs. \(error), \(error.userInfo)")
        }
        return []
    }
    
    // MARK - UIPageViewControllerDatasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! ClimbPageContentController
        let currentIndex = currentViewController.pageViewIndex!
        
        let nextIndex = (currentIndex == 0) ? climbs.count - 1 : currentIndex - 1
        
        return viewControllerFor(index: nextIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentViewController = viewController as! ClimbPageContentController
        let currentIndex = currentViewController.pageViewIndex!
        
        let nextIndex = (currentIndex == climbs.count - 1) ? 0 : currentIndex + 1
        
        return viewControllerFor(index: nextIndex)
    }
    
    func viewControllerFor(index: Int) -> UIViewController {
        let climb = ClimbModel(fromObject: climbs[index])
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ClimbPageContentController") as! ClimbPageContentController
        
        controller.climbImageName = climb.imageName
        
        controller.pageViewIndex = index
        controller.name = climb.name
        controller.grade = climb.grade
        controller.length = climb.length
        controller.detail = climb.detail
        controller.style = climb.style
        controller.starRating = climb.starRating
        
        controller.dismissCallback = dismissSelf
        
        return controller
    }
}
