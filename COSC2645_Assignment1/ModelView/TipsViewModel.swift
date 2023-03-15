//
//  TipsViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

public class TipsViewModel {
    
    var manager : Manager
    var tipData = [Tip]()
    
    init(manager: Manager) {
        self.manager = manager

        loadTips()
        sortTips()
    }
    
    func loadTips() {
        if let fileLocation = Bundle.main.url(forResource: "tips", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Tip].self, from: data)
                
                self.tipData = dataFromJson
            } catch {
                print(error)
            }
        }
    }

    func sortTips() {
        self.tipData = self.tipData.sorted(by: { $0.tip_id < $1.tip_id })
    }
}
