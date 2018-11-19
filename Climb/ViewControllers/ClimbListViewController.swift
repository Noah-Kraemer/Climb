//
//  ClimbListViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 12/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import UIKit

class ClimbListViewController: UITableViewController {
    
    var areas = [
        tempArea(name: "Slider", walkTime: "15m", climbs: [
            tempClimb(name: "Troposphere", style: "Sport", grade: "18"),
            tempClimb(name: "C Section", style: "Sport", grade: "18"),
            tempClimb(name: "Rescision", style: "Sport", grade: "19"),
            tempClimb(name: "Heliosphere", style: "Sport", grade: "14")
        ])/*,
        tempArea(name: "Celestial Wall", walkTime: "15m", climbs: [
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: String, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>)
        ]),
        tempArea(name: "Slider", walkTime: "15m", climbs: [
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>)
        ]),
        tempArea(name: "Slider", walkTime: "15m", climbs: [
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: String, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: String, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>),
            tempClimb(name: <#T##String#>, style: <#T##String#>, grade: <#T##Int#>)
        ])*/
    ]
    
    @IBOutlet weak var climbTableView: UITableView!
    
    var dismissClimbListTransition: DismissClimbListTransition?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        //TODO load climbs from core data
        
        dismissClimbListTransition = DismissClimbListTransition(viewController: self)
    }
    
    @IBAction func handleSwipe(_ sender: UISwipeGestureRecognizer) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //MARK - UITableViewDelegate, UITableViewDatasource
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (indexPath.row == 0) {
            return 100
        } else {
            return 50
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return areas[section].climbs.count + 1
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (indexPath.row == 0) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbTableViewAreaCell", for: indexPath) as! ClimbTableViewAreaCell
            let area = areas[0]
            
            cell.areaNameLabel?.text = area.name
            cell.walkTimeLabel?.text = area.walkTime
            cell.climbCountLabel?.text = String(area.climbs.count)
            
            cell.bulletView = ClimbListBulletView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), indentation: .area, topConnection: .none, bottomConnection: .right)
            
            cell.contentView.insertSubview(cell.bulletView!, at: 0)
            
            return cell
        } else if (indexPath.row == 1) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbTableViewClimbCell", for: indexPath) as! ClimbTableViewClimbCell
            let climb = areas[0].climbs[indexPath.row - 1]
            
            cell.climbNameLabel?.text = climb.name
            cell.gradeLabel?.text = climb.grade
            cell.styleImageView.image = UIImage(named: climb.style.lowercased() + ".png")
            
            cell.bulletView = ClimbListBulletView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), indentation: .climb, topConnection: .left, bottomConnection: .center)
            
            cell.contentView.insertSubview(cell.bulletView!, at: 0)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbTableViewClimbCell", for: indexPath) as! ClimbTableViewClimbCell
            let climb = areas[0].climbs[indexPath.row - 1]
            
            cell.climbNameLabel?.text = climb.name
            cell.gradeLabel?.text = climb.grade
            cell.styleImageView.image = UIImage(named: climb.style.lowercased() + ".png")
            
            cell.bulletView = ClimbListBulletView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), indentation: .climb, topConnection: .center, bottomConnection: .center)
            
            cell.contentView.insertSubview(cell.bulletView!, at: 0)
            
            return cell
        }
    }
}

class ClimbTableViewAreaCell: UITableViewCell {
    @IBOutlet weak var areaNameLabel: UILabel!
    @IBOutlet weak var walkTimeLabel: UILabel!
    @IBOutlet weak var climbCountLabel: UILabel!
    
    @IBOutlet weak var walkTimeImageView: UIImageView!
    @IBOutlet weak var climbCountImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    var bulletView: ClimbListBulletView?
}

class ClimbTableViewClimbCell: UITableViewCell {
    @IBOutlet weak var climbNameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    
    @IBOutlet weak var styleImageView: UIImageView!
    
    var bulletView: ClimbListBulletView?
}


// TEMP CLASSES
class tempClimb {
    var name: String
    var style: String
    var grade: String
    
    init(name: String, style: String, grade: String) {
        self.name = name
        self.style = style
        self.grade = grade
    }
}

class tempArea {
    var name: String
    var walkTime: String
    var climbs: [tempClimb]
    
    init(name: String, walkTime: String, climbs: [tempClimb]) {
        self.name = name
        self.walkTime = walkTime
        self.climbs = climbs
    }
}
