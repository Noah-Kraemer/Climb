//
//  MockCragData.swift
//  Climb
//
//  Created by Noah Kraemer on 18/11/18.
//  Copyright © 2018 Noah Kraemer. All rights reserved.
//

import CoreData

class MockCragData {
    
    static func resetCragData(appDelegate: AppDelegate) {
        let context = appDelegate.persistentContainer.viewContext
        
        clearCrags(context)
        
        let entity = NSEntityDescription.entity(forEntityName: "Crag", in: context)
        let newCrag = NSManagedObject(entity: entity!, insertInto: context)
        newCrag.setValue(UUID.init(uuidString: "19fa580d-4240-4983-8a26-4044ad3155e0"), forKey: "id")
        newCrag.setValue("Flinders Cave", forKey: "name")
        newCrag.setValue("flinders.jpg", forKey: "imageName")
        newCrag.setValue("30m", forKey: "driveTime")
        newCrag.setValue("15m", forKey: "hikeTime")
        newCrag.setValue("Drive: From Brisbane head out on the Centenary Highway, turn south at Ripley Rd. After about 10km this turns into Undulla Rd. After a further 7km turn right onto Mount Elliott Rd. On Mount Elliot Rd you eventually come to 2 sets of gates. Go through the gate and close them behind you. At the second set of gates, the right one is clearly someone's house, take the left gate. Drive to the end (bumpy dirt road) and park somewhere without blocking the final locked gate or the road.\n\nWalk in: Follow the fire trail for 5 mins, to an intersection with a yellow SFT marker. Turn left (uphill). Soon you arrive at another yellow SFT marker. Go left again onto the faint trail. Follow through the trees to a clearing and Head left immediately. You should be able to follow this now well developed trail all the way to the crag without much trouble. At the small gear cave, scramble up the rock just left where the log leans against the wall.", forKey: "accessText")
        newCrag.setValue("Flinders Peak is a prominent landmark to the south of Ipswich.\n\nThe cave is open, but please be aware access is sensitive and if we aren't careful we could lose the privilege again. Please respect the local roads and residents, keep gates closed at all times and do not leave any gear or rubbish in the cave.", forKey: "descriptionText")
        newCrag.setValue("sun", forKey: "weather")
        
        let newCrag2 = NSManagedObject(entity: entity!, insertInto: context)
        newCrag2.setValue(UUID.init(uuidString: "19fa580d-4240-4983-8a26-4044ad3155e0"), forKey: "id")
        newCrag2.setValue("Kangaroo Point", forKey: "name")
        newCrag2.setValue("kp.jpg", forKey: "imageName")
        newCrag2.setValue("5m", forKey: "driveTime")
        newCrag2.setValue("5m", forKey: "hikeTime")
        newCrag2.setValue("Drive: From Brisbane head out on the Centenary Highway, turn south at Ripley Rd. After about 10km this turns into Undulla Rd. After a further 7km turn right onto Mount Elliott Rd. On Mount Elliot Rd you eventually come to 2 sets of gates. Go through the gate and close them behind you. At the second set of gates, the right one is clearly someone's house, take the left gate. Drive to the end (bumpy dirt road) and park somewhere without blocking the final locked gate or the road.\n\nWalk in: Follow the fire trail for 5 mins, to an intersection with a yellow SFT marker. Turn left (uphill). Soon you arrive at another yellow SFT marker. Go left again onto the faint trail. Follow through the trees to a clearing and Head left immediately. You should be able to follow this now well developed trail all the way to the crag without much trouble. At the small gear cave, scramble up the rock just left where the log leans against the wall.", forKey: "accessText")
        newCrag2.setValue("Flinders Peak is a prominent landmark to the south of Ipswich.\n\nThe cave is open, but please be aware access is sensitive and if we aren't careful we could lose the privilege again. Please respect the local roads and residents, keep gates closed at all times and do not leave any gear or rubbish in the cave.", forKey: "descriptionText")
        newCrag2.setValue("cloud", forKey: "weather")
        
        let newCrag3 = NSManagedObject(entity: entity!, insertInto: context)
        newCrag3.setValue(UUID.init(uuidString: "19fa580d-4240-4983-8a26-4044ad3155e0"), forKey: "id")
        newCrag3.setValue("Frog Buttress", forKey: "name")
        newCrag3.setValue("frog.jpg", forKey: "imageName")
        newCrag3.setValue("60m", forKey: "driveTime")
        newCrag3.setValue("10m", forKey: "hikeTime")
        newCrag3.setValue("Drive: From Brisbane head out on the Centenary Highway, turn south at Ripley Rd. After about 10km this turns into Undulla Rd. After a further 7km turn right onto Mount Elliott Rd. On Mount Elliot Rd you eventually come to 2 sets of gates. Go through the gate and close them behind you. At the second set of gates, the right one is clearly someone's house, take the left gate. Drive to the end (bumpy dirt road) and park somewhere without blocking the final locked gate or the road.\n\nWalk in: Follow the fire trail for 5 mins, to an intersection with a yellow SFT marker. Turn left (uphill). Soon you arrive at another yellow SFT marker. Go left again onto the faint trail. Follow through the trees to a clearing and Head left immediately. You should be able to follow this now well developed trail all the way to the crag without much trouble. At the small gear cave, scramble up the rock just left where the log leans against the wall.", forKey: "accessText")
        newCrag3.setValue("Flinders Peak is a prominent landmark to the south of Ipswich.\n\nThe cave is open, but please be aware access is sensitive and if we aren't careful we could lose the privilege again. Please respect the local roads and residents, keep gates closed at all times and do not leave any gear or rubbish in the cave.", forKey: "descriptionText")
        newCrag3.setValue("partCloud", forKey: "weather")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
    }
    
    static func clearCrags(_ context: NSManagedObjectContext) {
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Crag")
        let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
        
        do {
            try context.execute(batchDeleteRequest)
        } catch {
            print("Could not clear Crags. \(error)")
        }
    }
}
