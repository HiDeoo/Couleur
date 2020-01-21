//
//  SaturationBrightnessGradient.swift
//  Couleur
//
//  Created by HiDeo on 21/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct SaturationBrightnessGradient: View {
  let hue: Double

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [Color(hue: self.hue, saturation: 1, brightness: 1, opacity: 1), .white]),
        startPoint: .trailing,
        endPoint: .leading
      )
      LinearGradient(gradient: Gradient(colors: [.black, .clear]), startPoint: .bottom, endPoint: .top)
    }
  }
}

struct SaturationBrightnessGradient_Previews: PreviewProvider {
  static var previews: some View {
    SaturationBrightnessGradient(hue: 0.5)
  }
}
