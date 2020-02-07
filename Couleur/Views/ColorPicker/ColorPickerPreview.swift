//
//  ColorPickerPreview.swift
//  Couleur
//
//  Created by HiDeo on 07/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorPickerPreview: View {
  let color: HSBColor
  let format: ColorFormat

  init(color: HSBColor, format: ColorFormat) {
    self.color = color
    self.format = format

    textContrastColor = color.getTextContrastColor()
  }

  private let textContrastColor: NSColor

  var body: some View {
    Text(ColorFormatter.format(color, format))
      .font(.system(.caption))
      .foregroundColor(Color(textContrastColor))
      .padding(EdgeInsets(top: 6, leading: 8, bottom: 6, trailing: 8))
      .background(
        RoundedCorners(
          color: Color(color.raw),
          topLeft: Constants.ControlCornerRadius,
          topRight: Constants.ControlCornerRadius,
          bottomLeft: Constants.ControlCornerRadius,
          bottomRight: Constants.ControlCornerRadius
        )
      )
      .overlay(
        RoundedRectangle(cornerRadius: Constants.ControlCornerRadius)
          .strokeBorder(Color.black, lineWidth: 1)
      )
      .frame(height: Constants.PickerPreviewHeight)
  }
}

struct ColorPickerPreview_Previews: PreviewProvider {
  static var previews: some View {
    ColorPickerPreview(color: HSBColor(.blue), format: .Hex)
  }
}
