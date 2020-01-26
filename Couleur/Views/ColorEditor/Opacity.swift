//
//  Opacity.swift
//  Couleur
//
//  Created by HiDeo on 26/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Opacity: View {
  @Binding var color: CColor

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(gradient: Gradient(colors: self.getGradientColors()), startPoint: .leading, endPoint: .trailing)
        Pointer()
          .position(self.getPointerPosition(containerSize: geometry.size))
      }
      .gesture(DragGesture(minimumDistance: 0).onChanged { event in
        self.updateAlpha(position: event.location, size: geometry.size)
      })
    }
  }

  func getGradientColors() -> [Color] {
    let hue = Double(color.hue)
    let saturation = Double(color.saturation)
    let brightness = Double(color.brightness)

    return [
      Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 0),
      Color(hue: hue, saturation: saturation, brightness: brightness, opacity: 1),
    ]
  }

  func getPointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width * color.alpha, y: containerSize.height / 2)
  }

  func updateAlpha(position: CGPoint, size: CGSize) {
    color.setAlpha(max(0, min(1, position.x / size.width)))
  }
}

struct Opacity_Previews: PreviewProvider {
  static var previews: some View {
    Opacity(color: .constant(CColor(.blue)))
  }
}
