//
//  ColorFormatter.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation

class ColorFormatter {
  enum Format: String {
    case Hex = "Hexa"

    func getFormatter() -> (_ color: HSBColor) -> String {
      switch self {
      case .Hex: return ColorFormatter.toHex
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
}
