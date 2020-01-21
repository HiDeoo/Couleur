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
    }
    .frame(width: Constants.ColorPreviewSize * 2, height: Constants.ColorPreviewSize * 2)
    .background(Color.green)
  }

  var SaturationBrightness: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(
          gradient: Gradient(colors: [Color(hue: Double(self.hue), saturation: 1, brightness: 1, opacity: 1), .white]),
          startPoint: .trailing,
          endPoint: .leading
        )
        LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top)
        Pointer(saturation: self.saturation, brightness: self.brightness, size: geometry.size)
      }
      .gesture(DragGesture().onChanged { event in
        self.updateSaturationBrightness(position: event.location, size: geometry.size)
      })
    }
  }

  func updateSaturationBrightness(position: CGPoint, size: CGSize) {
    color = NSColor(
      hue: hue,
      saturation: max(0.0, min(1.0, position.x / size.width)),
      brightness: 1.0 - max(0.0, min(1.0, position.y / size.height)),
      alpha: alpha
    )
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .constant(.blue))
  }
}
