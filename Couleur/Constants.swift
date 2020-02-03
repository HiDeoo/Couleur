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
   * The width of the main window in point.
   */
  static let MainWindowWidth: CGFloat = 250

  /**
   * The height of the color preview component in point.
   */
  static let ColorPreviewHeight: CGFloat = 120

  /**
   * The padding of the color editor in point.
   */
  static let ColorEditorPadding: CGFloat = 10

  /**
   * The height of linear sliders in the color editor in point.
   */
  static let ColorEditorLinearSliderHeight: CGFloat = 12

  /**
   * The color preview default color.
   */
  static let ColorPreviewDefaultColor = CColor(.blue)

  /**
   * The components editor default type.
   */
  static let ComponentsEditorDefaultType = ComponentsType.RGBA

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

  /**
   * The default corder radius of rounded controls.
   */
  static let ControlCornerRadius: CGFloat = 4

  /**
   * The ordered red, green & blue components of the various colors used in the hue gradient.
   */
  static let HueGradientRgbs: [(Double, Double, Double)] = [
    (255, 0, 0),
    (255, 128, 0),
    (255, 255, 0),
    (128, 255, 0),
    (0, 255, 0),
    (0, 255, 128),
    (0, 255, 255),
    (0, 128, 255),
    (0, 0, 255),
    (128, 0, 255),
    (255, 0, 255),
    (255, 0, 128),
    (255, 0, 0),
  ]
}
