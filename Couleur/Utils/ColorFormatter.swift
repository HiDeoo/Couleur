//
//  ColorFormatter.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

enum ColorFormat: Int, CaseIterable {
  case Hex
  case Hex1
}

class ColorFormatter {
  private static let definitions: [ColorFormat: ColorFormatDefinition] = [
    ColorFormat.Hex: ColorFormatDefinition(description: "Hexa", formatter: toHex),
    ColorFormat.Hex1: ColorFormatDefinition(description: "Hexa 1", formatter: toHex2),
  ]

  static func getDescription(format: ColorFormat) -> String {
    guard let description = definitions[format]?.description else { return "" }

    return description
  }

  static func format(_ color: HSBColor, _ format: ColorFormat) -> String {
    guard let formatter = definitions[format]?.formatter else { return "" }

    return formatter(color)
  }

  private static func toHex(_ color: HSBColor) -> String {
    let rgb = Int(color.red * 255) << 16 | Int(color.green * 255) << 8 | Int(color.blue * 255) << 0

    return String(format: "#%06x", rgb)
  }

  private static func toHex2(_: HSBColor) -> String {
    "plop this is a test"
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
