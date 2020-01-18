//
//  Constants.swift
//  Couleur
//
//  Created by HiDeo on 14/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Constants {
  /**
   * The size (width & height) of the color preview component in point.
   */
  static let ColorPreviewSize: CGFloat = 150

  /**
   * The color preview default color.
   */
  static let ColorPreviewDefaultColor = NSColor.red

  /**
   * The size (width & height) of a point in the picker.
   */
  static let PickerPointSize: CGFloat = 14

  /**
   * The number of points to show in the picker.
   * This should be an odd number.
   */
  static let PickerPointCount: CGFloat = 13

  /**
   * The size (width & height) of the picker.
   */
  static let PickerSize: CGFloat = PickerPointSize * PickerPointCount
}
