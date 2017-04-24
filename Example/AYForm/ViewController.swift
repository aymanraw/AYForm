//
//  ViewController.swift
//  AYForm
//
//  Created by Ayman Rawashdeh on 4/6/17.
//  Copyright © 2017 Ayman Rawashdeh. All rights reserved.
//

import UIKit
import AYForm


class ViewController: UIViewController, UITableViewDelegate, AYFormDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    var ayForm: AYForm!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldTableViewCell")
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
        
        ayForm = AYForm(numberOfSections: 4)
        
        ayForm.addCell(cellIdentifier: "FieldTableViewCell", uniqueIdentifier: "NameCell", forSection: 0)
        ayForm.addField(unequeIdentifier: "NameCell", fieldOutput: "textField", label: "Name")
        ayForm.hideCell(uniqueIdentifier: "NameCell") // initially hide cell
        
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Email"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Phone Number"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Address"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 2, outputs: ("textField", "Password"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 2, outputs: ("textField", "Password Confirmation"))
        ayForm.addFields(cellIdentifier: "ButtonTableViewCell", forSection: 3, outputs: ("saveButton", "Save"))
        ayForm.addFields(cellIdentifier: "ButtonTableViewCell", forSection: 3, outputs: ("saveButton", "Save2"))
        
        
        tableView.delegate = self
        tableView.dataSource = ayForm
        
        ayForm.dataSource = self
    }
    
    
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, field: Any, cell: UITableViewCell) {
        
        
        if label == "Save", let saveButton = field as? UIButton {
            
            saveButton.addTarget(self, action: #selector(self.saveSelector), for: .touchUpInside)
        }
        
        if label == "Save2", let saveButton = field as? UIButton {
            
            saveButton.addTarget(self, action: #selector(self.saveSelector2), for: .touchUpInside)
        }
        
        if let textField = field as? UITextField {
            
            textField.placeholder = label
        }

    }
    
    
    func form(_ tableView: UITableView, titleForHeaderInSection section: Int, isHiddenSection: Bool) -> String? {
        
        if isHiddenSection {
            
            return nil
        }
        
        if section == 0 {
            
            return "User Info"
            
        }else if section == 1 {
            
            return "Contacts"
            
        }else if section == 2{
            
            return "Set Password"
        }
        
        return nil
    }
    
    
    
    func saveSelector(){
        
        ayForm.toggleCell(uniqueIdentifier: "NameCell", tableView: tableView)
        
        ayForm.hide(section: 2, tableView: tableView)
        
        print("Name: ", ayForm.field(label: "Name")?.text ?? "Name Field is Empty")
        print("Email: ", ayForm.field(label: "Email")?.text ?? "Email Field is Empty")
        print("Phone Number: ", ayForm.field(label: "Phone Number")?.text ?? "Phone Number Field is Empty")
        print("Address: ", ayForm.field(label: "Address")?.text ?? "Address Number Field is Empty")
        print("Password: ", ayForm.field(label: "Password")?.text ?? "Password Number Field is Empty")
        
    }
    
     func saveSelector2(){
        
         ayForm.show(section: 2, tableView: tableView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

