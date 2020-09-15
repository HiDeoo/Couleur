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
    VStack {
      Text(String(appModel.format.rawValue))
        .padding(20)
      Button(action: {
        self.appModel.format = ColorFormat.AndroidXmlArgb
      }) {
        Text("Test")
          .debugView()
      }
    }
  }
}

struct Preferences_Previews: PreviewProvider {
  static var previews: some View {
    Preferences()
  }
}
