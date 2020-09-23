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
  let action: (_ color: HSBColor) -> Void

  var body: some View {
    VStack {
      List(colors, id: \.self) { color in
        Button(action: {
          action(color)
        }) {
          HStack {
            Text(ColorFormatter.format(color, ColorFormat.CssHex))
              .font(.system(size: 15))
              .fontWeight(.medium)
              .foregroundColor(.white)
            Spacer()
            RoundedRectangle(cornerRadius: Constants.ControlCornerRadius)
              .fill(Color(color))
              .frame(width: Constants.HistoryColorSize.width, height: Constants.HistoryColorSize.height)
              .overlay(
                RoundedRectangle(cornerRadius: Constants.ControlCornerRadius)
                  .strokeBorder(Color.white.opacity(0.7), lineWidth: 1)
              )
          }
          .padding(2)
          .frame(width: Constants.HistoryEntrySize.width - 16)
        }
        .buttonStyle(BorderlessButtonStyle())
      }
    }
    .frame(width: Constants.HistoryEntrySize.width, height: Constants.HistoryEntrySize.height)
  }
}

struct History_Previews: PreviewProvider {
  static var previews: some View {
    History(colors: [], action: { _ in })
  }
}
