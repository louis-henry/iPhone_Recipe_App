//
//  TermsViewModel.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 10/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import Foundation

public class TermsViewModel {
    
    var manager : Manager
    var termData = [Term]()
    
    init(manager: Manager) {
        self.manager = manager

        loadTerms()
        sortTerms()
    }
    
    func loadTerms() {
        if let fileLocation = Bundle.main.url(forResource: "terms", withExtension: "json") {
            do {
                let data = try Data(contentsOf: fileLocation)
                let jsonDecoder = JSONDecoder()
                let dataFromJson = try jsonDecoder.decode([Term].self, from: data)
                
                self.termData = dataFromJson
            } catch {
                print(error)
            }
        }
    }

    func sortTerms() {
        self.termData = self.termData.sorted(by: { $0.term_id < $1.term_id })
    }
}
