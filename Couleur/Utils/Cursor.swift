//
//  Cursor.swift
//  Couleur
//
//  Created by HiDeo on 03/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Cursor {
  public static var isVisible = true

  static func show() {
    if !isVisible {
      isVisible = true
      NSCursor.unhide()
    }
  }

  static func hide() {
    if isVisible {
      isVisible = false
      NSCursor.hide()
    }
  }
}
