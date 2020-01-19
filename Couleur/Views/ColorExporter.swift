//
//  ColorExporter.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorExporter: View {
  let color: NSColor

  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .padding(.bottom, 1)
        .background(Color.black)
      Text("Color: \(color.toHexString())")
        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .foregroundColor(Color.black)
    }
  }
}

struct ColorExporter_Previews: PreviewProvider {
  static var previews: some View {
    ColorExporter(color: NSColor.blue)
  }
}
