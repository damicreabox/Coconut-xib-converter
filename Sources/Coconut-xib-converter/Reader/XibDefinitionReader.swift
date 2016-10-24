//
//  XibDefinitionReader.swift
//  Coconut-xib-converter
//
//  Created by Dami on 23/10/2016.
//
//

import Foundation

import LibXml2Swift

public enum XibReaderError : Error {
    case notValid(msg: String)
    case unknow(msg: String)
}

public class XibDefinitionReader {
    
    private func readElements(element: XmlDomElement) -> (
        objects: Dictionary<String,XibCustomObject>,
        windows: Dictionary<String,XibObject>,
        views: Dictionary<String,XibObject>,
        menu: XibObject?) {
            
            var objects = Dictionary<String,XibCustomObject>()
            var windows = Dictionary<String,XibObject>()
            var views = Dictionary<String,XibObject>()
            var menus = Dictionary<String,XibObject>()
            
            for node in element.children {
                if let child = node as? XmlDomElement {
                    switch child.name {
                    case "customObject":
                        let object = readObject(element: child)
                        objects[object.id] = object
                        break
                    case "window":
                        let window = readWindow(element: child)
                        windows[window.id] = window
                        break
                    case "customView":
                        let view = readView(element: child)
                        views[child.name] = view
                        break
                    case "menu":
                        let menu = readMenu(element: child)
                        menus[child.name] = menu
                        break
                    default:
                        print("Unknow element: \(child.name)")
                    }
                }
            }
            
            return (objects, windows, views, menus.popFirst()?.value)
    }
    
    private func readObject(element: XmlDomElement) -> XibCustomObject {
        print(" - Custom object : \(element.name)")
        return XibCustomObject(id: element.attribute(name: "id")?.value,
                               name: element.attribute(name: "userLabel")?.value,
                               customClass: element.attribute(name: "customClass")?.value)
    }
    
    private func readWindow(element: XmlDomElement) -> XibObject {
        print(" - Window : \(element.name)")
        let view: XibCustomView?
        if let viewElement = element["view"] {
            view = readView(element: viewElement)
        } else {
            view = nil
        }
        return XibWindow(id: element.attribute(name: "id")?.name, view: view)
    }
    
    private func readSubViews(element: XmlDomElement) -> [XibObject] {
        
        var subViews = [XibObject]()
        
        // Find subview node
        if let subViewNode = element["subviews"] {
            for node in subViewNode.children {
                if let child = node as? XmlDomElement {
                    switch child.name {
                    case "button":
                        subViews.append(readButton(element: child))
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
    
    private func readView(element: XmlDomElement) -> XibCustomView {
        print(" - View : \(element.name)")
        let viewDefinitions = readSubViews(element: element)
        return XibCustomView(id: element.attribute(name: "id")?.name, subViews: viewDefinitions)
    }
    
    private func readButton(element: XmlDomElement) -> XibObject {
        print(" - Button : \(element.name)")
        return XibObject(id: element.attribute(name: "id")?.name)
    }
    
    private func readMenu(element: XmlDomElement) -> XibObject {
        print(" - Menu : \(element.name)")
        return XibObject(id: element.attribute(name: "id")?.name)
    }
    
    public func read(at url: URL) throws ->  XibDefinition {
        
        // Read XML document
        let rootXibDocument = try XmlDomReader.read(atPath: url)
        
        // Check root document
        let rootElement = try rootXibDocument.rootElement()
        guard (rootElement.name == "document") else {
            throw XibReaderError.notValid(msg: "There is no document element")
        }
        
        // Read elements
        guard let objectsElement = rootElement["objects"] else {
            throw XibReaderError.notValid(msg: "No objects node")
        }
        
        // Read all objects
        let results = readElements(element: objectsElement)
        
        let xibDefinition = XibDefinition(objects: results.objects,
                                          windows: results.windows,
                                          views: results.views,
                                          menu: results.menu)
        
        return xibDefinition
    }
}
