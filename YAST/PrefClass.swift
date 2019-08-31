//
//  PrefClass.swift
//  YAST
//
//  Created by Gendler, Bob (Fed) on 8/27/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Foundation

class PrefClass {
    func prefCheck(domain: String, key: String) -> (managed: PrefStat, domain: String?, key: String?, value: String?, location: String?){
        let bundle_plist = UserDefaults.init(suiteName: domain)
        
        if let preference_value = bundle_plist?.value(forKey: key) {
  
            if CFPreferencesAppValueIsForced(key as CFString, domain as CFString) {
                
                return ( .Managed, domain, key, "\(preference_value as Any)", nil)
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
                        return (.NotManaged, (level["domain"] as! String), key, "\(preference_value as Any)",(level["file"] as! String))
                        
                    }
                }
            }
        }
        return(.NotFound,domain,nil,nil,nil)
    }
}
