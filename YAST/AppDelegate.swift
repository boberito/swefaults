//
//  AppDelegate.swift
//  MacCacher
//
//  Created by Gendler, Bob (Fed) on 6/26/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Cocoa



//@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    @IBOutlet weak var preferencesMenuItem: NSMenuItem!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    
}
