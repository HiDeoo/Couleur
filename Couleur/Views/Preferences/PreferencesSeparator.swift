//
//  PreferencesSeparator.swift
//  Couleur
//
//  Created by HiDeo on 25/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct PreferencesSeparator: View {
  var body: some View {
    Rectangle().frame(width: nil, height: 1, alignment: .top)
      .foregroundColor(Color("separator"))
      .padding(.vertical, 10)
  }
}

struct PreferencesSeparator_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesSeparator()
  }
}
