//
//  ViewModelRecipeByPricing.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class ViewModelRecipeByCalories : ViewModelRecipe{
    
    var manager : Manager
    var calorieBrackets : [(String, UIImage)] = []
    let numCalorieBracket =  10
    let calorieBracketSize = 250
    
    var numberToLoad: Int{
        get{
            return 10
        }
    }
    
    var recipeData: [Recipe]{
        get{
            return manager.recipeData
        }
    }
    
    init(manager: Manager){
        self.manager = manager
        
        var lowerCalorie : Int
        let image = #imageLiteral(resourceName: "search-calories")
        
        for amount in 0...numCalorieBracket{
            lowerCalorie = amount * 250;
            calorieBrackets.append(("\(lowerCalorie)cal to \(lowerCalorie + 249)cal", image));
        }
        
    }
    
    func getCollectionRecipeData() -> [(title : String, image : UIImage)]{
        return calorieBrackets
    }
    
    func loadTableRecipeData(collectionChosen : String?, wipeFirst : Bool, then: @escaping () -> Void){
        if (wipeFirst) {
            manager.resetRecipes()
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
        let minCal = collectionChosen!.components(separatedBy: CharacterSet.decimalDigits.inverted)[0]
        let maxCal = collectionChosen!.components(separatedBy: CharacterSet.decimalDigits.inverted)[7]
        var query = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&apiKey=\(manager.apiKey)&number=10&minCalories=\(minCal)&maxCalories=\(maxCal)&sort=random"
        
        if (userDietStrings.count != 0) {
            query.append("&tags=")
            query.append(userDietStrings.joined(separator: ","))
        }
        manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
    }
    
}

