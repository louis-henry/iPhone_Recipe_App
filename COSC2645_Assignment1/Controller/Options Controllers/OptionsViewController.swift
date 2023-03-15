//
//  OptionsViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 2/10/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class OptionsViewController: BaseViewController {

    var accVM : AccountViewModel? = nil
    
    @IBAction func resetAccountConfirm(_ sender: Any) {
        accVM!.resetAccountData()
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func resetAccountDismiss(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accVM = AccountViewModel(manager: AppDelegate.sharedInstance)
        // Do any additional setup after loading the view.
    }
}
