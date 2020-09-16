//
//  Checkbox.swift
//  Couleur
//
//  Created by HiDeo on 16/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Checkbox: View {
  @Binding var checked: Bool
  let label: String

  @ViewBuilder
  var body: some View {
    Button(action: {
      self.checked.toggle()
    }) {
      HStack(alignment: .top) {
        ZStack {
          if checked {
            Rectangle()
              .fill(Color.white)
              .frame(width: Constants.PreferencesCheckboxSize / 2, height: Constants.PreferencesCheckboxSize / 2)
          }
          Text(checked ? "􀃳" : "􀂒")
            .font(.system(size: Constants.PreferencesCheckboxSize))
            .foregroundColor(checked ? .accentColor : .white)
        }
        Text(label)
          .font(.system(size: Constants.PreferencesFontSize))
          .padding(.top, 1)
      }
    }
    .buttonStyle(PlainButtonStyle())
    .padding(.bottom, 3)
  }
}

struct Checkbox_Previews: PreviewProvider {
  static var previews: some View {
    Checkbox(checked: .constant(true), label: "test")
  }
}
