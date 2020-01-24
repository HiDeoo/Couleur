//
//  HueGradient.swift
//  Couleur
//
//  Created by HiDeo on 21/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct HueGradient: View {
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
    LinearGradient(gradient: Gradient(colors: getGradientColors()), startPoint: .leading, endPoint: .trailing)
  }

  func getGradientColors() -> [Color] {
    rgbs.map { (rgb) -> Color in
      let (r, g, b) = rgb

      return Color(red: r / 255, green: g / 255, blue: b / 255)
    }
  }
}

struct HueGradient_Previews: PreviewProvider {
  static var previews: some View {
    HueGradient()
  }
}
