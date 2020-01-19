//
//  Colors.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

extension NSColor {
  func toHexString() -> String {
    var r: CGFloat = 0
    var g: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    getRed(&r, green: &g, blue: &b, alpha: &a)

    let rgb = Int(r * 255) << 16 | Int(g * 255) << 8 | Int(b * 255) << 0

    return String(format: "#%06x", rgb)
  }
}
