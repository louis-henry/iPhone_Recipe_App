//
//  RecipeCollectionViewCell.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 8/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class RecipeCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var CollectionLabel: UILabel!
    
    @IBOutlet var CollectionImage: UIImageView!
    
    func configure(with Title : String, with Image : UIImage){
        CollectionLabel.text = Title;
        CollectionImage.image = Image;
    }
    
    
}
