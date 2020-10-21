//
//  ColorFormatter.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

enum ColorFormat: Int, CaseIterable {
  case CssHex
  case CssHsl
  case CssHsla
  case CssRgb
  case CssRgba
  case SwiftAppKitHsb
  case SwiftAppKitRgb
  case SwiftUiKitHsb
  case SwiftUiKitRgb
  case SwiftUiHsb
  case SwiftUiRgb
  case CgColorRgb
  case CgColorCmyk
  case AndroidRgb
  case AndroidArgb
  case AndroidXmlRgb
  case AndroidXmlArgb
}

struct ColorFormatterOptions {
  let useUpperCaseHex: Bool
  let useSpaceSeparatedCss: Bool
}

extension ColorFormatter {
  private static let definitions: [ColorFormat: ColorFormatDefinition] = [
    .CssHex: ColorFormatDefinition(
      description: "CSS Hex",
      formatter: toCssHex,
      pattern: "^#?([0-9a-fA-F]{2}){3}$"
    ),
    .CssHsl: ColorFormatDefinition(
      description: "CSS HSL",
      formatter: toCssHsl,
      pattern: "^hsl\\((\\d+),? (\\d+(?:\\.\\d+)?)%,? (\\d+(?:\\.\\d+)?)%\\)$"
    ),
    .CssHsla: ColorFormatDefinition(
      description: "CSS HSLA",
      formatter: toCssHsla,
      pattern: "^hsla\\((\\d+),? (\\d+(?:\\.\\d+)?)%,? (\\d+(?:\\.\\d+)?)%,? (\\d+(?:\\.\\d+)?)\\)$"
    ),
    .CssRgb: ColorFormatDefinition(
      description: "CSS RGB",
      formatter: toCssRgb,
      pattern: ""
    ),
    .CssRgba: ColorFormatDefinition(
      description: "CSS RGBA",
      formatter: toCssRgba,
      pattern: ""
    ),
    .SwiftAppKitHsb: ColorFormatDefinition(
      description: "Swift NSColor HSB",
      formatter: toSwiftAppKitHsb,
      pattern: ""
    ),
    .SwiftAppKitRgb: ColorFormatDefinition(
      description: "Swift NSColor RGB",
      formatter: toSwiftAppKitRgb,
      pattern: ""
    ),
    .SwiftUiKitHsb: ColorFormatDefinition(
      description: "Swift UIColor HSB",
      formatter: toSwiftUiKitHsb,
      pattern: ""
    ),
    .SwiftUiKitRgb: ColorFormatDefinition(
      description: "Swift UIColor RGB",
      formatter: toSwiftUiKitRgb,
      pattern: ""
    ),
    .SwiftUiHsb: ColorFormatDefinition(
      description: "SwiftUI HSB",
      formatter: toSwiftUiHsb,
      pattern: ""
    ),
    .SwiftUiRgb: ColorFormatDefinition(
      description: "SwiftUI RGB",
      formatter: toSwiftUiRgb,
      pattern: ""
    ),
    .CgColorRgb: ColorFormatDefinition(
      description: "CGColor RGB",
      formatter: toCgColorRgb,
      pattern: ""
    ),
    .CgColorCmyk: ColorFormatDefinition(
      description: "CGColor CMYK",
      formatter: toCgColorCmyk,
      pattern: ""
    ),
    .AndroidRgb: ColorFormatDefinition(
      description: "Android RGB",
      formatter: toAndroidRgb,
      pattern: ""
    ),
    .AndroidArgb: ColorFormatDefinition(
      description: "Android ARGB",
      formatter: toAndroidArgb,
      pattern: ""
    ),
    .AndroidXmlRgb: ColorFormatDefinition(
      description: "Android XML RGB",
      formatter: toAndroidXmlRgb,
      pattern: ""
    ),
    .AndroidXmlArgb: ColorFormatDefinition(
      description: "Android XML ARGB",
      formatter: toAndroidXmlArgb,
      pattern: ""
    ),
  ]

  private static func toAndroidArgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    String(
      format: "Color.argb(%d, %d, %d, %d)",
      get8BitsComponent(color, .Alpha),
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toAndroidRgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    String(
      format: "Color.rgb(%d, %d, %d)",
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toAndroidXmlArgb(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let hexString = getHexString(strFormat: "#%08x",
                                 value: getHexComponent(color, .Alpha) |
                                   getHexComponent(color, .Red) |
                                   getHexComponent(color, .Green) |
                                   getHexComponent(color, .Blue),
                                 useUpperCase: options.useUpperCaseHex)

    return "<color name=\"color_name\">\(hexString)</color>"
  }

  private static func toAndroidXmlRgb(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let hexString = getHexString(strFormat: "#%06x",
                                 value: getHexComponent(color, .Red) | getHexComponent(color, .Green) | getHexComponent(color, .Blue),
                                 useUpperCase: options.useUpperCaseHex)

    return "<color name=\"color_name\">\(hexString)</color>"
  }

  private static func toCssHex(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    getHexString(strFormat: "#%06x",
                 value: getHexComponent(color, .Red) | getHexComponent(color, .Green) | getHexComponent(color, .Blue),
                 useUpperCase: options.useUpperCaseHex)
  }

  private static func toCssHsl(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let hsla = getHSLA(color)
    let format = options.useSpaceSeparatedCss ? "hsl(%d %d%% %d%%)" : "hsl(%d, %d%%, %d%%)"

    return String(format: format, hsla.hue, hsla.saturation, hsla.lightness)
  }

  private static func toCssHsla(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let hsla = getHSLA(color)
    let format = options.useSpaceSeparatedCss ? "hsla(%d %d%% %d%% %@)" : "hsla(%d, %d%%, %d%%, %@)"

    return String(format: format, hsla.hue, hsla.saturation, hsla.lightness, getFractionalAlpha(color.alpha))
  }

  private static func toCssRgb(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let format = options.useSpaceSeparatedCss ? "rgb(%d %d %d)" : "rgb(%d, %d, %d)"

    return String(
      format: format,
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue)
    )
  }

  private static func toCssRgba(_ color: HSBColor, _ options: ColorFormatterOptions) -> String {
    let format = options.useSpaceSeparatedCss ? "rgba(%d %d %d %@)" : "rgba(%d, %d, %d, %@)"

    return String(
      format: format,
      get8BitsComponent(color, .Red),
      get8BitsComponent(color, .Green),
      get8BitsComponent(color, .Blue),
      getFractionalAlpha(color.alpha)
    )
  }

  private static func toSwiftAppKitHsb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("hue", color.hue), ("saturation", color.saturation), ("brightness", color.brightness), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.AppKit
    )
  }

  private static func toSwiftAppKitRgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.AppKit
    )
  }

  private static func toSwiftUiKitHsb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("hue", color.hue), ("saturation", color.saturation), ("brightness", color.brightness), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.UiKit
    )
  }

  private static func toSwiftUiKitRgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.UiKit
    )
  }

  private static func toSwiftUiHsb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("hue", color.hue), ("saturation", color.saturation), ("brightness", color.brightness), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.SwiftUi
    )
  }

  private static func toSwiftUiRgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.SwiftUi
    )
  }

  private static func toCgColorRgb(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    toSwiftColor(
      [("red", color.red), ("green", color.green), ("blue", color.blue), ("alpha", color.alpha)],
      prefix: SwiftColorPrefix.CoreGraphics
    )
  }

  private static func toCgColorCmyk(_ color: HSBColor, _: ColorFormatterOptions) -> String {
    let cmyk = getCMYK(color)

    return toSwiftColor(
      [
        ("genericCMYKCyan", cmyk.cyan),
        ("magenta", cmyk.magenta),
        ("yellow", cmyk.yellow),
        ("black", cmyk.black),
        ("alpha", cmyk.alpha),
      ],
      prefix: SwiftColorPrefix.CoreGraphics
    )
  }
}

private enum ColorComponent {
  case Red
  case Green
  case Blue
  case Alpha
}

private enum SwiftColorPrefix: String {
  case AppKit = "NSColor"
  case UiKit = "UIColor"
  case SwiftUi = "Color"
  case CoreGraphics = "CGColor"
}

class ColorFormatter {
  static func getDescription(format: ColorFormat) -> String {
    guard let description = definitions[format]?.description else { return "" }

    return description
  }

  static func format(_ color: HSBColor,
                     _ format: ColorFormat,
                     _ options: ColorFormatterOptions =
                       ColorFormatterOptions(
                         useUpperCaseHex: Constants.UseUpperCaseHexDefault,
                         useSpaceSeparatedCss: Constants.UseSpaceSeparatedCssDefault
                       )) -> String
  {
    guard let formatter = definitions[format]?.formatter else { return "" }

    return formatter(color, options)
  }

  static func match(_ input: String) -> HSBColor? {
    var color: HSBColor?

    for (format, definition) in definitions {
      // TODO: Remove
      if definition.pattern.count > 0 {
        let regex = try! NSRegularExpression(pattern: definition.pattern)

        if let match = regex.firstMatch(
          in: input,
          options: [],
          range: NSRange(location: 0, length: input.utf16.count)
        ) {
          // TODO: Remove
          print(format)

          switch format {
          case .CssHex:
            color = HSBColor(hex: input)
          case .CssHsl, .CssHsla:
            if let hueRange = Range(match.range(at: 1), in: input),
              let saturationRange = Range(match.range(at: 2), in: input),
              let lightnessRange = Range(match.range(at: 3), in: input)
            {
              let formatter = NumberFormatter()
              formatter.decimalSeparator = "."

              guard let hue = formatter.number(from: String(input[hueRange])) else { break }
              guard let saturation = formatter.number(from: String(input[saturationRange])) else { break }
              guard let lightness = formatter.number(from: String(input[lightnessRange])) else { break }

              var alpha: CGFloat = 1.0

              if format == .CssHsla, let alphaRange = Range(match.range(at: 4), in: input) {
                alpha = CGFloat(truncating: formatter.number(from: String(input[alphaRange])) ?? 1)
              }

              color = HSBColor(
                hue: CGFloat(truncating: hue) / 360,
                saturation: CGFloat(truncating: saturation) / 100,
                lightness: CGFloat(truncating: lightness) / 100,
                alpha: alpha
              )
            }
          default: break
          }

          break
        }
      }
    }

    return color
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

  private static func getCMYK(_ color: HSBColor) ->
    (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat, alpha: CGFloat)
  {
    let black = 1 - max(max(color.red, color.green), color.blue)

    if black == 1 {
      return (cyan: 0, magenta: 0, yellow: 0, black: 1, alpha: color.alpha)
    }

    let cyan = (1 - color.red - black) / (1 - black)
    let magenta = (1 - color.green - black) / (1 - black)
    let yellow = (1 - color.blue - black) / (1 - black)

    return (cyan: cyan, magenta: magenta, yellow: yellow, black: black, alpha: color.alpha)
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

  private static func getHexString(strFormat: String, value: UInt, useUpperCase: Bool) -> String {
    let hexString = String(format: strFormat, value)

    return useUpperCase ? hexString.uppercased() : hexString
  }

  private static func toSwiftColor(_ components: [(String, CGFloat)], prefix: SwiftColorPrefix) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    formatter.usesGroupingSeparator = false
    formatter.decimalSeparator = "."

    var result = "\(prefix.rawValue)("

    for (index, (key, value)) in components.enumerated() {
      result += "\(key): \(formatter.string(from: value as NSNumber) ?? "0")"

      if index < components.count - 1 {
        result += ", "
      }
    }

    return "\(result))"
  }

  private static func getFractionalAlpha(_ value: CGFloat) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    formatter.minimumFractionDigits = 0
    formatter.maximumFractionDigits = 2
    formatter.usesGroupingSeparator = false
    formatter.decimalSeparator = "."

    return formatter.string(from: value as NSNumber) ?? "0"
  }
}

private struct ColorFormatDefinition {
  let description: String
  let formatter: (_ color: HSBColor, _ options: ColorFormatterOptions) -> String
  let pattern: String
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
