//
//  Climb.swift
//  Climb
//
//  Created by Noah Kraemer on 1/10/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import Foundation
import CoreData

public class ClimbModel {
    public var id: UUID
    public var name: String
    public var imageName: String
    public var grade: String
    public var length: String
    public var detail: String
    public var style: String
    
    init(fromObject: NSManagedObject) {
        self.id = (fromObject.value(forKey: "id") as! UUID)
        self.name = (fromObject.value(forKey: "name") as! String)
        self.imageName = (fromObject.value(forKey: "imageName") as! String)
        self.grade = (fromObject.value(forKey: "grade") as! String)
        self.length = (fromObject.value(forKey: "length") as! String)
        self.detail = (fromObject.value(forKey: "details") as! String)
        self.style = (fromObject.value(forKey: "style") as! String)
    }
}
