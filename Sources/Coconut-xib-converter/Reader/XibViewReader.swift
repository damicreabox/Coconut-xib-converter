//
//  XibViewReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 26/10/2016.
//
//

import Foundation

import LibXml2Swift

class XibViewReader {
    
    func readSubViews(element: XmlDomElement) -> [XibObject] {
        
        var subViews = [XibObject]()
        
        // Find subview node
        if let subViewNode = element.child(name: "subviews") {
            for node in subViewNode.children {
                if let child = node as? XmlDomElement {
                    switch child.name {
                    case "button":
                        subViews.append(XibButtonReader().readButton(element: child))
                        break
                    case "customView":
                        subViews.append(readView(element: child))
                        break
                    default:
                        print("Unknow element: \(child.name)")
                    }
                }
            }
        }
        
        return subViews
    }
    
    func readView(element: XmlDomElement) -> XibCustomView {
        print(" - View : \(element.name)")
        let viewDefinitions = readSubViews(element: element)
        return XibCustomView(id: element["id"]?.name,
                             subViews: viewDefinitions,
                             customClass: element["customClass"]?.value)
    }
}
