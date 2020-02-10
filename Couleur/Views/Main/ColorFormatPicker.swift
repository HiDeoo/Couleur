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
  let format: ColorFormat
  @Binding var visible: Bool
  let hide: (_ format: ColorFormat?) -> Void

  var body: some View {
    ScrollView(.vertical) {
      VStack(spacing: 0) {
        ForEach(0 ..< ColorFormat.allCases.count, id: \.self) { index in
          ColorFormatPickerElement(
            index: index,
            format: ColorFormat.allCases[index],
            selected: ColorFormat.allCases[index] == self.format,
            hidePicker: self.hide
          )
        }
      }
    }.onAppear {
      NSEvent.addLocalMonitorForEvents(
        matching: [.keyDown],
        handler: { event in
          if self.visible, event.type == .keyDown, event.keyCode == kVK_Escape {
            self.hide(nil)

            return nil
          }

          return event
        }
      )
    }
  }

  struct ColorFormatPickerElement: View {
    let index: Int
    let format: ColorFormat
    let selected: Bool
    let hidePicker: (_ format: ColorFormat) -> Void

    var body: some View {
      Button(action: {
        self.hidePicker(self.format)
      }) {
        VStack(spacing: 0) {
          HStack {
            Spacer()
            Text(ColorFormatter.getDescription(format: format))
              .font(.system(size: 14))
              .bold()
              .lineLimit(1)
            Text(selected ? "􀆅" : "")
              .frame(width: 20)
          }
          .padding([.leading, .top, .bottom], Constants.ViewPadding)
          .padding(.trailing, Constants.ViewPadding + 6)
          if index < ColorFormat.allCases.count - 1 {
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
  static func hide(_: ColorFormat?) {}

  static var previews: some View {
    ColorFormatPicker(format: .Hex, visible: .constant(false), hide: hide)
  }
}
