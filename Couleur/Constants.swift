//
//  Constants.swift
//  Couleur
//
//  Created by HiDeo on 14/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation

struct Constants {
  /**
   * The size (width & height) of a point in the picker.
   */
  static let PickerPointSize: CGFloat = 20

  /**
   * The number of points to show in the picker.
   * This should be an odd number.
   */
  static let PickerPointCount: CGFloat = 9

  /**
   * The size (width & height) of the picker.
   */
  static let PickerSize: CGFloat = PickerPointSize * PickerPointCount
}
