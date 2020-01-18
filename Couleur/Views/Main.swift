//
//  Main.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Main: View {
  @EnvironmentObject var appModel: AppModel

  @State var showPermissionAlert = false

  var body: some View {
    VStack(spacing: 0) {
      Button(action: pickColor) {
        Spacer()
          .frame(width: Constants.ColorPreviewSize, height: Constants.ColorPreviewSize)
          .background(Color(appModel.selectedColor))
      }
      .buttonStyle(BorderlessButtonStyle())
      Rectangle()
        .padding(.bottom, 1)
        .background(Color.black)
      Text("Color: \(appModel.selectedColor.description)")
        .padding(EdgeInsets(top: 8, leading: 10, bottom: 8, trailing: 10))
        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
        .background(Color.white)
        .foregroundColor(Color.black)
    }.frame(alignment: .topLeading)
      .alert(isPresented: $showPermissionAlert) {
        Alert(title: Text("Screen Recording permission is required"), message: Text("Couleur uses Screen Recording to pick a color.\n\nOpen the Security & Privacy panel in System Preferences and put a checkmark next to Couleur in the Screen Recording section."), dismissButton: .default(Text("OK"), action: {
          self.showPicker()
      }))
      }
  }

  func pickColor() {
    if !Permissions.canRecordScreen() {
      showPermissionAlert = true
    } else {
      showPicker()
    }
  }

  func showPicker() {
    let pickerWindow = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: Constants.PickerSize, height: Constants.PickerSize),
      styleMask: [],
      backing: .buffered, defer: false
    )

    pickerWindow.center()
    pickerWindow.isOpaque = false
    pickerWindow.backgroundColor = NSColor.clear
    pickerWindow.contentView = NSHostingView(rootView: Picker(window: pickerWindow).environmentObject(appModel))

    pickerWindow.makeKeyAndOrderFront(nil)
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Main()
  }
}
