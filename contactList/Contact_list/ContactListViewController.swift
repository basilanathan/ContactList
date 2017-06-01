//
//  ViewController.swift
//  Contact_list
//
//  Created by Basila Nathan on 3/24/17.
//  Copyright © 2017 Basila Nathan. All rights reserved.
//

import UIKit
import CoreData

class ContactListViewController: UITableViewController, CancelButtonDelegate, ContactDetailsViewControllerDelegate {
    var contacts = [Contact]()
    var operant = 1
    let managedObjectContext = (UIApplication.shared.delegate as! AppDelegate).managedObjectContext
   
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchAllContacts()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func fetchAllContacts(){
        let userRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Contact")
        do {
            let results = try managedObjectContext.fetch(userRequest)
            contacts = results as! [Contact]
        } catch {
            print("\(error)")
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contacts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ContactCell") as! CustomContactCell
        cell.nameLabel!.text = contacts[indexPath.row].firstName! + " " + contacts[indexPath.row].lastName!
        cell.numberLabel!.text = contacts[indexPath.row].number
        return cell
    }

    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        operant = 0
        performSegue(withIdentifier: "ContactDetails", sender: self)
    }
    
    func cancelButtonPressedFrom(_ controller: UIViewController) {
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        let actionSheetController: UIAlertController = UIAlertController(title: "Please select", message: "What would you like to do?", preferredStyle: .actionSheet)
        let viewAction: UIAlertAction = UIAlertAction(title: "View", style: .default){action -> Void in
            self.operant = 2
            self.performSegue(withIdentifier: "ViewContact", sender: tableView.cellForRow(at: indexPath))
        }
        let editAction: UIAlertAction = UIAlertAction(title: "Edit", style: .default){action -> Void in
            self.operant = 1
            self.performSegue(withIdentifier: "ContactDetails", sender: tableView.cellForRow(at: indexPath))
        }
        let deleteAction: UIAlertAction = UIAlertAction(title: "Delete", style: .destructive){action -> Void in
                let appDel: AppDelegate = UIApplication.shared.delegate as! AppDelegate
                let context:NSManagedObjectContext = appDel.managedObjectContext
                context.delete(self.contacts[indexPath.row])
                self.contacts.remove(at: indexPath.row)
                if context.hasChanges {
                    do {
                        try context.save()
                        print("Success")
                    } catch {
                        print("\(error)")
                    }
                }
                self.tableView.deleteRows(at: [indexPath], with: .fade)
                self.fetchAllContacts()
                tableView.reloadData()
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel){action -> Void in
        }
        actionSheetController.addAction(viewAction)
        actionSheetController.addAction(editAction)
        actionSheetController.addAction(deleteAction)
        actionSheetController.addAction(cancelAction)
        self.present(actionSheetController, animated: true, completion: nil)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if operant == 2{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ViewContactViewController
            controller.doneButtonDelegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.contactToView = contacts[indexPath.row]
                controller.contactToViewIndexPath = indexPath.row
            }
        }
        if operant == 0{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ContactDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
        }
        if operant == 1{
            let navigationController = segue.destination as! UINavigationController
            let controller = navigationController.topViewController as! ContactDetailsViewController
            controller.cancelButtonDelegate = self
            controller.delegate = self
            if let indexPath = tableView.indexPath(for: sender as! UITableViewCell){
                controller.contactToEdit = contacts[indexPath.row]
                controller.contactToEditIndexPath = indexPath.row
            }

        }
    }
    
    func contactDetailsViewController(_ controller: ContactDetailsViewController, didFinishAddingFirstName fname: String, didFinishAddingLastName lname: String, didFinishAddingNumber number: String) {
        dismiss(animated: true, completion: nil)
        let add = NSEntityDescription.insertNewObject(forEntityName: "Contact", into: managedObjectContext) as! Contact
        add.firstName = fname
        add.lastName = lname
        add.number = number
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllContacts()
        tableView.reloadData()
    }
    
    func contactDetailsViewController(_ controller: ContactDetailsViewController, didFinishEditingFirstName fname: [Contact], didFinishEditingLastName lname: [Contact], didFinishEditingNumber number: [Contact]) {
        dismiss(animated: true, completion: nil)
        if managedObjectContext.hasChanges {
            do {
                try managedObjectContext.save()
                print("Success")
            } catch {
                print("\(error)")
            }
        }
        fetchAllContacts()
        tableView.reloadData()
    }
//    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        let appDel: AppDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
//        let context:NSManagedObjectContext = appDel.managedObjectContext
//        context.deleteObject(contacts[indexPath.row])
//        contacts.removeAtIndex(indexPath.row)
//        if context.hasChanges {
//            do {
//                try context.save()
//                print("Success")
//            } catch {
//                print("\(error)")
//            }
//        }
//        self.tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
//        fetchAllContacts()
//        tableView.reloadData()
//    }

}

