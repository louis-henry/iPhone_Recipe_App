//
//  IngredientsViewController.swift
//  COSC2645_Assignment1
//
//  Created by Robert Wallace on 9/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class IngredientsViewController: BaseViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel : IngredientsViewModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.dataSource = self
        viewModel = IngredientsViewModel(manager: AppDelegate.sharedInstance);
        self.collectionView.reloadData()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.collectionView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel!.loadFavouriteRecipeData(then: self.collectionView.reloadData);
    }
    
    @IBAction func btnSearch(_ sender: Any) {
        // search with selected ingredients
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.ingredientsData.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ingredientItem", for: indexPath)
        let ingredientTitle = cell.viewWithTag(1000) as? UILabel
        let ingredientAdd = cell.viewWithTag(1001) as? UIButton
        
        if let ingredientTitle = ingredientTitle, let ingredientAdd = ingredientAdd {
            ingredientTitle.text = viewModel?.ingredientsData[indexPath.row]["originalString"] as? String ?? "No title found"
            ingredientAdd.tintColor = UIColor.gray
        }
        return cell
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
