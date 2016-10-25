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

    public let name: String = "MyUI"
    public let objects: Dictionary<String,XibCustomObject>
    public let windows: Dictionary<String,XibWindow>
    public let views: Dictionary<String,XibCustomView>
    public let menu: XibObject?
    
    public init(objects: Dictionary<String,XibCustomObject>,
                windows: Dictionary<String,XibWindow>,
                views: Dictionary<String,XibCustomView>,
                menu: XibObject?) {
        self.objects = objects
        self.windows = windows
        self.views = views
        self.menu = menu
    }
    
}
