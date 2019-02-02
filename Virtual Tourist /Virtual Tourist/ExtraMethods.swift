//
//  ExtraMethods.swift
//  Virtual Tourist
//
//  Created by Bushra on 21/01/2019.
//  Copyright © 2019 Bushra Alkhushiban. All rights reserved.
//


import Foundation
import UIKit

struct randomPage {
    static func randomPageNumber() -> Int {
        return Int.random(in: 0 ... 15)
    }
}
