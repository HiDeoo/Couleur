//
//  AppDelegate.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Cocoa
import SwiftUI

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
  var window: NSWindow!

  func applicationDidFinishLaunching(_: Notification) {
    let main = Main()

    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: Constants.ColorPreviewSize, height: Constants.ColorPreviewSize),
      styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
      backing: .buffered, defer: false
    )
    window.center()
    window.setFrameAutosaveName("Main")
    window.contentView = NSHostingView(rootView: main.environmentObject(AppModel()))

    window.makeKeyAndOrderFront(nil)
  }
}
