//
//  FavouriteRecipe+CoreDataProperties.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
//

import Foundation
import CoreData


extension FavouriteRecipe {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavouriteRecipe> {
        return NSFetchRequest<FavouriteRecipe>(entityName: "FavouriteRecipe")
    }
    @NSManaged public var recipeID: String?
}
