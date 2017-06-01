//
//  ViewContactViewController.swift
//  Contact_list
//
//  Created by Basila Nathan on 3/24/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import Foundation
import UIKit

class ViewContactViewController: UIViewController{
    
    var contactToView: Contact?
    var contactToViewIndexPath: Int?
    weak var doneButtonDelegate: CancelButtonDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = contactToView?.firstName
        nameLabel.text = (contactToView?.firstName)! + " " + (contactToView?.lastName)!
        numberLabel.text = contactToView?.number
    }
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    
    @IBAction func doneBarButtonPressed(_ sender: UIBarButtonItem) {
        doneButtonDelegate?.cancelButtonPressedFrom(self)
    }
}
