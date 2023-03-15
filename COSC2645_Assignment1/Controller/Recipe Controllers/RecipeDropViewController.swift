//
//  RecipeDropViewController.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 26/9/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class RecipeDropViewController: BaseViewController {
    
    var delegate : ChangeViewProtocol?
    
    @IBAction func SortByDefaultPress(_ sender: UIButton) {
        delegate!.changeView(to : RecipeViewType.TableView, sender)
        self.dismiss(animated: false)
    }
    
    @IBAction func SortByRegionPress(_ sender: UIButton) {
        delegate!.changeView(to : RecipeViewType.CollectionView, sender)
        self.dismiss(animated: false)
    }
    
    @IBAction func SortByTimePress(_ sender: UIButton) {
        delegate!.changeView(to : RecipeViewType.CollectionView, sender)
        self.dismiss(animated: false)
    }
    
    @IBAction func SortByPricingPress(_ sender: UIButton) {
        delegate!.changeView(to : RecipeViewType.CollectionView, sender)
        self.dismiss(animated: false)
    }
    
    @IBAction func SortByRatingPress(_ sender: UIButton) {
        delegate!.changeView(to : RecipeViewType.CollectionView, sender)
        self.dismiss(animated: false)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
