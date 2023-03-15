//
//  ViewModelProtocol.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

enum RecipeDataSections{
    case title
    case content
}

protocol ViewModelRecipe{
    func getCollectionRecipeData() -> [(title : String, image : UIImage)];
    func loadTableRecipeData(collectionChosen : String?, wipeFirst : Bool, then: @escaping () -> Void);
    var numberToLoad : Int {get}
    var recipeData : [Recipe] {get}
}
