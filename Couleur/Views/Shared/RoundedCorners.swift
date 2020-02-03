//
//  RoundedCorners.swift
//  Couleur
//
//  Created by HiDeo on 30/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Cocoa
import SwiftUI

struct RoundedCorners: View {
  let color: Color
  let topLeft: CGFloat
  let topRight: CGFloat
  let bottomLeft: CGFloat
  let bottomRight: CGFloat

  var body: some View {
    GeometryReader { geometry in
      Path { path in
        let width = geometry.size.width
        let height = geometry.size.height

        let topLeft = min(min(self.topLeft, height / 2), width / 2)
        let topRight = min(min(self.topRight, height / 2), width / 2)
        let bottomLeft = min(min(self.bottomLeft, height / 2), width / 2)
        let bottomRight = min(min(self.bottomRight, height / 2), width / 2)

        path.move(to: CGPoint(x: width / 2.0, y: 0))
        path.addLine(to: CGPoint(x: width - topRight, y: 0))
        path.addArc(
          center: CGPoint(x: width - topRight, y: topRight),
          radius: topRight,
          startAngle: Angle(degrees: -90),
          endAngle: Angle(degrees: 0),
          clockwise: false
        )
        path.addLine(to: CGPoint(x: width, y: height - bottomRight))
        path.addArc(
          center: CGPoint(x: width - bottomRight, y: height - bottomRight),
          radius: bottomRight,
          startAngle: Angle(degrees: 0),
          endAngle: Angle(degrees: 90),
          clockwise: false
        )
        path.addLine(to: CGPoint(x: bottomLeft, y: height))
        path.addArc(
          center: CGPoint(x: bottomLeft, y: height - bottomLeft),
          radius: bottomLeft,
          startAngle: Angle(degrees: 90),
          endAngle: Angle(degrees: 180),
          clockwise: false
        )
        path.addLine(to: CGPoint(x: 0, y: topLeft))
        path.addArc(
          center: CGPoint(x: topLeft, y: topLeft),
          radius: topLeft,
          startAngle: Angle(degrees: 180),
          endAngle: Angle(degrees: 270),
          clockwise: false
        )
      }
      .fill(self.color)
    }
  }
}

struct RoundedCorners_Previews: PreviewProvider {
  static var previews: some View {
    RoundedCorners(color: .blue, topLeft: 10, topRight: 10, bottomLeft: 10, bottomRight: 10)
  }
}
