//
//  PreferencesButton.swift
//  Couleur
//
//  Created by HiDeo on 25/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct PreferencesButton: View {
  let label: String
  let action: Action

  var body: some View {
    Button(action: action) {
      Text(label)
        .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14))
        .foregroundColor(.white)
        .background(Color("windowAltBackground"))
        .cornerRadius(Constants.ControlCornerRadius)
    }
    .buttonStyle(PlainButtonStyle())
  }
}

struct PreferencesButton_Previews: PreviewProvider {
  static var previews: some View {
    PreferencesButton(label: "test", action: {})
  }
}
