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

  @State private var showColorFormatPicker = false

  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .padding(.bottom, 1)
        .background(Color("separator"))
      HStack {
        Text(ColorFormatter.format(color, .Hex))
          .font(.system(.headline))
          .foregroundColor(Color("label"))
        Spacer()
        Button(action: {
          self.showColorFormatPicker = true
        }) {
          Text("<")
        }.popover(isPresented: $showColorFormatPicker, arrowEdge: .leading) {
          ColorFormatPicker()
        }
      }
      .padding(EdgeInsets(top: 10, leading: 10, bottom: 0, trailing: 10))
      .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
    }
  }
}

struct ColorExporter_Previews: PreviewProvider {
  static var previews: some View {
    ColorExporter(color: HSBColor(.blue))
  }
}
