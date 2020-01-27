//
//  CColor.swift
//  Couleur
//
//  Created by HiDeo on 22/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

/**
 * A structure wrapping a `NSColor` but manually keeping track of hue, saturation & brightness.
 *
 * As HSB is just a particular way to represent a RGB color but not how the colors are stored, if we create a `NSColor`with a saturation of zero, the resulting color
 * will have no hue at all, which means we would lose the hue component entirely without any way to retrieve it back.
 */
struct CColor {
  public private(set) var raw: NSColor
  public private(set) var hue: CGFloat = 0
  public private(set) var saturation: CGFloat = 0
  public private(set) var brightness: CGFloat = 0
  public private(set) var alpha: CGFloat = 0
  public private(set) var red: CGFloat = 0
  public private(set) var blue: CGFloat = 0
  public private(set) var green: CGFloat = 0

  init(_ rawColor: NSColor) {
    raw = rawColor

    updateHsb()
    updateRgb()
  }

  mutating func updateHsb() {
    raw.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
  }

  mutating func updateRgb() {
    raw.getRed(&red, green: &green, blue: &blue, alpha: nil)
  }

  mutating func setHue(_ hue: CGFloat) {
    self.hue = hue

    raw = NSColor(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha
    )

    updateRgb()
  }

  mutating func setSaturationAndBrightness(_ saturation: CGFloat, _ brightness: CGFloat) {
    self.saturation = saturation
    self.brightness = brightness

    raw = NSColor(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha
    )

    updateRgb()
  }

  mutating func setAlpha(_ alpha: CGFloat) {
    self.alpha = alpha

    raw = NSColor(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha
    )

    updateRgb()
  }

  mutating func setRgb(red: CGFloat, green: CGFloat, blue: CGFloat) {
    self.red = red
    self.green = green
    self.blue = blue

    raw = NSColor(
      red: red,
      green: green,
      blue: blue,
      alpha: alpha
    )

    updateHsb()
  }

  func toHexString() -> String {
    let rgb = Int(red * 255) << 16 | Int(green * 255) << 8 | Int(blue * 255) << 0

    return String(format: "#%06x", rgb)
  }
}
