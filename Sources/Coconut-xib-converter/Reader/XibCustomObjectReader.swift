//
//  CustomObjectReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibCustomObjectReader {
    
    func readObject(element: XmlDomElement) -> XibCustomObject {
        print(" - Custom object : \(element.name)")
        return XibCustomObject(id: element["id"]?.value,
                               name: element["userLabel"]?.value,
                               customClass: element["customClass"]?.value)
    }
    
}
