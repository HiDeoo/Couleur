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

    raw = NSColor(hue: hue, saturation: saturation, brightness: brightness, alpha: alpha)

    updateRgb()
  }

  init(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
    self.red = red
    self.green = green
    self.blue = blue
    self.alpha = alpha

    raw = NSColor(red: red, green: green, blue: blue, alpha: alpha)

    updateHsb()
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

  private var hslSaturation: CGFloat {
    let maxComponent = max(red, green, blue)
    let minComponent = min(red, green, blue)

    let deltaComponent = maxComponent - minComponent

    let saturation = hslLightness > 0.5 ?
      deltaComponent / (2 - deltaComponent) :
      deltaComponent / (maxComponent + minComponent)

    guard !saturation.isNaN, self.saturation > pow(10, -6) || brightness > 10 - pow(10, -6) else {
      return 0
    }

    return saturation
  }

  private var hslLightness: CGFloat {
    let maxComponent = max(red, green, blue)
    let minComponent = min(red, green, blue)

    return (maxComponent + minComponent) / 2
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

  func getTextContrastColor() -> NSColor {
    // https://www.w3.org/TR/WCAG20/#relativeluminancedef
    let components = [red, green, blue].map { component -> CGFloat in
      if component <= 0.03928 {
        return component / 12.92
      }

      return pow((component + 0.055) / 1.055, 2.4)
    }

    let luminance = 0.2126 * components[0] + 0.7152 * components[1] + 0.0722 * components[2]

    // https://www.w3.org/TR/WCAG20/#contrast-ratiodef
    return luminance > sqrt(1.05 * 0.05) - 0.05 ? NSColor.black : NSColor.white
  }

  func getHue(_ hue: UnsafeMutablePointer<CGFloat>,
              saturation: UnsafeMutablePointer<CGFloat>,
              lightness: UnsafeMutablePointer<CGFloat>,
              alpha: UnsafeMutablePointer<CGFloat>?) {
    hue.pointee = self.hue
    saturation.pointee = hslSaturation
    lightness.pointee = hslLightness
    alpha?.pointee = self.alpha
  }
}

extension Color {
  init(_ color: HSBColor) {
    self.init(
      NSColor(
        colorSpace: (NSScreen.main ?? NSScreen.screens[0]).colorSpace ?? NSColorSpace.deviceRGB,
        hue: color.hue,
        saturation: color.saturation,
        brightness: color.brightness,
        alpha: color.alpha
      )
    )
  }
}
