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
  
  var body: some View {
    VStack {
      Button(action: showPicker) {
        Text("Go")
      }.frame(width: 200, height: 200)
      Text("Color: \(appModel.picker.color?.description ?? "nothing")")
    }
  }

  func showPicker() {
    let pickerWindow = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: Constants.PickerSize, height: Constants.PickerSize),
      styleMask: [],
      backing: .buffered, defer: false)

    pickerWindow.center()
    pickerWindow.isOpaque = false
    pickerWindow.backgroundColor = NSColor.clear
    pickerWindow.contentView = NSHostingView(rootView:Picker(window: pickerWindow).environmentObject(appModel.picker))

    pickerWindow.makeKeyAndOrderFront(nil)
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Main()
  }
}
