//
//  ViewModelRecipeByRating.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class ViewModelRecipeByDietary : ViewModelRecipe{
    
    var manager : Manager
    var dietTypesTitle : Set<String> = ["Gluten Free", "Ketogenic", "Vegetarian", "Lacto-Vegetarian", "Ovo-Vegetarian", "Vegan", "Pescetarian", "Paleo", "Primal", "Whole30"]
    var dietTypesImage : UIImage;
    
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
        
        dietTypesImage = #imageLiteral(resourceName: "search-diet")
    }
    
    func getCollectionRecipeData() -> [(title : String, image : UIImage)]{
        
        var collectionData : [(title : String, image : UIImage)] = []
        
        for title in dietTypesTitle{
            collectionData.append((title: title, image: dietTypesImage))
        }
        
        return collectionData;
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
        query.append("&tags=")
        
        if (userDietStrings.count != 0) {
            query.append(userDietStrings.joined(separator: ","))
            query.append(",")
        }
        if (collectionChosen != "") {
            query.append(collectionChosen!.lowercased())
        }
        manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
    }
}
