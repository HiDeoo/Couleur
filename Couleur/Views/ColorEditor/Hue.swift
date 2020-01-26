//
//  Hue.swift
//  Couleur
//
//  Created by HiDeo on 26/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Hue: View {
  @Binding var color: CColor

  let rgbs: [(Double, Double, Double)] = [
    (255, 0, 0),
    (255, 128, 0),
    (255, 255, 0),
    (128, 255, 0),
    (0, 255, 0),
    (0, 255, 128),
    (0, 255, 255),
    (0, 128, 255),
    (0, 0, 255),
    (128, 0, 255),
    (255, 0, 255),
    (255, 0, 128),
    (255, 0, 0),
  ]

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(gradient: Gradient(colors: self.getGradientColors()), startPoint: .leading, endPoint: .trailing)
        Pointer()
          .position(self.getPointerPosition(containerSize: geometry.size))
      }
      .gesture(DragGesture(minimumDistance: 0).onChanged { event in
        self.updateHue(position: event.location, size: geometry.size)
      })
    }
  }

  func getGradientColors() -> [Color] {
    rgbs.map { (rgb) -> Color in
      let (r, g, b) = rgb

      return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
  }

  func getPointerPosition(containerSize: CGSize) -> CGPoint {
    CGPoint(x: containerSize.width * color.hue, y: containerSize.height / 2)
  }

  func updateHue(position: CGPoint, size: CGSize) {
    let relativeHue = max(0, min(1, position.x / size.width))

    // 0° is the same as 360° so to avoid the pointer jumping to the beginning of the gradient whean reaching the end,
    // we never really make it reach the end.
    color.setHue(relativeHue == 1 ? 1 - pow(10, -6) : relativeHue)
  }
}

struct Hue_Previews: PreviewProvider {
  static var previews: some View {
    Hue(color: .constant(CColor(.blue)))
  }
}
