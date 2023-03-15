//
//  ViewModelRecipeInstructions.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

public class ViewModelRecipeInstructions{
    
    var manager : Manager
    var recipeData : [Recipe]{
        get{
            return manager.recipeData
        }
    }
    var homeData : [Recipe]{
        get{
            return manager.homeData
        }
    }
    
    init(manager : Manager){
        self.manager = manager
    }
    
    func getRecipeInstructions(id : Int, useHomeData : Bool) -> [[String : Any]]?{
        if (useHomeData) {
            for recipe in homeData{
                if(recipe.id == id){
                    return recipe.instructions
                }
            }
        } else {
            for recipe in recipeData{
                if(recipe.id == id){
                    return recipe.instructions
                }
            }
        }
        //No entry with that title
        return nil
    }
    
    func getRecipeIngredients(id : Int) -> [(name: String, amount: Int, units: String)]?{
        var returnData : [(name: String, amount: Int, units: String)] = []
        for recipe in recipeData{
            if(recipe.id == id){
                for ingredient in recipe.ingredients{
                    returnData.append((ingredient["name"] as! String, ingredient["amount"] as? Int ?? 1, ingredient["unit"] as? String ?? ""))
                }
            }
        }
        return returnData
    }
    

}
