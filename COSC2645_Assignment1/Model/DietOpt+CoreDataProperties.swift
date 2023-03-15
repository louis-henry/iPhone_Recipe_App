//
//  DietOpt+CoreDataProperties.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
//

import Foundation
import CoreData


extension DietOpt {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<DietOpt> {
        return NSFetchRequest<DietOpt>(entityName: "DietOpt")
    }
    @NSManaged public var gluten: Bool
    @NSManaged public var keto: Bool
    @NSManaged public var lacto: Bool
    @NSManaged public var ovo: Bool
    @NSManaged public var paleo: Bool
    @NSManaged public var pesce: Bool
    @NSManaged public var primal: Bool
    @NSManaged public var vegan: Bool
    @NSManaged public var vege: Bool
    @NSManaged public var whole: Bool
}
