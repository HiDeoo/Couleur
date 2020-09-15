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
  var preferencesWindow: NSWindow!
  let appModel = AppModel()

  func applicationWillFinishLaunching(_: Notification) {
    UserDefaults.standard.set(true, forKey: "NSDisabledDictationMenuItem")
    UserDefaults.standard.set(true, forKey: "NSDisabledCharacterPaletteMenuItem")
  }

  func applicationDidFinishLaunching(_: Notification) {
    let main = Main()

    window = NSWindow(
      contentRect: NSRect(x: 0, y: 0, width: Constants.MainWindowSize.width, height: Constants.ColorPreviewHeight),
      styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
      backing: .buffered, defer: false
    )
    window.center()
    window.setFrameAutosaveName("Main")
    window.contentView = NSHostingView(rootView: main.environmentObject(appModel))

    window.makeKeyAndOrderFront(nil)
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
    true
  }

  @IBAction func openPreferencesWindow(sender _: AnyObject) {
    if preferencesWindow == nil {
      preferencesWindow = NSWindow(
        contentRect: NSRect(x: 0, y: 0, width: 500, height: 300),
        styleMask: [.titled, .closable, .miniaturizable, .fullSizeContentView],
        backing: .buffered, defer: false
      )
      preferencesWindow.center()
      preferencesWindow.setFrameAutosaveName("Preferences")
      preferencesWindow.isReleasedWhenClosed = false
      preferencesWindow.contentView = NSHostingView(rootView: Preferences().environmentObject(appModel))
    }

    preferencesWindow.makeKeyAndOrderFront(nil)
  }
}
