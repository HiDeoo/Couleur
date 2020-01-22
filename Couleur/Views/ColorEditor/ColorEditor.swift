//
//  ColorEditor.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorEditor: View {
  @Binding var color: NSColor

  init(color: Binding<NSColor>) {
    _color = color

    self.color.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha)
  }

  private var hue: CGFloat = 0
  private var saturation: CGFloat = 0
  private var brightness: CGFloat = 0
  private var alpha: CGFloat = 0

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
        SaturationBrightnessGradient(hue: Double(self.hue))
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
    CGPoint(x: containerSize.width * saturation, y: containerSize.height * (1 - brightness))
  }

  func getHuePointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width - (containerSize.width * hue), y: containerSize.height / 2)
  }

  func updateSaturationBrightness(position: CGPoint, size: CGSize) {
    color = NSColor(
      hue: hue,
      saturation: max(0, min(1, position.x / size.width)),
      brightness: 1 - max(0, min(1, position.y / size.height)),
      alpha: alpha
    )
  }

  func updateHue(position: CGPoint, size: CGSize) {
    color = NSColor(
      hue: max(0, min(1, 1 - position.x / size.width)),
      saturation: saturation,
      brightness: brightness,
      alpha: alpha
    )
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .constant(.blue))
  }
}
