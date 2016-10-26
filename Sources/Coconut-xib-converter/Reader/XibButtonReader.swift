//
//  XibButtonReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibButtonReader {
    
    func readButton(element: XmlDomElement) -> XibObject {
        print(" - Button : \(element.name)")
        return XibObject(id: element["id"]?.name)
    }
}
