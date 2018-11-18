//
//  CragDetailViewController.swift
//  Climb
//
//  Created by Noah Kraemer on 16/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import UIKit

class CragDetailViewController: UIViewController {
    
    //Images
    @IBOutlet weak var cragImageView: UIImageView!
    @IBOutlet weak var driveTimeImageView: UIImageView!
    @IBOutlet weak var hikeTimeImageView: UIImageView!
    @IBOutlet weak var climbCountImageView: UIImageView!
    @IBOutlet weak var weatherImageView: UIImageView!
    
    //Labels
    @IBOutlet weak var cragTitleLabel: UILabel!
    @IBOutlet weak var driveTimeLabel: UILabel!
    @IBOutlet weak var hikeTimeLabel: UILabel!
    @IBOutlet weak var climbCountLabel: UILabel!
    @IBOutlet weak var accessLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //TextViews
    @IBOutlet weak var accessTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var gradientView: GradientView!
    
    var crag: CragModel?
    
    var accessExpanded: Bool = true
    
    override func viewDidLoad() {
        cragImageView.image = UIImage(named: crag!.imageName)
        driveTimeImageView.image = UIImage(named: "driveIcon.png")
        hikeTimeImageView.image = UIImage(named: "hikeIcon.png")
        climbCountImageView.image = UIImage(named: "climbCountIcon.png")
        weatherImageView.image = UIImage(named: crag!.weather + "Icon.png") //TODO make dynamic
        
        cragTitleLabel.text = crag!.name
        cragTitleLabel.sizeToFit()
        
        driveTimeLabel.text = crag!.driveTime
        hikeTimeLabel.text = crag!.hikeTime
        //climbCountLabel.text =
        
        accessLabel.text = "Access"
        descriptionLabel.text = "Description"
        
        accessTextView.text = crag?.accessText
        descriptionTextView.text = crag?.descriptionText
        
        gradientView.fadeDirection = .vertical
    }
    
    @IBAction func handleBackButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
