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

  var body: some View {
    VStack {
      SaturationBrightness
        .frame(width: Constants.ColorPreviewSize * 2, height: Constants.ColorPreviewSize * 2)
      Hue
        .frame(width: Constants.ColorPreviewSize * 2, height: 40)
    }
  }

  var SaturationBrightness: some View {
    GeometryReader { geometry in
      ZStack {
        SaturationBrightnessGradient(hue: Double(self.color.hue))
        Pointer()
          .position(self.getSaturationBrightnessPointerPosition(containerSize: geometry.size))
      }
      .gesture(DragGesture().onChanged { event in
        self.updateSaturationBrightness(position: event.location, size: geometry.size)
      })
    }
  }

  var Hue: some View {
    GeometryReader { geometry in
      ZStack {
        HueGradient()
        Pointer()
          .position(self.getHuePointerPosition(containerSize: geometry.size))
      }
      .gesture(DragGesture().onChanged { event in
        self.updateHue(position: event.location, size: geometry.size)
      })
    }
  }

  func getSaturationBrightnessPointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width * color.saturation, y: containerSize.height * (1 - color.brightness))
  }

  func getHuePointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width - (containerSize.width * color.hue), y: containerSize.height / 2)
  }

  func updateSaturationBrightness(position: CGPoint, size: CGSize) {
    color.setSaturationAndBrightness(
      max(0, min(1, position.x / size.width)),
      1 - max(0, min(1, position.y / size.height))
    )
  }

  func updateHue(position: CGPoint, size: CGSize) {
    let relativeHue = min(1, max(0, position.x / size.width))

    // 0° is the same as 360° so to avoid the pointer jumping to the beginning of the gradient whean reaching the end,
    // we never really make it reach the end.
    color.setHue(relativeHue == 1 ? pow(10, -6) : 1 - relativeHue)
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .constant(CColor(.blue)))
  }
}
