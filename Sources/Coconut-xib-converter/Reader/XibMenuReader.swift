//
//  XibMenuReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibMenuReader {
    
    func readMenu(element: XmlDomElement) -> XibObject {
        print(" - Menu : \(element.name)")
        return XibObject(id: element["id"]?.name)
    }
}
