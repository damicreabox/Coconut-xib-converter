//
//  DocumentDefinition.swift
//  Coconut-xib-converter
//
//  Created by Dami on 16/10/2016.
//
//

import Foundation
import LibXml2Swift

public enum ConverterError : Error {
    case unknowError(msg: String)
}

func unknownNode(node: XmlDomNode) {
    print("node: \(node.name)")
}

public class XibDefinition {
    public var name: String = "MyUIClass"
    public var objects = [XibCustomObject]()
    public var windows = [XibWindow]()
    public var views = [XibCustomView]()
    public var menu: XibObject? = nil
}
