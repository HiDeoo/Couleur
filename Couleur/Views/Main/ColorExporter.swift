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
  let format: ColorFormatter.Format
  @Binding var showColorFormatPicker: Bool

  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .padding(.bottom, 1)
        .background(Color("separator"))
      HStack {
        Text(ColorFormatter.format(color, format))
          .font(.system(.headline))
          .foregroundColor(Color("label"))
        Spacer()
        Button(action: {
          withAnimation {
            self.showColorFormatPicker.toggle()
          }
        }) {
          Text("<")
        }
      }
      .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct ColorExporter_Previews: PreviewProvider {
  static var previews: some View {
    ColorExporter(color: HSBColor(.blue), format: ColorFormatter.Format.Hex, showColorFormatPicker: .constant(true))
  }
}
