//
//  XibButtonReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibButtonReader : XibElementReader {
    
    func read(element: XmlDomElement) -> UiButtonDefinition {
        print(" - Button : \(element.name)")
        return UiButtonDefinition(id: readId(element: element), uiDefinitionType: .button, vName: VNameGenerator.instance.createViewVName(type: "button"), customClass: "Button")
    }
}
