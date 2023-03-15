//
//  FeedbackViewController.swift
//  COSC2645_Assignment1
//
//  Created by Luis Henry on 11/11/20.
//  Copyright © 2020 Nicholas Mamone. All rights reserved.
//

import UIKit

class FeedbackViewController: UIViewController {

    
    @IBOutlet weak var nameInputField: UITextField!
    @IBOutlet weak var subjectInputField: UITextField!
    @IBOutlet weak var descripInputField: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func submitButtonPressed(_ sender: Any) {
        if (nameInputField.text != "" && subjectInputField.text != "" && descripInputField.text != ""){
            // Logic here to send data to a Database
            
            // Alert user to submission
            alert(header: "Thankyou!", msg: "Your feedback is important to use. We value our customers input and appreciate feedback both positive and/or negative.", button: "Dismiss")
            // Clear fields
            nameInputField.text = ""
            subjectInputField.text = ""
            descripInputField.text = ""
        } else {
            // Alert user to missing information
            alert(header: "Missing Information", msg: "One (or more) fields are currently missing, please try again.", button: "Dismiss")
        }
    }
    
    func alert (header: String?, msg: String?, button: String?) {
        let alert = UIAlertController(title: header, message: msg, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}
