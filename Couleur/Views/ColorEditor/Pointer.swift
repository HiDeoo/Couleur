//
//  Pointer.swift
//  Couleur
//
//  Created by HiDeo on 20/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Pointer: View {
  let saturation: CGFloat
  let brightness: CGFloat
  let size: CGSize

  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .stroke(lineWidth: 3)
      .frame(width: 10, height: 10)
      .foregroundColor(Color.green)
      .position(self.getPosition())
  }

  func getPosition() -> CGPoint {
    CGPoint(x: size.width * saturation, y: size.height * (1.0 - brightness))
  }
}

struct Pointer_Previews: PreviewProvider {
  static var previews: some View {
    Pointer(saturation: 0.5, brightness: 0.5, size: CGSize(width: 150, height: 150))
  }
}
