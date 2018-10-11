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
    var currentIndex: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //TODO remove
        //initData()
        
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
    
    func initData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let entity = NSEntityDescription.entity(forEntityName: "Climb", in: context)
        let newClimb = NSManagedObject(entity: entity!, insertInto: context)
        newClimb.setValue("1) 25m (25) This pitch doesn't get done much since Deep Play was established, the latter being easier with much lower ropedrag and admin.\n\n2) 40m (25) This is the \"money pitch\". Mostly Bolts (about 8), a few pieces of trad gear.", forKey: "details")
        newClimb.setValue("24", forKey: "grade")
        newClimb.setValue(UUID.init(uuidString: "19fa580d-4240-4983-8a26-4044ad3155e0"), forKey: "id")
        newClimb.setValue("67m", forKey: "length")
        newClimb.setValue("The Free Route - Totem Pole", forKey: "name")
        newClimb.setValue("tote.jpg", forKey: "imageName")
        newClimb.setValue("sport", forKey: "style")
        
        let newClimb2 = NSManagedObject(entity: entity!, insertInto: context)
        newClimb2.setValue("25m 24. Crank through the overhang at the base of the NE arete. Continue up the arete and the wall to its left. \n\n10m 20. Blast straight up from the belay ledge then trend right via the last U to finish on the right side of the arete. No natural gear required on either pitch.", forKey: "details")
        newClimb2.setValue("24", forKey: "grade")
        newClimb2.setValue(UUID.init(uuidString: "85a13dc6-6b45-426a-b6e2-ca9fc16a84fe"), forKey: "id")
        newClimb2.setValue("35m", forKey: "length")
        newClimb2.setValue("Ancient Astronaught - Moai", forKey: "name")
        newClimb2.setValue("moai.jpg", forKey: "imageName")
        newClimb2.setValue("mixed", forKey: "style")
        
        let newClimb3 = NSManagedObject(entity: entity!, insertInto: context)
        newClimb3.setValue("Rap off the rings as for the Totem pole, jump in and swim right to an easy ledge just behind the Totem pole.\n\n30m Up chimney / crack\n\n30m More chimney / crack, ending on a good ledge with 2 rings to tyrolean back to the mainland roughly level with the top of the tote.\n\n30m through chimney past big chockstone (on descent it's easy to get your rope stuck on this), then up through looser rock into the sunshine to a rusty anchor.\n\n20m Up sunny face veering a little left at the top to another rusty anchor then scramble to the real summit.", forKey: "details")
        newClimb3.setValue("16", forKey: "grade")
        newClimb3.setValue(UUID.init(uuidString: "a2582ec3-9051-446e-8743-5010a5b4c8c3"), forKey: "id")
        newClimb3.setValue("110m", forKey: "length")
        newClimb3.setValue("Normal Route - Candlestick", forKey: "name")
        newClimb3.setValue("candlestick.jpg", forKey: "imageName")
        newClimb3.setValue("trad", forKey: "style")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    func loadClimbs() -> [NSManagedObject] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Climb")
        
        do {
            return try context.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        return []
    }
    
    // MARK - UIPageViewControllerDatasource
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        currentIndex = (currentIndex == 0) ? climbs.count - 1 : currentIndex - 1
        return viewControllerFor(index: currentIndex)
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        currentIndex = (currentIndex == climbs.count - 1) ? 0 : currentIndex + 1
        return viewControllerFor(index: currentIndex)
    }
    
    func viewControllerFor(index: Int) -> UIViewController {
        let climb = ClimbModel(fromObject: climbs[index])
        
        let controller = self.storyboard?.instantiateViewController(withIdentifier: "ClimbPageContentController") as! ClimbPageContentController
        
        controller.climbImageName = climb.imageName
        controller.styleImageName = climb.style
        
        controller.name = climb.name
        controller.grade = climb.grade
        controller.length = climb.length
        controller.detail = climb.detail
        
        controller.dismissCallback = dismissSelf
        
        return controller
    }
}
