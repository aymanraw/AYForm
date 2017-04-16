//
//  ViewController.swift
//  AYForm
//
//  Created by Ayman Rawashdeh on 4/6/17.
//  Copyright © 2017 Ayman Rawashdeh. All rights reserved.
//

import UIKit
import AYForm


class ViewController: UIViewController, UITableViewDelegate, AYFormDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    var ayForm: AYForm!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UINib(nibName: "FieldTableViewCell", bundle: nil), forCellReuseIdentifier: "FieldTableViewCell")
        tableView.register(UINib(nibName: "ButtonTableViewCell", bundle: nil), forCellReuseIdentifier: "ButtonTableViewCell")
        
        ayForm = AYForm(numberOfSections: 4)
        
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 0, outputs: ("textField", "Name"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Email"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Phone Number"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 1, outputs: ("textField", "Address"))
        ayForm.addFields(cellIdentifier: "FieldTableViewCell", forSection: 2, outputs: ("textField", "Password"))
        ayForm.addFields(cellIdentifier: "ButtonTableViewCell", forSection: 3, outputs: ("saveButton", "Save"))
        
        tableView.delegate = self
        tableView.dataSource = ayForm
        
        ayForm.delegate = self
    }
    
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, cell: UITableViewCell, field: Any, output: Output) {
        
        if output.1 == "Save", let saveButton = field as? UIButton {
            
            saveButton.addTarget(self, action: #selector(self.saveSelector), for: .touchUpInside)
        }
        
        if let textField = field as? UITextField {
            
            textField.placeholder = output.1
        }
    }
    func form(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        
        if section == 0 {
            
            return "User Info"
            
        }else if section == 1 {
            
            return "Contacts"
            
        }else if section == 2{
        
            return "Set Password"
        }
        
        return nil
        
    }
    
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, cell: UITableViewCell, cellIdentifier: String) {
        
    }
    func form(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        
        return nil
    }
    
    func saveSelector(){
        
        print("Name: ", ayForm.field(label: "Name")?.text ?? "Name Field is Empty")
        print("Email: ", ayForm.field(label: "Email")?.text ?? "Email Field is Empty")
        print("Phone Number: ", ayForm.field(label: "Phone Number")?.text ?? "Phone Number Field is Empty")
        print("Address: ", ayForm.field(label: "Address")?.text ?? "Address Number Field is Empty")
        print("Password: ", ayForm.field(label: "Password")?.text ?? "Password Number Field is Empty")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

