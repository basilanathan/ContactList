//
//  ContactDetailsViewControllerDelegate.swift
//  Contact_list
//
//  Created by Basila Nathan on 3/24/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import Foundation
import UIKit

protocol ContactDetailsViewControllerDelegate: class{
    
    func contactDetailsViewController(_ controller: ContactDetailsViewController, didFinishAddingFirstName fname: String, didFinishAddingLastName lname: String, didFinishAddingNumber number: String)
    
    func contactDetailsViewController(_ controller: ContactDetailsViewController, didFinishEditingFirstName fname: [Contact], didFinishEditingLastName lname: [Contact], didFinishEditingNumber number: [Contact])
}
