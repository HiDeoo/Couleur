//
//  ColorFormatter.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation

class ColorFormatter {
  enum Format: String, CaseIterable, Codable {
    case Hex = "Hexa"
    case Hex1 = "Hexa1Hexa1Hexa1Hexa1Hexa1Hexa1Hexa1Hexa1Hexa1Hexa1"
    case Hex2 = "Hexa2"
    case Hex3 = "Hexa3"
    case Hex4 = "Hexa4"
    case Hex5 = "Hexa5"
    case Hex6 = "Hexa6"
    case Hex7 = "Hexa7"
    case Hex8 = "Hexa8"
    case Hex9 = "Hexa9"
    case Hex10 = "Hexa10"
    case Hex11 = "Hexa11"
    case Hex12 = "Hexa12"
    case Hex13 = "Hexa13"
    case Hex14 = "Hexa14"
    case Hex15 = "Hexa15"
    case Hex16 = "Hexa16"
    case Hex17 = "Hexa17"
    case Hex18 = "Hexa18"
    case Hex19 = "Hexa19"

    enum Key: CodingKey {
      case rawValue
    }

    init(from decoder: Decoder) throws {
      let container = try decoder.container(keyedBy: Key.self)
      let rawValue = try container.decode(String.self, forKey: .rawValue)
      self = Format(rawValue: rawValue) ?? Constants.ColorDefaultFormat
    }

    func encode(to encoder: Encoder) throws {
      var container = encoder.container(keyedBy: Key.self)
      try container.encode(rawValue, forKey: .rawValue)
    }

    func getFormatter() -> (_ color: HSBColor) -> String {
      switch self {
      case .Hex: return ColorFormatter.toHex
      default: return ColorFormatter.toHex2
      }
    }
  }

  static func format(_ color: HSBColor, _ format: Format) -> String {
    let formatter = Format.getFormatter(format)()

    return formatter(color)
  }

  private static func toHex(_ color: HSBColor) -> String {
    let rgb = Int(color.red * 255) << 16 | Int(color.green * 255) << 8 | Int(color.blue * 255) << 0

    return String(format: "#%06x", rgb)
  }

  private static func toHex2(_ color: HSBColor) -> String {
    let rgb = Int(color.red * 255) << 16 | Int(color.green * 255) << 8 | Int(color.blue * 255) << 0

    return String(format: "Hello, %06x", rgb)
  }
}
