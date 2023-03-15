//
//  ViewModelRecipeByDate.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

public class ViewModelRecipeByTime : ViewModelRecipe{
    
    var manager : Manager
    var timeBrackets : [(String, UIImage)] = []
    let numTimeBracket = 24
    
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
        
        let image = #imageLiteral(resourceName: "Timer-Green")
        
        for time in 1...numTimeBracket{
            let lowerTime = time * 5
            timeBrackets.append(("Under \(lowerTime) mins", image));
        }
    }
    
    func getCollectionRecipeData() -> [(title : String, image : UIImage)]{
        return timeBrackets;
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
        let maxReadyTime = collectionChosen!.components(separatedBy: CharacterSet.decimalDigits.inverted)[6]
        var query = "https://api.spoonacular.com/recipes/complexSearch?addRecipeInformation=true&apiKey=\(manager.apiKey)&number=10&maxReadyTime=\(maxReadyTime)&sort=random"
        
        if (userDietStrings.count != 0) {
            query.append("&tags=")
            query.append(userDietStrings.joined(separator: ","))
        }
        manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
    }
}
