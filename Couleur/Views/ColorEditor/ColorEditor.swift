//
//  ColorEditor.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorEditor: View {
  @Binding var color: CColor

  var body: some View {
    VStack {
      SaturationBrightness(color: $color)
        .frame(width: Constants.ColorPreviewSize * 2, height: Constants.ColorPreviewSize * 2)
      Hue(color: $color)
        .frame(width: Constants.ColorPreviewSize * 2, height: 40)
    }
  }
}

struct ColorEditor_Previews: PreviewProvider {
  static var previews: some View {
    ColorEditor(color: .constant(CColor(.blue)))
  }
}
