//
//  ArrayExtension.swift
//  YAST
//
//  Created by Gendler, Bob (Fed) on 9/5/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Foundation

extension Array where Element: Hashable {
    func removingDuplicates() -> [Element] {
        var addedDict = [Element: Bool]()
        
        return filter {
            addedDict.updateValue(true, forKey: $0) == nil
        }
    }
    
    mutating func removeDuplicates() {
        self = self.removingDuplicates()
    }
}
