//
//  ApplianceOpt+CoreDataProperties.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
//

import Foundation
import CoreData


extension ApplianceOpt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ApplianceOpt> {
        return NSFetchRequest<ApplianceOpt>(entityName: "ApplianceOpt")
    }

    @NSManaged public var sousVide: Bool
    @NSManaged public var deepFryer: Bool
    @NSManaged public var airFryer: Bool
    @NSManaged public var bbq: Bool
    @NSManaged public var blender: Bool
    @NSManaged public var pressureCooker: Bool
    @NSManaged public var steamer: Bool
    @NSManaged public var microwave: Bool
    @NSManaged public var oven: Bool
    @NSManaged public var stoveTop: Bool

}
