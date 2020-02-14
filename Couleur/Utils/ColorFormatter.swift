//
//  ColorFormatter.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

enum ColorFormat: Int, CaseIterable {
  case AndroidArgb
  case AndroidRgb
  case AndroidXmlArgb
  case AndroidXmlRgb
  case CssHex
  case CssHsl
  case CssHsla
  case CssRgb
  case CssRgba
  case SwiftNsHsb
  case SwiftNsRgb
  case SwiftUIHsb
  case SwiftUIRgb
}

private enum ColorComponent {
  case Red
  case Green
  case Blue
  case Alpha
}

class ColorFormatter {
  private static let definitions: [ColorFormat: ColorFormatDefinition] = [
    .AndroidArgb: ColorFormatDefinition(description: "Android ARGB", formatter: toAndroidArgb),
    .AndroidRgb: ColorFormatDefinition(description: "Android RGB", formatter: toAndroidRgb),
    .AndroidXmlArgb: ColorFormatDefinition(description: "Android XML ARGB", formatter: toAndroidXmlArgb),
    .AndroidXmlRgb: ColorFormatDefinition(description: "Android XML RGB", formatter: toAndroidXmlRgb),
    .CssHex: ColorFormatDefinition(description: "CSS Hex", formatter: toCssHex),
    .CssHsl: ColorFormatDefinition(description: "CSS HSL", formatter: toCssHsl),
    .CssHsla: ColorFormatDefinition(description: "CSS HSLA", formatter: toCssHsla),
    .CssRgb: ColorFormatDefinition(description: "CSS RGB", formatter: toCssRgb),
    .CssRgba: ColorFormatDefinition(description: "CSS RGBA", formatter: toCssRgba),
    .SwiftNsHsb: ColorFormatDefinition(description: "Swift NSColor HSB", formatter: toSwiftNsHsb),
    .SwiftNsRgb: ColorFormatDefinition(description: "Swift NSColor RGB", formatter: toSwiftNsRgb),
    .SwiftUIHsb: ColorFormatDefinition(description: "Swift UIColor HSB", formatter: toSwiftUIHsb),
    .SwiftUIRgb: ColorFormatDefinition(description: "Swift UIColor RGB", formatter: toSwiftUIRgb),
  ]

  static func getDescription(format: ColorFormat) -> String {
    guard let description = definitions[format]?.description else { return "" }

    return description
  }

  static func format(_ color: HSBColor, _ format: ColorFormat) -> String {
    guard let formatter = definitions[format]?.formatter else { return "" }

    return formatter(color)
  }

  private static func get8BitsComponent(_ color: HSBColor, _ component: ColorComponent) -> UInt {
    let value: CGFloat

    switch component {
    case .Red: value = color.red
    case .Green: value = color.green
    case .Blue: value = color.blue
    case .Alpha: value = color.alpha
    }

    return UInt(value * 255)
  }

  private static func getHSLA(_ color: HSBColor) -> (hue: UInt, saturation: UInt, lightness: UInt, alpha: UInt) {
    var hue: CGFloat = 0
    var saturation: CGFloat = 0
    var lightness: CGFloat = 0
    var alpha: CGFloat = 0

    color.getHue(&hue, saturation: &saturation, lightness: &lightness, alpha: &alpha)

    return (
      hue: UInt(hue * 360),
      saturation: UInt(saturation * 100),
      lightness: UInt(lightness * 100),
      alpha: UInt(alpha * 100)
    )
  }

  private static func getHexComponent(_ color: HSBColor, _ component: ColorComponent) -> UInt {
    let operand: UInt

    switch component {
    case .Red: operand = 16
    case .Green: operand = 8
    case .Blue: operand = 0
    case .Alpha: operand = 24
    }

    return get8BitsComponent(color, component) << operand
  }

  private static func toSwiftColor(_ components: [(String, CGFloat)], prefix: String) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 4

    var result = "\(prefix)("

    for (index, (key, value)) in components.enumerated() {
      result += "\(key): \(formatter.string(from: value as NSNumber) ?? "0")"

      if index < components.count {
        result += ","
      }
    }

    return "\(result))"
  }

  private static func toAndroidArgb(_ color: HSBColor) -> String {
    String(
      format: "Color.argb(%d, %d, %d, %d)",
      get8BitsComponent(color, .Alpha),
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toAndroidRgb(_ color: HSBColor) -> String {
    String(
      format: "Color.rgb(%d, %d, %d)",
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toAndroidXmlArgb(_ color: HSBColor) -> String {
    String(
      format: "<color name=\"color_name\">%08x</color>",
      getHexComponent(color, .Alpha) |
        getHexComponent(color, .Red) |
        getHexComponent(color, .Green) |
        getHexComponent(color, .Blue)
    )
  }

  private static func toAndroidXmlRgb(_ color: HSBColor) -> String {
    String(
      format: "<color name=\"color_name\">%06x</color>",
      getHexComponent(color, .Red) | getHexComponent(color, .Green) | getHexComponent(color, .Blue)
    )
  }

  private static func toCssHex(_ color: HSBColor) -> String {
    String(
      format: "#%06x",
      getHexComponent(color, .Red) | getHexComponent(color, .Green) | getHexComponent(color, .Blue)
    )
  }

  private static func toCssHsl(_ color: HSBColor) -> String {
    let hsla = getHSLA(color)

    return String(format: "hsl(%d, %d%%, %d%%);", hsla.hue, hsla.saturation, hsla.lightness)
  }

  private static func toCssHsla(_ color: HSBColor) -> String {
    let hsla = getHSLA(color)

    return String(format: "hsla(%d, %d%%, %d%%, %d%%);", hsla.hue, hsla.saturation, hsla.lightness, hsla.alpha)
  }

  private static func toCssRgb(_ color: HSBColor) -> String {
    String(
      format: "rgb(%d, %d, %d)",
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toCssRgba(_ color: HSBColor) -> String {
    String(
      format: "rgba(%d, %d, %d, %d%%)",
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue),
      UInt(color.alpha * 100)
    )
  }

  private static func toSwiftNsHsb(_ color: HSBColor) -> String {
    toSwiftColor(
      [("hue", color.hue), ("saturation", color.saturation), ("brightness", color.brightness), ("alpha", color.alpha)],
      prefix: "NSColor"
    )
  }

  private static func toSwiftNsRgb(_ color: HSBColor) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: "NSColor"
    )
  }

  private static func toSwiftUIHsb(_ color: HSBColor) -> String {
    toSwiftColor(
      [("hue", color.hue), ("saturation", color.saturation), ("brightness", color.brightness), ("alpha", color.alpha)],
      prefix: "UIColor"
    )
  }

  private static func toSwiftUIRgb(_ color: HSBColor) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: "UIColor"
    )
  }
}

private struct ColorFormatDefinition {
  let description: String
  let formatter: (_ color: HSBColor) -> String
}

extension ColorFormat: Codable {
  enum CodingKeys: CodingKey {
    case rawValue
  }

  init(from decoder: Decoder) throws {
    let container = try decoder.container(keyedBy: CodingKeys.self)
    let rawValue = try container.decode(Int.self, forKey: .rawValue)

    self = ColorFormat(rawValue: rawValue) ?? Constants.ColorDefaultFormat
  }

  func encode(to encoder: Encoder) throws {
    var container = encoder.container(keyedBy: CodingKeys.self)
    try container.encode(rawValue, forKey: .rawValue)
  }
}
