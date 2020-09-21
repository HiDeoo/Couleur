//
//  Notification.swift
//  Couleur
//
//  Created by HiDeo on 17/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation

extension Notification {
  /**
   * Sent when a color is copied to the clipboard.
   */
  static let ColorCopied = Notification.Name("ColorCopied")

  /**
   * Sent when a color is picked.
   */
  static let ColorPicked = Notification.Name("ColorPicked")
}
