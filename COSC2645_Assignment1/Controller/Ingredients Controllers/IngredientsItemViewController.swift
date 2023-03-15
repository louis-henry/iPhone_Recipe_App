//
//  IngredientsItemViewController.swift
//  COSC2645_Assignment1
//
//  Created by Robert Wallace on 9/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class IngredientsItemViewController: UICollectionViewCell {
    
    @IBOutlet weak var IngredientAdd: UIButton!
    
    @IBAction func btnAdd(_ sender: Any) {
        if (IngredientAdd.tintColor != UIColor.green) {
            IngredientAdd.tintColor = UIColor.green
            //add to search
        } else if IngredientAdd.tintColor == UIColor.green {
            IngredientAdd.tintColor = UIColor.gray
            //remove from search
        }
    }
}
