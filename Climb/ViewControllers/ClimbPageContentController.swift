//
//  ClimbViewController.swift
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
    
    @IBOutlet weak var climbImageView: UIImageView!
    @IBOutlet weak var overlayImageView: UIImageView!
    @IBOutlet weak var styleImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var gradeLabel: UILabel!
    @IBOutlet weak var lengthLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var fullScreenImage: Bool = false
    
    var climbImageName: String?
    var styleImageName: String?
    var name: String?
    var grade: String?
    var length: String?
    var detail: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        climbImageView.image = UIImage.init(named: climbImageName!)
        overlayImageView.image = UIImage.init(named: "overlay_" + climbImageName!)
        styleImageView.image = UIImage.init(named: styleImageName!)
        nameLabel.text = name
        gradeLabel.text = grade
        lengthLabel.text = length
        detailLabel.text = detail
    }

}
