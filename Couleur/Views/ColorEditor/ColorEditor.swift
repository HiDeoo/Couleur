//
//  ColorEditor.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorEditor: View {
  @Binding var color: CColor
  @Binding var componentsEditorType: ComponentsType

  private let editorWidth = Constants.MainWindowWidth - Constants.ColorEditorPadding * 2

  var body: some View {
    VStack {
      SaturationBrightness(color: $color)
        .frame(width: editorWidth, height: editorWidth)
      LinearSlider(
        gradientColors: self.getHueGradientColors(),
        getPointerPosition: self.getHuePointerPosition,
        updateValue: self.updateHue
      )
      .frame(width: editorWidth, height: Constants.ColorEditorLinearSliderHeight)
      LinearSlider(
        gradientColors: self.getAlphaGradientColors(),
        getPointerPosition: self.getAlphaPointerPosition,
        updateValue: self.updateAlpha
      )
      .frame(width: editorWidth, height: Constants.ColorEditorLinearSliderHeight)
      Components(color: $color, type: $componentsEditorType)
    }.padding(Constants.ColorEditorPadding)
  }

  func getHueGradientColors() -> [Color] {
    Constants.HueGradientRgbs.map { (rgb) -> Color in
      let (r, g, b) = rgb

      return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
  }

  func getHuePointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width * color.hue, y: containerSize.height / 2)
  }

  func updateHue(position: CGPoint, size: CGSize) {
    let relativeHue = max(0, min(1, position.x / size.width))

    // 0° is the same as 360° so to avoid the pointer jumping to the beginning of the gradient whean reaching the end,
    // we never really make it reach the end.
    color.setHue(relativeHue == 1 ? 1 - pow(10, -6) : relativeHue)
  }

  func getAlphaGradientColors() -> [Color] {
    let hue = Double(color.hue)
    let saturation = Double(color.saturation)
    let brightness = Double(color.brightness)

    return [
      Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 0),
      Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 1),
    ]
  }

  func getAlphaPointerPosition(_ containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width * color.alpha, y: containerSize.height / 2)
  }

  func updateAlpha(_ position: CGPoint, _ size: CGSize) {
    color.setAlpha(max(0, min(1, position.x / size.width)))
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .constant(CColor(.blue)), componentsEditorType: .constant(.RGBA))
  }
}
