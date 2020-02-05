//
//  ColorFormatPicker.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct ColorFormatPicker: View {
  let closePicker: (_ format: ColorFormatter.Format) -> Void

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        ForEach(0 ..< ColorFormatter.Format.allCases.count, id: \.self) { index in
          ColorFormatPickerElement(
            index: index,
            format: ColorFormatter.Format.allCases[index],
            closePicker: self.closePicker
          )
        }
      }
    }
    // Bug: SwiftUI doesn't support yet coloring the popover arrow.
    .background(Color("windowBackground"))
    .frame(height: 300)
  }

  struct ColorFormatPickerElement: View {
    let index: Int
    let format: ColorFormatter.Format
    let closePicker: (_ format: ColorFormatter.Format) -> Void

    var body: some View {
      Button(action: {
        self.closePicker(self.format)
      }) {
        VStack(spacing: 0) {
          HStack {
            Text("􀆅")
              .frame(width: 20)
            Text(format.rawValue)
              .font(.system(size: 14))
              .bold()
            Spacer()
          }
          .padding(EdgeInsets(
            top: Constants.ViewPadding,
            leading: Constants.ViewPadding,
            bottom: Constants.ViewPadding,
            trailing: Constants.ViewPadding + 6
          ))
          if index < ColorFormatter.Format.allCases.count - 1 {
            Rectangle()
              .padding(.top, 1)
              .frame(height: 1)
              .background(Color("windowBorder"))
          }
        }
        .frame(width: Constants.MainWindowWidth)
      }
      .buttonStyle(BorderlessButtonStyle())
      .foregroundColor(Color("label"))
    }
  }
}

struct ColorFormatPicker_Previews: PreviewProvider {
  static func closePicker(_: ColorFormatter.Format) {}

  static var previews: some View {
    ColorFormatPicker(closePicker: closePicker)
  }
}
