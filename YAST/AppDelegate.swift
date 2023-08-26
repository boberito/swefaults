//
//  Created by Gendler, Bob (Fed) on 8/22/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Cocoa



@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        // Insert code here to initialize your application
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func applicationShouldTerminateAfterLastWindowClosed(_ sender: NSApplication) -> Bool {
        return true
    }
    func applicationWillFinishLaunching(_ notification: Notification) {
        // print("applicationWillFinishLaunching")
        
        if CommandLine.arguments.count > 1 {
            let arguments = CommandLine.arguments
            
            let prefs = PrefClass()
            if arguments[1] == "--csv" {
                do {
                    let contents = try NSString(contentsOfFile: arguments[2], encoding: String.Encoding.utf8.rawValue)
                    let parsedCSV: [[String]] = contents.components(separatedBy: "\n").map{ $0.components(separatedBy: ",") }
                    
                    for entry in parsedCSV {
                        print("---------------------------------------------------")
                        let result = prefs.prefCheck(domain: entry[0], key: entry[1])
                        switch result.managed {
                            case .Managed:
                                print(result.domain!)
                                print("\(result.key!): \(result.value!)")
                                print("Managed")
                            case .NotManaged:
                                print(result.domain!)
                                print("\(result.key!): \(result.value!)")
                                print("Not Managed")
                                print(result.location!)
                            case .NotFound:
                                print(result.domain!)
                                print(result.key!)
                                print("Setting not found or set")
                        }
                        
                    }
                } catch {
                    print(error)
                }
                
            } else {
                let result = prefs.prefCheck(domain: arguments[1], key: arguments[2])
                switch result.managed {
                    case .Managed:
                        print(result.domain!)
                        print("\(result.key!): \(result.value!)")
                        print("Managed")
                    case .NotManaged:
                        print(result.domain!)
                        print("\(result.key!): \(result.value!)")
                        print("Not Managed")
                        print(result.location!)
                    case .NotFound:
                        print(result.domain!)
                        print(result.key!)
                        print("Setting not found or set")
                }
            }
            
            exit(0)
        }

    }
    
}

