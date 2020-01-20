//
//  ColorEditor.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorEditor: View {
  let color: NSColor

  init(color: NSColor) {
    self.color = color

    var h: CGFloat = 0
    var s: CGFloat = 0
    var b: CGFloat = 0
    var a: CGFloat = 0

    color.getHue(&h, saturation: &s, brightness: &b, alpha: &a)

    hue = h
    saturation = s
    brightness = b
    alpha = a
  }

  private let hue: CGFloat
  private let saturation: CGFloat
  private let brightness: CGFloat
  private let alpha: CGFloat

  var body: some View {
    VStack {
      SaturationBrightness
    }
    .frame(width: Constants.ColorPreviewSize * 2, height: Constants.ColorPreviewSize * 2)
    .background(Color.green)
  }

  var SaturationBrightness: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(gradient: Gradient(colors: [Color(self.color), .white]), startPoint: .trailing, endPoint: .leading)
        LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top)
        Pointer(saturation: self.saturation, brightness: self.brightness, size: geometry.size.width)
      }
    }
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .blue)
  }
}
