//
//  Pointer.swift
//  Couleur
//
//  Created by HiDeo on 20/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Pointer: View {
  let relativePosition: CGPoint
  let containerSize: CGSize

  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .stroke(lineWidth: 3)
      .frame(width: 10, height: 10)
      .foregroundColor(Color.green)
      .position(self.getPosition())
  }

  func getPosition() -> CGPoint {
    CGPoint(x: containerSize.width * relativePosition.x, y: containerSize.height * (1.0 - relativePosition.y))
  }
}

struct Pointer_Previews: PreviewProvider {
  static var previews: some View {
    Pointer(relativePosition: CGPoint(x: 0.5, y: 0.5), containerSize: CGSize(width: 150, height: 150))
  }
}
