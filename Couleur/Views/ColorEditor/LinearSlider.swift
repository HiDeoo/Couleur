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
  let useTransparency: Bool

  init(
    gradientColors: [Color],
    getPointerPosition: @escaping (_ containerSize: CGSize) -> CGPoint,
    updateValue: @escaping (_ position: CGPoint, _ size: CGSize) -> Void,
    useTransparency: Bool = false
  ) {
    self.gradientColors = gradientColors
    self.getPointerPosition = getPointerPosition
    self.updateValue = updateValue
    self.useTransparency = useTransparency
  }

  var body: some View {
    GeometryReader { geometry in
      ZStack {
        Group {
          if self.useTransparency {
            TransparencyLayer()
          }
          LinearGradient(gradient: Gradient(colors: self.gradientColors), startPoint: .leading, endPoint: .trailing)
        }
        .cornerRadius(Constants.ControlCornerRadius)
        .overlay(RoundedRectangle(cornerRadius: Constants.ControlCornerRadius).stroke(Color("windowBorder")))
        Pointer().position(self.getPointerPosition(geometry.size))
      }
      .gesture(DragGesture(minimumDistance: 0).onChanged { event in
        Cursor.hide()
        self.updateValue(event.location, geometry.size)
      }.onEnded { _ in
        Cursor.show()
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
