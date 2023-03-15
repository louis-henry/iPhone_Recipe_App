//
//  ExploreHomveViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 13/11/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//
import Foundation

public class ExploreHomeViewModel {
    var manager : Manager
    var homeData : [Recipe] {
        get{
            return manager.homeData
        }
    }
    
    init(manager: Manager) {
        self.manager = manager
    }
    
    func loadHomeData(then: @escaping () -> Void){
        manager.loadHomeData(withRequest:URLRequest(url: URL(string: "https://api.spoonacular.com/recipes/random?apiKey=\(manager.apiKey)&number=30")!), then:then)
    }
}
