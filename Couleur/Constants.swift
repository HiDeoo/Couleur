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
   * The size of the main window in point.
   */
  static let MainWindowSize = CGSize(width: 250, height: 528)

  /**
   * The height of the main window title bar.
   */
  static let MainWindowTitleBarHeight: CGFloat = 40

  /**
   * The size of the preferences window in point.
   */
  static let PreferencesWindowSize = CGSize(width: 500, height: 96)

  /**
   * The offset of a stacked view in point.
   */
  static let StackedViewOffset: CGFloat = 50

  /**
   * The height of the color preview component in point.
   */
  static let ColorPreviewHeight: CGFloat = 120

  /**
   * The default padding of classic windows.
   */
  static let WindowPadding: CGFloat = 15

  /**
   * The default padding of most views in point.
   */
  static let ViewPadding: CGFloat = 10

  /**
   * The height of linear sliders in the color editor in point.
   */
  static let ColorEditorLinearSliderHeight: CGFloat = 12

  /**
   * The color preview default color.
   */
  static let ColorPreviewDefaultColor = HSBColor(.blue)

  /**
   * The components editor default type.
   */
  static let ComponentsEditorDefaultType = ComponentsType.RGBA

  /**
   * Default value of the "use upper case letters for hexadecimal formats" setting.
   */
  static let UseUpperCaseHexDefault = false

  /**
   * Default value of the "automatically copy picked colors to the clipboard" setting.
   */
  static let CopyPickedColorDefault = false

  /**
   * The default color format.
   */
  static let ColorDefaultFormat = ColorFormat.CssHex

  /**
   * The dimension (width & height) of a point in the picker.
   */
  static let PickerPointDimension: CGFloat = 14

  /**
   * The number of points to show in the picker.
   * This should be an odd number.
   */
  static let PickerPointCount: CGFloat = 13

  /**
   * The dimension (width & height) of the picker.
   */
  static let PickerDimension: CGFloat = PickerPointDimension * PickerPointCount

  /**
   * The height of the color preview in the color picker.
   */
  static let PickerPreviewHeight: CGFloat = 35

  /**
   * The offset from the bottom of the screen until the picker preview is flipped.
   */
  static let PickerPreviewFlipOffset: CGFloat = 200

  /**
   * The default corder radius of rounded controls.
   */
  static let ControlCornerRadius: CGFloat = 4

  /**
   * The small corder radius of rounded controls.
   */
  static let ControlSmallCornerRadius: CGFloat = ControlCornerRadius / 2

  /**
   * The dimension (width & height) of a square in a transparency layer (in points).
   */
  static let TransparencyLayerSquareDimension: CGFloat = 6

  /**
   * The diameter in points of a pointer.
   */
  static let PointerDiameter: CGFloat = 15

  /**
   * The font size used in preferences.
   */
  static let PreferencesFontSize: CGFloat = 13

  /**
   * The checkboxes size in preferences.
   */
  static let PreferencesCheckboxSize: CGFloat = 16

  /**
   * Maximum size of the history.
   */
  static let HistorySize = 5

  /**
   * The size of a color entry in the history.
   */
  static let HistoryEntrySize = CGSize(width: 150, height: 185)

  /**
   * The size of a color preview in the history.
   */
  static let HistoryColorSize = CGSize(width: 23, height: 23)

  /**
   * The ordered red, green & blue components of the various colors used in the hue gradient.
   */
  static let HueGradientRgbs: [(CGFloat, CGFloat, CGFloat)] = [
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
