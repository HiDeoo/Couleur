//
//  ColorFormatter.swift
//  CouleurTests
//
//  Created by HiDeo on 15/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import XCTest

@testable import Couleur

class ColorFormatterTests: XCTestCase {
  enum Color {
    case Black
    case White
    case Red
    case Green
    case Blue
    case Median
    case MedianAlpha
  }

  let HSBColors: [Color: HSBColor] = [
    .Black: HSBColor(red: 0, green: 0, blue: 0, alpha: 1),
    .White: HSBColor(red: 1, green: 1, blue: 1, alpha: 1),
    .Red: HSBColor(red: 1, green: 0, blue: 0, alpha: 1),
    .Green: HSBColor(red: 0, green: 1, blue: 0, alpha: 1),
    .Blue: HSBColor(red: 0, green: 0, blue: 1, alpha: 1),
    .Median: HSBColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1),
    .MedianAlpha: HSBColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5),
  ]

  private var testFormattedColorCount = 0

  private func getFormattedColor(_ color: Color, _ format: ColorFormat) -> String {
    testFormattedColorCount += 1

    return ColorFormatter.format(HSBColors[color]!, format)
  }

  private func testColors(_ format: ColorFormat, _ results: [Color: String]) {
    for color in HSBColors {
      XCTAssertEqual(getFormattedColor(color.key, format), results[color.key])
    }
  }

  override func setUp() {
    testFormattedColorCount = 0
  }

  override func tearDown() {
    XCTAssertEqual(testFormattedColorCount, HSBColors.count)
  }

  func testAndroidArgb() {
    testColors(.AndroidArgb, [
      .Black: "Color.argb(255, 0, 0, 0)",
      .White: "Color.argb(255, 255, 255, 255)",
      .Red: "Color.argb(255, 255, 0, 0)",
      .Green: "Color.argb(255, 0, 255, 0)",
      .Blue: "Color.argb(255, 0, 0, 255)",
      .Median: "Color.argb(255, 127, 127, 127)",
      .MedianAlpha: "Color.argb(127, 127, 127, 127)",
    ])
  }

  func testAndroidRgb() {
    testColors(.AndroidRgb, [
      .Black: "Color.rgb(0, 0, 0)",
      .White: "Color.rgb(255, 255, 255)",
      .Red: "Color.rgb(255, 0, 0)",
      .Green: "Color.rgb(0, 255, 0)",
      .Blue: "Color.rgb(0, 0, 255)",
      .Median: "Color.rgb(127, 127, 127)",
      .MedianAlpha: "Color.rgb(127, 127, 127)",
    ])
  }

  func testAndroidXmlArgb() {
    testColors(.AndroidXmlArgb, [
      .Black: "<color name=\"color_name\">#ff000000</color>",
      .White: "<color name=\"color_name\">#ffffffff</color>",
      .Red: "<color name=\"color_name\">#ffff0000</color>",
      .Green: "<color name=\"color_name\">#ff00ff00</color>",
      .Blue: "<color name=\"color_name\">#ff0000ff</color>",
      .Median: "<color name=\"color_name\">#ff7f7f7f</color>",
      .MedianAlpha: "<color name=\"color_name\">#7f7f7f7f</color>",
    ])
  }

  func testAndroidXmlRgb() {
    testColors(.AndroidXmlRgb, [
      .Black: "<color name=\"color_name\">#000000</color>",
      .White: "<color name=\"color_name\">#ffffff</color>",
      .Red: "<color name=\"color_name\">#ff0000</color>",
      .Green: "<color name=\"color_name\">#00ff00</color>",
      .Blue: "<color name=\"color_name\">#0000ff</color>",
      .Median: "<color name=\"color_name\">#7f7f7f</color>",
      .MedianAlpha: "<color name=\"color_name\">#7f7f7f</color>",
    ])
  }

  func testCssHex() {
    testColors(.CssHex, [
      .Black: "#000000",
      .White: "#ffffff",
      .Red: "#ff0000",
      .Green: "#00ff00",
      .Blue: "#0000ff",
      .Median: "#7f7f7f",
      .MedianAlpha: "#7f7f7f",
    ])
  }

  func testCssHsl() {
    testColors(.CssHsl, [
      .Black: "hsl(0, 0%, 0%)",
      .White: "hsl(0, 0%, 100%)",
      .Red: "hsl(0, 100%, 50%)",
      .Green: "hsl(120, 100%, 50%)",
      .Blue: "hsl(240, 100%, 50%)",
      .Median: "hsl(0, 0%, 50%)",
      .MedianAlpha: "hsl(0, 0%, 50%)",
    ])
  }

  func testCssHsla() {
    testColors(.CssHsla, [
      .Black: "hsla(0, 0%, 0%, 100%)",
      .White: "hsla(0, 0%, 100%, 100%)",
      .Red: "hsla(0, 100%, 50%, 100%)",
      .Green: "hsla(120, 100%, 50%, 100%)",
      .Blue: "hsla(240, 100%, 50%, 100%)",
      .Median: "hsla(0, 0%, 50%, 100%)",
      .MedianAlpha: "hsla(0, 0%, 50%, 50%)",
    ])
  }

  func testCssRgb() {
    testColors(.CssRgb, [
      .Black: "rgb(0, 0, 0)",
      .White: "rgb(255, 255, 255)",
      .Red: "rgb(255, 0, 0)",
      .Green: "rgb(0, 255, 0)",
      .Blue: "rgb(0, 0, 255)",
      .Median: "rgb(127, 127, 127)",
      .MedianAlpha: "rgb(127, 127, 127)",
    ])
  }

  func testCssRgba() {
    testColors(.CssRgba, [
      .Black: "rgba(0, 0, 0, 100%)",
      .White: "rgba(255, 255, 255, 100%)",
      .Red: "rgba(255, 0, 0, 100%)",
      .Green: "rgba(0, 255, 0, 100%)",
      .Blue: "rgba(0, 0, 255, 100%)",
      .Median: "rgba(127, 127, 127, 100%)",
      .MedianAlpha: "rgba(127, 127, 127, 50%)",
    ])
  }

  func testSwiftAppKitHsb() {
    testColors(.SwiftAppKitHsb, [
      .Black: "NSColor(hue: 0, saturation: 0, brightness: 0, alpha: 1)",
      .White: "NSColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)",
      .Red: "NSColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)",
      .Green: "NSColor(hue: 0.33, saturation: 1, brightness: 1, alpha: 1)",
      .Blue: "NSColor(hue: 0.67, saturation: 1, brightness: 1, alpha: 1)",
      .Median: "NSColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1)",
      .MedianAlpha: "NSColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 0.5)",
    ])
  }

  func testSwiftAppKitRgb() {
    testColors(.SwiftAppKitRgb, [
      .Black: "NSColor(red: 0, green: 0, blue: 0, alpha: 1)",
      .White: "NSColor(red: 1, green: 1, blue: 1, alpha: 1)",
      .Red: "NSColor(red: 1, green: 0, blue: 0, alpha: 1)",
      .Green: "NSColor(red: 0, green: 1, blue: 0, alpha: 1)",
      .Blue: "NSColor(red: 0, green: 0, blue: 1, alpha: 1)",
      .Median: "NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)",
      .MedianAlpha: "NSColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)",
    ])
  }

  func testSwiftUiKitHsb() {
    testColors(.SwiftUiKitHsb, [
      .Black: "UIColor(hue: 0, saturation: 0, brightness: 0, alpha: 1)",
      .White: "UIColor(hue: 0, saturation: 0, brightness: 1, alpha: 1)",
      .Red: "UIColor(hue: 1, saturation: 1, brightness: 1, alpha: 1)",
      .Green: "UIColor(hue: 0.33, saturation: 1, brightness: 1, alpha: 1)",
      .Blue: "UIColor(hue: 0.67, saturation: 1, brightness: 1, alpha: 1)",
      .Median: "UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 1)",
      .MedianAlpha: "UIColor(hue: 0, saturation: 0, brightness: 0.5, alpha: 0.5)",
    ])
  }

  func testSwiftUiKitRgb() {
    testColors(.SwiftUiKitRgb, [
      .Black: "UIColor(red: 0, green: 0, blue: 0, alpha: 1)",
      .White: "UIColor(red: 1, green: 1, blue: 1, alpha: 1)",
      .Red: "UIColor(red: 1, green: 0, blue: 0, alpha: 1)",
      .Green: "UIColor(red: 0, green: 1, blue: 0, alpha: 1)",
      .Blue: "UIColor(red: 0, green: 0, blue: 1, alpha: 1)",
      .Median: "UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)",
      .MedianAlpha: "UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)",
    ])
  }

  func testSwiftUiHsb() {
    testColors(.SwiftUiHsb, [
      .Black: "Color(hue: 0, saturation: 0, brightness: 0, alpha: 1)",
      .White: "Color(hue: 0, saturation: 0, brightness: 1, alpha: 1)",
      .Red: "Color(hue: 1, saturation: 1, brightness: 1, alpha: 1)",
      .Green: "Color(hue: 0.33, saturation: 1, brightness: 1, alpha: 1)",
      .Blue: "Color(hue: 0.67, saturation: 1, brightness: 1, alpha: 1)",
      .Median: "Color(hue: 0, saturation: 0, brightness: 0.5, alpha: 1)",
      .MedianAlpha: "Color(hue: 0, saturation: 0, brightness: 0.5, alpha: 0.5)",
    ])
  }

  func testSwiftUiRgb() {
    testColors(.SwiftUiRgb, [
      .Black: "Color(red: 0, green: 0, blue: 0, alpha: 1)",
      .White: "Color(red: 1, green: 1, blue: 1, alpha: 1)",
      .Red: "Color(red: 1, green: 0, blue: 0, alpha: 1)",
      .Green: "Color(red: 0, green: 1, blue: 0, alpha: 1)",
      .Blue: "Color(red: 0, green: 0, blue: 1, alpha: 1)",
      .Median: "Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)",
      .MedianAlpha: "Color(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)",
    ])
  }

  func testCgColorRgb() {
    testColors(.CgColorRgb, [
      .Black: "CGColor(red: 0, green: 0, blue: 0, alpha: 1)",
      .White: "CGColor(red: 1, green: 1, blue: 1, alpha: 1)",
      .Red: "CGColor(red: 1, green: 0, blue: 0, alpha: 1)",
      .Green: "CGColor(red: 0, green: 1, blue: 0, alpha: 1)",
      .Blue: "CGColor(red: 0, green: 0, blue: 1, alpha: 1)",
      .Median: "CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 1)",
      .MedianAlpha: "CGColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)",
    ])
  }

  func testCgColorCmyk() {
    testColors(.CgColorCmyk, [
      .Black: "CGColor(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 1, alpha: 1)",
      .White: "CGColor(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0, alpha: 1)",
      .Red: "CGColor(genericCMYKCyan: 0, magenta: 1, yellow: 1, black: 0, alpha: 1)",
      .Green: "CGColor(genericCMYKCyan: 1, magenta: 0, yellow: 1, black: 0, alpha: 1)",
      .Blue: "CGColor(genericCMYKCyan: 1, magenta: 1, yellow: 0, black: 0, alpha: 1)",
      .Median: "CGColor(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0.5, alpha: 1)",
      .MedianAlpha: "CGColor(genericCMYKCyan: 0, magenta: 0, yellow: 0, black: 0.5, alpha: 0.5)",
    ])
  }
}
