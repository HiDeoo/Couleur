//
//  Preferences.swift
//  Couleur
//
//  Created by HiDeo on 15/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Preferences: View {
  @EnvironmentObject var appModel: AppModel

  var body: some View {
    VStack(spacing: 0) {
      Checkbox(checked: $appModel.useUpperCaseHex, label: "Use upper case letters for hexadecimal color formats")
    }
    .padding(Constants.WindowPadding)
    .background(Color("windowBackground"))
  }
}

struct Preferences_Previews: PreviewProvider {
  static var previews: some View {
    Preferences()
  }
}
