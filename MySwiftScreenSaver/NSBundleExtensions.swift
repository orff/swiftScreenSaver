//
//  NSBundleExtensions.swift
//  MySwiftScreenSaver
//
//  Created by Hill, Michael on 7/1/16.
//  Copyright © 2016 Hill, Michael. All rights reserved.
//

import Cocoa

extension NSBundle {
    static func pathAwareBundle() -> NSBundle {
        return NSBundle(forClass:object_getClass(swiftSS))
    }
    
    static func registerFonts() {
        //force registration of the fonts
        let bundle = self.pathAwareBundle()
        if let fontURLs = bundle.URLsForResourcesWithExtension( "TTF" , subdirectory: "" ) {
            
            for fontURL in fontURLs {
                //let url = NSURL(fileURLWithPath: fontURL as String)
                var errorRef: Unmanaged<CFError>?
                let succeeded = CTFontManagerRegisterFontsForURL(fontURL, .Process, &errorRef)
                
                if (errorRef != nil) {
                    let error = errorRef!.takeRetainedValue()
                }
            }
        }
    }
}
