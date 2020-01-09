//
//  Main.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Main: View {
  var body: some View {
    Button(action: showPicker) {
      Text("Go")
    }.frame(maxWidth: .infinity, maxHeight: .infinity)
  }
  
  func showPicker() {
    let window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: 300, height: 300),
      styleMask: [.titled],
      backing: .buffered, defer: false)
    window.center()
    window.contentView = NSHostingView(rootView:Picker(windowId: CGWindowID(window.windowNumber)))
    window.contentView?.wantsLayer = true
    
    window.makeKeyAndOrderFront(nil)
  }
}

struct Main_Previews: PreviewProvider {
  static var previews: some View {
    Main()
  }
}
