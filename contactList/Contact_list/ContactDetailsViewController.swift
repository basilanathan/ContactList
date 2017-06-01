//
//  ContactDetailsViewController.swift
//  Contact_list
//
//  Created by Basila Nathan on 3/24/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import Foundation
import UIKit

class ContactDetailsViewController: UIViewController{
    
    var contactToEdit: Contact?
    var contactToEditIndexPath: Int?
    
    @IBOutlet weak var numberText: UITextField!
    @IBOutlet weak var lastNameText: UITextField!
    @IBOutlet weak var firstNameText: UITextField!
    
    weak var cancelButtonDelegate: CancelButtonDelegate?
    weak var delegate: ContactDetailsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if (contactToEdit != nil){
            self.title = "Edit Contact"
            numberText.text = contactToEdit?.number
            lastNameText.text = contactToEdit?.lastName
            firstNameText.text = contactToEdit?.firstName
        }else{
            self.title = "New Contact"
        }
    }
    
    @IBAction func cancelBarButtonPressed(_ sender: UIBarButtonItem) {
        cancelButtonDelegate?.cancelButtonPressedFrom(self)
    }
    
    @IBAction func saveBarButtonPressed(_ sender: UIBarButtonItem) {
        
        if ((lastNameText.text?.characters.count)! > 0 && (firstNameText.text?.characters.count)! > 0 && (numberText.text?.characters.count)! > 0){
            if let contact = contactToEdit{
                contact.firstName = firstNameText.text!
                contact.lastName = lastNameText.text!
                contact.number = numberText.text!
                delegate?.contactDetailsViewController(self, didFinishEditingFirstName: [contact], didFinishEditingLastName: [contact], didFinishEditingNumber: [contact])
            }else{
                let fname = firstNameText.text!
                let lname = lastNameText.text!
                let number = numberText.text!
                delegate?.contactDetailsViewController(self, didFinishAddingFirstName: fname, didFinishAddingLastName: lname, didFinishAddingNumber: number)
            }
            
        } else {
            // create the alert
            let alert = UIAlertController(title: "Contact Info", message: "Please enter all fields.", preferredStyle: UIAlertControllerStyle.alert)
            
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
//        if let contact = contactToEdit{
//            contact.firstName = firstNameText.text!
//            contact.lastName = lastNameText.text!
//            contact.number = numberText.text!
//            delegate?.contactDetailsViewController(self, didFinishEditingFirstName: [contact], didFinishEditingLastName: [contact], didFinishEditingNumber: [contact])
//        }else{
//            let fname = firstNameText.text!
//            let lname = lastNameText.text!
//            let number = numberText.text!
//            delegate?.contactDetailsViewController(self, didFinishAddingFirstName: fname, didFinishAddingLastName: lname, didFinishAddingNumber: number)
//        }
    }
    
}
