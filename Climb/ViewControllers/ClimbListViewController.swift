//
//  ClimbListViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 12/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import UIKit

class ClimbListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    var areas = [
        tempArea(name: "Slider", walkTime: "15m", climbs: [
            tempClimb(name: "Troposphere", style: "Sport", grade: "18"),
            tempClimb(name: "C Section", style: "Sport", grade: "18"),
            tempClimb(name: "Rescision", style: "Sport", grade: "19"),
            tempClimb(name: "Heliosphere", style: "Sport", grade: "14")
        ]),
        tempArea(name: "Celestial Wall", walkTime: "25m", climbs: [/*
            tempClimb(name: "Idiot Wind", style: "Sport", grade: "21"),
            tempClimb(name: "Bombadil", style: "Sport", grade: "18"),
            tempClimb(name: "Cucumber Castle", style: "Trad", grade: "23")*/
        ]),
        tempArea(name: "Coolum Cave", walkTime: "25m", climbs: []),
        tempArea(name: "Ngungun", walkTime: "25m", climbs: []),
        tempArea(name: "Redbank", walkTime: "25m", climbs: []),
        tempArea(name: "Toohey Forest", walkTime: "25m", climbs: [])/*,
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (isArea(atIndexPath: indexPath)) {
            return 100
        } else {
            return 50
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var count = 0
        for area in areas {
            count += area.climbs.count + 1
        }
        return count
    }
    
    func isArea(atIndexPath indexPath: IndexPath) -> Bool {
        var itr = 0
        for area in areas {
            if (indexPath.row == itr) {
                return true
            }
            itr += area.climbs.count + 1
        }
        return false
    }
    
    func getClimbAt(indexPath: IndexPath) -> tempClimb? {
        var areaIndex = 0
        var climbIndex = indexPath.row - 1
        
        while (climbIndex >= 0) {
            if (climbIndex < areas[areaIndex].climbs.count) {
                return areas[areaIndex].climbs[climbIndex]
            }
            climbIndex -= (areas[areaIndex].climbs.count + 1)
            areaIndex += 1
        }
        return nil
    }
    
    func getAreaAt(indexPath: IndexPath) -> tempArea? {
        var areaIndex = 0
        var itr = 0
        
        for area in areas {
            if (indexPath.row == itr) {
                return areas[areaIndex]
            }
            itr += area.climbs.count + 1
            areaIndex += 1
        }
        return nil
    }
    
    func getBulletViewAt(indexPath: IndexPath) -> ClimbListBulletView? {
        var indentation: ClimbListBulletView.Indentation?
        var topConnection: ClimbListBulletView.Direction?
        var bottomConnection: ClimbListBulletView.Direction?
        
        if (indexPath.row == 0) {
            topConnection = ClimbListBulletView.Direction.none
        }
        
        if (indexPath.row == climbTableView.numberOfRows(inSection: indexPath.section) - 1) {
            bottomConnection = ClimbListBulletView.Direction.none
        }

        
        if (isArea(atIndexPath: indexPath)) {
            indentation = .area
            
            if (topConnection == nil) {
                topConnection = isArea(atIndexPath: IndexPath.init(row: indexPath.row - 1, section: indexPath.section)) ? .center : .right
            }
            
            if (bottomConnection == nil) {
                bottomConnection = isArea(atIndexPath: IndexPath.init(row: indexPath.row + 1, section: indexPath.section)) ? .center : .right
            }
            
        } else {
            indentation = .climb
            
            if (topConnection == nil) {
                topConnection = isArea(atIndexPath: IndexPath.init(row: indexPath.row - 1, section: indexPath.section)) ? .left : .center
            }
            
            if (bottomConnection == nil) {
                bottomConnection = isArea(atIndexPath: IndexPath.init(row: indexPath.row + 1, section: indexPath.section)) ? .left : .center
            }
        }
        
        return ClimbListBulletView(frame: CGRect(x: 0, y: 0, width: 100, height: 100),
                                   indentation: indentation!,
                                   topConnection: topConnection!,
                                   bottomConnection: bottomConnection!)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (isArea(atIndexPath: indexPath)) {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbTableViewAreaCell", for: indexPath) as! ClimbTableViewAreaCell
            let area = getAreaAt(indexPath: indexPath)!
            
            cell.areaNameLabel?.text = area.name
            cell.walkTimeLabel?.text = area.walkTime
            cell.climbCountLabel?.text = String(area.climbs.count)
            
            cell.bulletView = getBulletViewAt(indexPath: indexPath)!
            
            cell.contentView.insertSubview(cell.bulletView!, at: 2)
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "ClimbTableViewClimbCell", for: indexPath) as! ClimbTableViewClimbCell
            let climb = getClimbAt(indexPath: indexPath)!
            
            cell.climbNameLabel?.text = climb.name
            cell.gradeLabel?.text = climb.grade
            cell.styleImageView.image = UIImage(named: climb.style.lowercased() + ".png")
            
            cell.bulletView = getBulletViewAt(indexPath: indexPath)!
            
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
