//
//  LinearSlider.swift
//  Couleur
//
//  Created by HiDeo on 27/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct LinearSlider: View {
  let gradientColors: [Color]
  let getPointerPosition: (_ containerSize: CGSize) -> CGPoint
  let updateValue: (_ position: CGPoint, _ size: CGSize) -> Void

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        LinearGradient(gradient: Gradient(colors: self.gradientColors), startPoint: .leading, endPoint: .trailing)
        Pointer().position(self.getPointerPosition(geometry.size))
      }
      .cornerRadius(Constants.ControlCornerRadius)
      .overlay(RoundedRectangle(cornerRadius: Constants.ControlCornerRadius).stroke(Color("windowBorder")))
      .gesture(DragGesture(minimumDistance: 0).onChanged { event in
        self.updateValue(event.location, geometry.size)
      })
    }
  }
}

struct LinearSlider_Previews: PreviewProvider {
  static func getPointerPosition(_: CGSize) -> CGPoint {
    CGPoint(x: 0, y: 0)
  }

  static func updateValue(_: CGPoint, _: CGSize) {}

  static var previews: some View {
    LinearSlider(
      gradientColors: [.blue, .red],
      getPointerPosition: getPointerPosition,
      updateValue: updateValue
    )
  }
}
