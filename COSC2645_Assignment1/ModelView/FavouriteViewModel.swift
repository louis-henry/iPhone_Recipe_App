//
//  FavouriteViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

public class FavouriteViewModel {
    
    var manager : Manager
    
    var recipeData : [Recipe]{
        get{
            return manager.recipeData
        }
    }
    
    init(manager: Manager) {
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
    
    func removeFavourite(id: Int){
        var favourites = manager.favouriteRecipes
        var toggleNum : Int? = nil
        if (favourites!.count != 0) {
            for favNum in 0...(favourites!.count - 1) {
                if(favourites![favNum].fav_recipe_id == String(id)) {
                    toggleNum = favNum
                }
            }
        }
        favourites!.remove(at: toggleNum!)
        manager.favouriteRecipes = favourites
    }
}
