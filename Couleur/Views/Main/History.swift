//
//  History.swift
//  Couleur
//
//  Created by HiDeo on 22/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct History: View {
  let colors: [HSBColor]

  var body: some View {
    List(colors, id: \.self) { color in
      Button(action: {
        print("hello")
      }) {
        Text(ColorFormatter.format(color, ColorFormat.CssHex))
      }
    }
  }
}

struct History_Previews: PreviewProvider {
  static var previews: some View {
    History(colors: [])
  }
}
