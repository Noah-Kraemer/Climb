//
//  CragListViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 12/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CragListViewController: UITableViewController {
    
    var crags: [CragModel] = []
    
    @IBOutlet weak var cragTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //TODO remove
        MockCragData.resetCragData(appDelegate: UIApplication.shared.delegate as! AppDelegate)
        self.crags = loadCrags()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? CragDetailViewController {
            if let customSegue = segue as? ExpandCragDetailSegue {
                let indexPath = self.tableView.indexPathForSelectedRow!
                customSegue.cellIndexPath = indexPath
                destination.crag = crags[indexPath.row]
                destination.indexPath = indexPath
            }
        }
    }
    
    @IBAction func unwindToCragListView(_ unwindSegue: UIStoryboardSegue) {
        // let sourceViewController = unwindSegue.source
        // Use data from the view controller which initiated the unwind segue
    }

    
    // MARK - UITableViewDatasource, UITableViewDelegate
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return crags.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CragTableViewCell", for: indexPath) as! CragTableViewCell
        
        cell.backgroundImageView?.image = UIImage(named: crags[indexPath.row].imageName)
        cell.cragNameLabel?.text = crags[indexPath.row].name
        
        return cell
    }
    
    
    // MARK - CoreData
    
    func loadCrags() -> [CragModel] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Crag")
        
        var cragManagedObjcts: [NSManagedObject]
        var crags: [CragModel] = []
        
        do {
            try cragManagedObjcts = context.fetch(fetchRequest)
            for object in cragManagedObjcts {
                crags.append(CragModel(fromObject: object))
            }
        } catch let error as NSError {
            print("Could not fetch Crags. \(error), \(error.userInfo)")
        }
        return crags
    }
}

class CragTableViewCell: UITableViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cragNameLabel: UILabel!
    @IBOutlet weak var gradientView: GradientView!
}
