//
//  ViewModelRecipeDetail.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation
import CoreData
import UIKit

public class ViewModelRecipeDetail{
    
    var manager : Manager
    var homeSuggestTitles : [String] = []
    
    init(manager : Manager){
        self.manager = manager
        
        getHomeSuggestedTitles()
    }
    
    func getRecipeDescription(id : Int) -> String?{
        for recipe in manager.recipeData{
            if(recipe.id == id){
                return recipe.description
            }
        }
        //No entry with that title
        return nil;
    }
    
    func isRecipeFavourite(id : Int) -> Bool{
        
        let favourites = manager.favouriteRecipes
        var isFavourite = false;
        for favourite in favourites!{
            if(favourite.fav_recipe_id == String(id)){
                isFavourite = true
            }
        }
        return isFavourite
    }
    
    func toggleFavouriteRecipe(id : Int) -> Bool{
        var favourites = manager.favouriteRecipes
        var toggleNum : Int? = nil
        if (favourites!.count != 0) {
            for favNum in 0...(favourites!.count - 1) {
                if(favourites![favNum].fav_recipe_id == String(id)) {
                    toggleNum = favNum
                }
            }
        }
        guard let toggleNumConc = toggleNum else{
            favourites!.append(FavRecipe(fav_recipe_id: String(id)))
            manager.favouriteRecipes = favourites
            return isRecipeFavourite(id: id)
        }
        favourites!.remove(at: toggleNumConc)
        manager.favouriteRecipes = favourites
        return isRecipeFavourite(id: id)
    }
    
    func getHomeSuggestedTitles() {
        for rec in manager.recipeData {
            homeSuggestTitles.append(rec.title)
        }
    }
    
    func getRecipeDetails(id : Int) -> Recipe?{
        for recipe in manager.recipeData{
            if(recipe.id == id){
                return recipe
            }
        }
        return nil
    }
    func getHomeRecipeDetails(id : Int) -> Recipe?{
        for recipe in manager.homeData{
            if(recipe.id == id){
                return recipe
            }
        }
        return nil
    }
}
