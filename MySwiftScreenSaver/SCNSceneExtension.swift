//
//  SCNSceneExtension.swift
//  MySwiftScreenSaver
//
//  Created by Hill, Michael on 6/30/16.
//  Copyright © 2016 Hill, Michael. All rights reserved.
//

import Cocoa
import SceneKit

extension SCNScene {
    
    public convenience init?(pathAwareName name: String) {
        let bundle = NSBundle.pathAwareBundle()
        if let sceneURL = bundle.URLForResource( name, withExtension: nil) {
            try! self.init(URL: sceneURL, options: nil )
            
            //attempt to fix materials, needed if you have paths in your bundle
            //repointMaterialForChildNodes(self.rootNode)
            
        } else {
            self.init(named: name)
        }
    }
    
    func repointMaterialForChildNodes( node: SCNNode) {
        for childNode in (node.childNodes) {
            //repoint all materials
            if let geometry = childNode.geometry {
                for material in geometry.materials {
                    repointMaterial(material)
                }
            }
            for newNode in childNode.childNodes {
                repointMaterialForChildNodes(newNode)
            }
        }
        
    }
    
    func repointMaterial(material: SCNMaterial) {
        let properties = [ material.diffuse, material.normal, material.specular, material.reflective]
        for property in properties {
            repointContentInMaterialProperty(property)
        }
    }
    
    func repointContentInMaterialProperty( property: SCNMaterialProperty ) {
        if let contents = property.contents {
            if let filename = filenameInMaterialContentDescription( contents.description ) {
                if let newImage = NSImage(pathAwareName: filename) {
                    property.contents = newImage
                }
            }
        }
    }
    
    func filenameInMaterialContentDescription(contentString: String ) -> String? {
        let l = contentString.componentsSeparatedByString(" -- ")
        let filePath = l[0]
        if let url = NSURL.init(string: filePath) {
            if let components = url.pathComponents {
                if let lastComp = components.last {
                    return lastComp
                }
            }
        }
        
        //else
        return nil
    }
}
