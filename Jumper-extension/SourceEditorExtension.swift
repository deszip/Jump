//
//  SourceEditorExtension.swift
//  Jumper-extension
//
//  Created by Deszip on 28/06/16.
//  Copyright © 2016 FHOF. All rights reserved.
//

import Foundation
import XcodeKit

class SourceEditorExtension: NSObject, XCSourceEditorExtension {
    
    func extensionDidFinishLaunching() {
        print("Extension launched...")
    }
    
    /*
    var commandDefinitions: [[XCSourceEditorCommandDefinitionKey: AnyObject]] {
        // If your extension needs to return a collection of command definitions that differs from those in its Info.plist, implement this optional property getter.
        return []
    }
    */
    
}
