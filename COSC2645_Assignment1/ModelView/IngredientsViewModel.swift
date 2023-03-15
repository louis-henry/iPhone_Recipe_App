//
//  IngredientsViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import UIKit

class IngredientsViewModel{
    
    var manager : Manager
    var ingredientsData : [[String : Any]]
    {
        get {
            var ingredientsData : [[String : Any]] = []
            for recipe in manager.recipeData {
                for ingredient in recipe.ingredients {
                    ingredientsData.append(ingredient)
                }
            }
            return ingredientsData
        }
    }
    
    init(manager : Manager){
        self.manager = manager
    }
    
    func loadFavouriteRecipeData(then: @escaping () -> Void){
        manager.resetRecipes()
        then()
        let favourites = manager.favouriteRecipes
        var query = "https://api.spoonacular.com/recipes/informationBulk?apiKey=\(manager.apiKey)&ids="
        var ids : [String] = []
        for favourite in favourites! {
            ids.append(favourite.fav_recipe_id!)
        }
        query.append(ids.joined(separator: ","))
        if (ids.count != 0) {
            manager.loadRecipes(withRequest:URLRequest(url: URL(string: query)!), then:then)
        } else {
            then()
        }
    }
}
