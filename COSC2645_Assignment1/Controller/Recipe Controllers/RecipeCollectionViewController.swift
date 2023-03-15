//
//  RecipeCollectionViewController.swift
//  COSC2645_Assignment1
//
//  Created by Matthew Challen on 1/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit
import CoreLocation

private let reuseIdentifier = "Cell"
var currentLocationObject: CLPlacemark?

class RecipeCollectionViewController: UICollectionViewController, CLLocationManagerDelegate {
    
    var displayViewModels: [RecipeView: ViewModelRecipe]? = nil

    var howToDisplay : RecipeView = .byDefault
    var data : [(title : String, image: UIImage)] = [];
    let locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayViewModels = [.byDefault : ViewModelRecipeByDefault(manager: AppDelegate.sharedInstance), .byTime : ViewModelRecipeByTime(manager: AppDelegate.sharedInstance), .byDietary : ViewModelRecipeByDietary(manager: AppDelegate.sharedInstance), .byRegion : ViewModelRecipeByRegion(manager: AppDelegate.sharedInstance), .byCalories : ViewModelRecipeByCalories(manager: AppDelegate.sharedInstance)]
        
        let layoutManager = self.collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layoutManager.sectionInset = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
        
        data = self.displayViewModels![self.howToDisplay]!.getCollectionRecipeData();
        self.collectionView.reloadData();
        
        locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyKilometer
            locationManager.startUpdatingLocation()
        }
        
        // Do any additional setup after loading the view.
    }
    
    func changeViewType(toRecipe : RecipeView){
        self.howToDisplay = toRecipe;
        collectionView.reloadData();
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return data.count;
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        var cell = UICollectionViewCell();
        
        if let RecipeCell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipeCell", for: indexPath) as? RecipeCollectionViewCell{
            RecipeCell.configure(with: data[indexPath.row].title, with: data[indexPath.row].image);
            RecipeCell.layer.borderWidth = 2;
            RecipeCell.layer.cornerRadius = 4;
            cell = RecipeCell;
        }
        
        return cell;
    }
    
    override func viewDidAppear(_ animated: Bool) {
        //Navigation is handled by the popover
        self.navigationController?.isNavigationBarHidden = true;
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if(segue.identifier == "SelectCollectionItem"){
            if let tableViewForCollection = segue.destination as? RecipeTableViewController{
                tableViewForCollection.howToDisplay = self.howToDisplay;
                if let categorySource = sender as? RecipeCollectionViewCell{
                    tableViewForCollection.sourceCollection = categorySource.CollectionLabel.text!;
                }
            }
        }
    }
    
    func getLocationPlacemark(location: CLLocation) {
        let geoCoder = CLGeocoder()
        geoCoder.reverseGeocodeLocation(location) { (placemarks, error) in
            if let error = error {
                print("Error: " + String(error.localizedDescription))
                return
            }
            else if let placemarks = placemarks {
                for placemark in placemarks {
                    currentLocationObject = placemark
                    
                    if let country = placemark.isoCountryCode {
                        print("\n\nCountry: " + String(country))
                    }
                }
            }
        }
        locationManager.stopUpdatingLocation()
    }
    
    func locationManager (_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let locationObject: CLLocation = manager.location {
            getLocationPlacemark(location: locationObject)
        }
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
