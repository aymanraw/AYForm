//
//  AYForm.swift
//  JoCars
//
//  Created by Ayman Rawashdeh on 3/29/17.
//  Copyright © 2017 Ayman Rawashdeh. All rights reserved.
//

import UIKit

typealias Label = String
typealias Output = (String, Label)
typealias Cell = (identifier: String, section: Int, outputs: [Output])

protocol AYFormDelegate {
    
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, cell : UITableViewCell, field: Any, output: Output)
    func form(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    func form(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
}

class AYForm: NSObject, UITableViewDataSource  {
    
    private var numberOfSections: Int = 1
    
    public var fieldsArray = [Cell]()
    private var refrenceDictionary = [Label: AnyObject]()
    public var delegate: AYFormDelegate?
    
    init(numberOfSections: Int){
        super.init()
        
        self.numberOfSections = numberOfSections
    }
    
    func addFields(cellIdentifier: String, forSection: Int, outputs: Output...){
        
        fieldsArray.append((cellIdentifier, forSection, outputs))
    
    }
    
    func fields(inSection: Int) -> [Cell]{
        
        return fieldsArray.filter({$0.1 == inSection})
    }
    
    public func field(label: Label) -> AnyObject? {
        
        return refrenceDictionary[label]
    }
    
    public func fields() -> [AnyObject] {
        
        var array = [AnyObject]()
        
        for value in refrenceDictionary.values {
            
            array.append(value)
        }
        
        return array
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields(inSection: section).count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let field = fields(inSection: indexPath.section)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: field.identifier, for: indexPath)
        
        for output in field.outputs {
            
            if let textField = cell.safeValue(forKey: output.0) {
                
                refrenceDictionary[output.1] = textField as AnyObject
                delegate?.form(tableView, cellForRowAt: indexPath, label: output.1, cell: cell, field: textField, output: output )
            }else{
                
                print("(: AYForm :) Couldn't find output: ", output.0)
            }
        }
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return delegate?.form(tableView, titleForHeaderInSection: section)
    }
    
    func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        return delegate?.form(tableView, titleForFooterInSection: section)
    }
    
    
    
}



public extension NSObject {
    func safeValue(forKey key: String) -> Any? {
        let copy = Mirror(reflecting: self)
        for child in copy.children.makeIterator() {
            if let label = child.label, label == key {
                return child.value
            }
        }
        return nil
    }
}
