//
//  PrefResults.swift
//  YAST
//
//  Created by Bob Gendler on 9/1/19.
//  Copyright © 2019 Gendler, Bob (Fed). All rights reserved.
//

import Foundation

struct PrefResult {
    let managed: PrefStat
    let domain: String?
    let key: String?
    let value: String?
    let location: String?
}
