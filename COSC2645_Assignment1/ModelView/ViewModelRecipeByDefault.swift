//
//  ViewModelRecipeByDefault.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class ViewModelRecipeByDefault : ViewModelRecipe{
    
    var manager : Manager
    
    var recipeData: [Recipe]{
        get{
            return manager.recipeData
        }
    }
    
    var numberToLoad: Int{
        get{
            return 10
        }
    }
    
    init(manager : Manager){
        self.manager = manager
    }
    
    
    func getCollectionRecipeData() -> [(title : String, image : UIImage)]{
        //There is no collection view for the default, default doesn't categorise
        return [];
    }
    
    
    func loadTableRecipeData(collectionChosen : String?, wipeFirst : Bool, then: @escaping () -> Void){
        if (wipeFirst) {
            manager.resetRecipes()
            then()
        }
        var userDietStrings : [String] = []
        let userDiet = manager.dietaries
        if (userDiet!.gluten) {
            userDietStrings.append("gluten-free")
        }
        if (userDiet!.keto) {
            userDietStrings.append("ketogenic")
        }
        if (userDiet!.vege) {
            userDietStrings.append("vegetarian")
        }
        if (userDiet!.lacto) {
            userDietStrings.append("lacto-vegetarian")
        }
        if (userDiet!.ovo) {
            userDietStrings.append("ovo-vegetarian")
        }
        if (userDiet!.vegan) {
            userDietStrings.append("vegan")
        }
        if (userDiet!.pesce) {
            userDietStrings.append("pescetarian")
        }
        if (userDiet!.paleo) {
            userDietStrings.append("paleo")
        }
        if (userDiet!.primal) {
            userDietStrings.append("primal")
        }
        if (userDiet!.whole) {
            userDietStrings.append("whole30")
        }
        var query = "https://api.spoonacular.com/recipes/random?apiKey=\(manager.apiKey)&number=10"
        if (userDietStrings.count != 0) {
            query.append("&tags=")
            query.append(userDietStrings.joined(separator: ","))
        }
        manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
    }
}
