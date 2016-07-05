//
//  NSImageExtensions.swift
//  MySwiftScreenSaver
//
//  Created by Hill, Michael on 7/1/16.
//  Copyright © 2016 Hill, Michael. All rights reserved.
//

import Cocoa

extension NSImage {
    
    public convenience init?(pathAwareName name:String ) {
        if let imageURL = NSBundle.pathAwareBundle().URLForResource(name, withExtension: nil) {
            self.init(contentsOfURL: imageURL)!
        } else {
            self.init(named: name)
        }
    }
}
