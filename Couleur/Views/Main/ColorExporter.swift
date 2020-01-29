//
//  ColorExporter.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorExporter: View {
  let color: CColor

  var body: some View {
    VStack(spacing: 0) {
      Rectangle()
        .padding(.bottom, 1)
        .background(Color("separator"))
      Text(color.toHexString())
        .font(.system(.headline))
        .padding(EdgeInsets(top: 10, leading: 10, bottom: 2, trailing: 10))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .foregroundColor(Color("label"))
    }
  }
}

struct ColorExporter_Previews: PreviewProvider {
  static var previews: some View {
    ColorExporter(color: CColor(.blue))
  }
}
