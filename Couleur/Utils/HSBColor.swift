//
//  HSBColor.swift
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
struct HSBColor: Codable {
  public private(set) var raw: NSColor
  public private(set) var hue: CGFloat = 0
  public private(set) var saturation: CGFloat = 0
  public private(set) var brightness: CGFloat = 0
  public private(set) var alpha: CGFloat = 0
  public private(set) var red: CGFloat = 0
  public private(set) var blue: CGFloat = 0
  public private(set) var green: CGFloat = 0

  enum CodingKeys: CodingKey {
    case hue
    case saturation
    case brightness
    case alpha
  }

  init(_ rawColor: NSColor) {
    raw = rawColor

    updateHsb()
    updateRgb()
  }

  init(hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
    self.hue = hue
    self.saturation = saturation
    self.brightness = brightness
    self.alpha = alpha

    raw = NSColor(
      hue: hue,
      saturation: saturation,
      brightness: brightness,
      alpha: alpha
    )

    updateRgb()
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let hue = try container.decode(CGFloat.self, forKey: .hue)
    let saturation = try container.decode(CGFloat.self, forKey: .saturation)
    let brightness = try container.decode(CGFloat.self, forKey: .brightness)
    let alpha = try container.decode(CGFloat.self, forKey: .alpha)

    self = HSBColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(hue, forKey: .hue)
    try container.encode(saturation, forKey: .saturation)
    try container.encode(brightness, forKey: .brightness)
    try container.encode(alpha, forKey: .alpha)
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
}
