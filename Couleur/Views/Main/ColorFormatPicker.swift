//
//  ColorFormatPicker.swift
//  Couleur
//
//  Created by HiDeo on 04/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Carbon.HIToolbox
import SwiftUI

struct ColorFormatPicker: View {
  let currentFormat: ColorFormatter.Format
  let hidePicker: (_ format: ColorFormatter.Format?) -> Void

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        ForEach(0 ..< ColorFormatter.Format.allCases.count, id: \.self) { index in
          ColorFormatPickerElement(
            index: index,
            format: ColorFormatter.Format.allCases[index],
            selected: ColorFormatter.Format.allCases[index] == self.currentFormat,
            hidePicker: self.hidePicker
          )
        }
      }
    }.onAppear {
      NSEvent.addLocalMonitorForEvents(
        matching: [.keyDown],
        handler: { event in
          if event.type == .keyDown, event.keyCode == kVK_Escape {
            self.hidePicker(nil)

            return nil
          }

          return event
        }
      )
    }
  }

  struct ColorFormatPickerElement: View {
    let index: Int
    let format: ColorFormatter.Format
    let selected: Bool
    let hidePicker: (_ format: ColorFormatter.Format) -> Void

    var body: some View {
      Button(action: {
        self.hidePicker(self.format)
      }) {
        VStack(spacing: 0) {
          HStack {
            Spacer()
            Text(format.rawValue)
              .font(.system(size: 14))
              .bold()
              .lineLimit(1)
            Text(selected ? "􀆅" : "")
              .frame(width: 20)
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
              .background(Color("windowAltBorder"))
          }
        }
        .frame(width: Constants.MainWindowSize.width - Constants.StackedViewOffset)
      }
      .buttonStyle(BorderlessButtonStyle())
      .foregroundColor(Color("label"))
    }
  }
}

struct ColorFormatPicker_Previews: PreviewProvider {
  static func hidePicker(_: ColorFormatter.Format?) {}

  static var previews: some View {
    ColorFormatPicker(currentFormat: ColorFormatter.Format.Hex, hidePicker: hidePicker)
  }
}
