//
//  CragModel.swift
//  Climb
//
//  Created by Noah Kraemer on 16/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import CoreData

public class CragModel {
    public var id: UUID
    public var name: String
    public var imageName: String
    public var driveTime: String
    public var hikeTime: String
    public var accessText: String
    public var descriptionText: String
    public var weather: String
    
    init(fromObject: NSManagedObject) {
        self.id = (fromObject.value(forKey: "id") as! UUID)
        self.name = (fromObject.value(forKey: "name") as! String)
        self.imageName = (fromObject.value(forKey: "imageName") as! String)
        self.driveTime = (fromObject.value(forKey: "driveTime") as! String)
        self.hikeTime = (fromObject.value(forKey: "hikeTime") as! String)
        self.accessText = (fromObject.value(forKey: "accessText") as! String)
        self.descriptionText = (fromObject.value(forKey: "descriptionText") as! String)
        self.weather = (fromObject.value(forKey: "weather") as! String)
    }
}

