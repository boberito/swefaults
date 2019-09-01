//
//  PrefClass.swift
//  YAST
//
//  Created by Gendler, Bob (Fed) on 8/27/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Foundation

class PrefClass {
    func prefCheck(domain: String, key: String) -> (PrefResult){
        let bundle_plist = UserDefaults.init(suiteName: domain)
        
        if let preference_value = bundle_plist?.value(forKey: key) {
  
            if CFPreferencesAppValueIsForced(key as CFString, domain as CFString) {
                return (PrefResult(managed: .Managed, domain: domain, key: key, value: "\(preference_value)", location: nil))
            } else {
                
                let homeDirURL = FileManager.default.homeDirectoryForCurrentUser
                let levels = [
                    ["file": "\(homeDirURL.path)/Library/Preferences/ByHost/\(domain).xxxx.plist",
                        "domain": domain,
                        "user": kCFPreferencesCurrentUser,
                        "host": kCFPreferencesCurrentHost
                    ],
                    ["file": "\(homeDirURL.path)/Library/Preferences/\(domain).plist",
                        "domain": domain,
                        "user": kCFPreferencesCurrentUser,
                        "host": kCFPreferencesAnyHost
                    ],
                    ["file": "\(homeDirURL.path)/Library/Preferences/ByHost/.GlobalPreferences.xxxx.plist",
                        "domain": ".GlobalPreferences",
                        "user": kCFPreferencesCurrentUser,
                        "host": kCFPreferencesCurrentHost
                    ],
                    ["file": "\(homeDirURL.path)/Library/Preferences/.GlobalPreferences.plist",
                        "domain": ".GlobalPreferences",
                        "user": kCFPreferencesCurrentUser,
                        "host": kCFPreferencesAnyHost
                    ],
                    ["file": "/Library/Preferences/\(domain).plist",
                        "domain": domain,
                        "user": kCFPreferencesAnyUser,
                        "host": kCFPreferencesCurrentHost
                    ],
                    ["file": "/Library/Preferences/.GlobalPreferences.plist",
                     "domain": ".GlobalPreferences",
                     "user": kCFPreferencesAnyUser,
                     "host": kCFPreferencesCurrentHost
                    ],
                ]
                
                for level in levels {
                    if CFPreferencesCopyValue(key as CFString, level["domain"] as! CFString, level["user"] as! CFString, level["host"] as! CFString) != nil {
                        return (PrefResult(managed: .NotManaged, domain: (level["domain"] as! String), key: key, value: "\(preference_value as Any)", location: (level["file"] as! String)))
                        
                    }
                }
            }
        }
        return(PrefResult(managed: .NotFound, domain: domain, key: nil, value: nil, location: nil))
        
    }
}
