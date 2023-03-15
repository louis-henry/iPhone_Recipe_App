//
//  FavouriteTableViewCell.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class FavouriteTableViewCell: UITableViewCell {

    
    @IBOutlet weak var cellImg: UIImageView!
    @IBOutlet weak var recipeName: UILabel!
    @IBOutlet weak var recipeDescrip: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
