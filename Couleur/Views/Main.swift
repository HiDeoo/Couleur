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
    VStack {
      Button(action: pickColor) {
        Text("Go")
      }.frame(width: 200, height: 200)
      Text("Color: \(appModel.picker.color?.description ?? "nothing")")
    }
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
    pickerWindow.contentView = NSHostingView(rootView: Picker(window: pickerWindow).environmentObject(appModel.picker))

    pickerWindow.makeKeyAndOrderFront(nil)
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Main()
  }
}
