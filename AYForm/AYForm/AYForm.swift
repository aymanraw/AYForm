//
//  AYForm.swift
//  JoCars
//
//  Created by Ayman Rawashdeh on 3/29/17.
//  Copyright © 2017 Ayman Rawashdeh. All rights reserved.
//
import UIKit

public typealias Output = (String, label: String)
public typealias Cell = (identifier: String, uniqueIdentifier: String?, section: Int, outputs: [AYFormOutput])

public class AYFormOutput: NSObject {
    
    public var fieldOutput: String
    public var label: String
    
    init(fieldOutput: String, label: String) {
        
        self.fieldOutput = fieldOutput
        self.label = label
    }
    
    static func getOutputs(_ outputs: [(String, String)?]!) -> [AYFormOutput] {
        
        var array = [AYFormOutput]()
        
        if let outputs = outputs {
            
            for output in outputs {
                
                if let output = output {
                
                    array.append(AYFormOutput(fieldOutput: output.0, label: output.1))
                }
            }
        }
        
        return array
    }
}

public class AYFormCell {
    
    var identifier: String
    var uniqueIdentifier: String!
    var section: Int
    var outputs: [AYFormOutput]
    
    init(identifier: String, uniqueIdentifier: String!, section: Int, outputs: [AYFormOutput]! ) {
        
        self.identifier = identifier
        self.uniqueIdentifier = uniqueIdentifier
        self.section = section
        self.outputs = outputs ?? [AYFormOutput]()
    }
}



public protocol AYFormDelegate {
    
    @available( *, deprecated: 0.2.0, message: "Please use the new AYFormDataSource instead")
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, cell : UITableViewCell, field: Any, output: Output)
    
    @available( *, deprecated: 0.2.0, message: "Please use the new AYFormDataSource")
    func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath,cell : UITableViewCell, cellIdentifier: String)
    
    @available( *, deprecated: 0.2.0, message: "Please use the new AYFormDataSource instead")
    func form(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    
    @available( *, deprecated: 0.2.0, message: "Please use the new AYFormDataSource instead")
    func form(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
}

@objc public protocol AYFormDataSource: NSObjectProtocol {
    
    @objc optional func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath, label: String, field: Any, cell : UITableViewCell)
    @objc optional func form(_ tableView: UITableView, cellForRowAt indexPath: IndexPath,cell : UITableViewCell, cellIdentifier: String, uniqueIdentifier: String!)
    
    @objc optional func form(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String?
    @objc optional func form(_ tableView: UITableView, titleForFooterInSection section: Int) -> String?
}


public class AYForm: NSObject, UITableViewDataSource  {
    
    public var fieldsArray = [AYFormCell]()
    
    @available( *, deprecated: 0.2.0, message: "Please use the new AYFormDataSource instead")
    public var delegate: AYFormDelegate?
    
    public var dataSource: AYFormDataSource?
    public var numberOfSections: Int = 1
    
    private var refrenceDictionary = [String: AnyObject]()
   
    public init(numberOfSections: Int){
        super.init()
        
        self.numberOfSections = numberOfSections
    }
    
    public func addFields(cellIdentifier: String, forSection: Int, outputs: (String, String)!...){
        
        let cell = AYFormCell(identifier: cellIdentifier, uniqueIdentifier: nil, section: forSection, outputs: AYFormOutput.getOutputs(outputs))
        fieldsArray.append(cell)
    }
    
    public func addFields(cellIdentifier: String, uniqueIdentifier: String!, forSection: Int, outputs: (String, String)!...){
        
        let cell = AYFormCell(identifier: cellIdentifier, uniqueIdentifier: uniqueIdentifier, section: forSection, outputs: AYFormOutput.getOutputs(outputs))
        fieldsArray.append(cell)
    }
    
    public func addField(cellIdentifier: String, fieldOutput: String, label: String){
        
        let cell = fieldsArray.filter({$0.identifier == cellIdentifier}).first
        cell?.outputs.append(AYFormOutput(fieldOutput: fieldOutput, label: label))
    }
    
    public func addField(unequeIdentifier: String, fieldOutput: String, label: String){
        
        let cell = fieldsArray.filter({$0.uniqueIdentifier == unequeIdentifier}).first
        cell?.outputs.append(AYFormOutput(fieldOutput: fieldOutput, label: label))
    }
    
    public func addCell(cellIdentifier: String, uniqueIdentifier: String!, forSection: Int){
        
        let cell = AYFormCell(identifier: cellIdentifier, uniqueIdentifier: uniqueIdentifier, section: forSection, outputs: nil)
        fieldsArray.append(cell)
    }
    
    public func fields(inSection: Int) -> [AYFormCell]{
        
        return fieldsArray.filter({$0.section == inSection})
    }
    
    public func field(label: String) -> AnyObject? {
        
        return refrenceDictionary[label]
    }
    
    public func fields() -> [AnyObject] {
        
        var array = [AnyObject]()
        
        for value in refrenceDictionary.values {
            
            array.append(value)
        }
        
        return array
    }
    
    public func numberOfSections(in tableView: UITableView) -> Int {
        return numberOfSections
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fields(inSection: section).count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let field = fields(inSection: indexPath.section)[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: field.identifier, for: indexPath)
        
        for output in field.outputs {
            
            if let Field = cell.safeValue(forKey: output.fieldOutput) {
                
                refrenceDictionary[output.label] = Field as AnyObject
                
                // FIX: Deprecated method it will be removed in version 0.3.0
                delegate?.form(tableView, cellForRowAt: indexPath, label: output.label, cell: cell, field: Field, output: (output.fieldOutput, output.label))
                
                if dataSource?.responds(to: #selector(dataSource?.form(_:cellForRowAt:label:field:cell:))) == true {
                    
                    dataSource?.form!(tableView, cellForRowAt: indexPath, label: output.label, field: Field, cell: cell)
                }
                
            }else{
                
                print("(: AYForm :) Couldn't find output: ", output.fieldOutput)
            }
        }
        
        // FIX: Deprecated method it will be deleted in version 0.3.0
        delegate?.form(tableView, cellForRowAt: indexPath, cell: cell, cellIdentifier: field.identifier)
        
        if dataSource?.responds(to: #selector(dataSource?.form(_:cellForRowAt:cell:cellIdentifier:uniqueIdentifier:))) == true {
            
            dataSource?.form!(tableView, cellForRowAt: indexPath, cell: cell, cellIdentifier: field.identifier, uniqueIdentifier: field.uniqueIdentifier)
        }
        
        return cell
    }
    
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if dataSource?.responds(to: #selector(dataSource?.form(_:titleForHeaderInSection:))) == true {
            
            return dataSource?.form!(tableView, titleForHeaderInSection: section)
        }
        
        // FIX: Deprecated method it will be deleted in version 0.3.0
        return delegate?.form(tableView, titleForHeaderInSection: section)
        
    }
    
    public func tableView(_ tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        
        if dataSource?.responds(to: #selector(dataSource?.form(_:titleForFooterInSection:))) == true {
            
           return dataSource?.form!(tableView, titleForFooterInSection: section)
        }
        
        // FIX: Deprecated method it will be deleted in version 0.3.0
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
