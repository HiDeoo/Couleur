//
//  ColorExporter.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorExporter: View {
  let color: HSBColor
  let format: ColorFormat
  @Binding var showColorFormatPicker: Bool

  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .padding(.bottom, 1)
        .background(Color("separator"))
      Button(action: {
        withAnimation {
          self.showColorFormatPicker.toggle()
        }
      }) {
        HStack {
          Text(ColorFormatter.format(color, format))
            .font(.system(.headline))
            .foregroundColor(Color("label"))
          Spacer()
          formatPickerIcon
            .rotationEffect(.degrees(self.showColorFormatPicker ? -180 : 0))
            .padding(.trailing, 2)
        }
        .padding(Constants.ViewPadding)
        .background(Color("windowBackground"))
      }
      .buttonStyle(PlainButtonStyle())
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
  }

  var formatPickerIcon: some View {
    let size = CGSize(width: 10, height: 10)

    return Path { path in
      path.move(to: CGPoint(x: size.width, y: 0))
      path.addLine(to: CGPoint(x: 0, y: size.height / 2))
      path.addLine(to: CGPoint(x: size.width, y: size.height))
    }
    .stroke(Color.white.opacity(0.9), style: StrokeStyle(lineWidth: 3.0, lineCap: .round, lineJoin: .round))
    .frame(width: size.width, height: size.height, alignment: .trailing)
  }
}

struct ColorExporter_Previews: PreviewProvider {
  static var previews: some View {
    ColorExporter(color: HSBColor(.blue), format: .CssHex, showColorFormatPicker: .constant(true))
  }
}
