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
  var mainWindow: NSWindow!
  var preferencesWindow: NSWindow!
  let appModel = AppModel()

  func applicationWillFinishLaunching(_: Notification) {
    UserDefaults.standard.set(true, forKey: "NSDisabledDictationMenuItem")
    UserDefaults.standard.set(true, forKey: "NSDisabledCharacterPaletteMenuItem")
  }

  func applicationDidFinishLaunching(_: Notification) {
    let main = Main()

    mainWindow = NSWindow(
      contentRect:
      NSRect(x: 0, y: 0, width: Constants.MainWindowSize.width, height: Constants.MainWindowSize.height + 22),
      styleMask: [.titled, .closable, .fullSizeContentView],
      backing: .buffered, defer: false
    )
    mainWindow.center()
    mainWindow.isReleasedWhenClosed = false
    mainWindow.setFrameAutosaveName("Main")
    mainWindow.contentView = NSHostingView(rootView: main.environmentObject(appModel))

    mainWindow.makeKeyAndOrderFront(nil)

    NotificationCenter.default
      .addObserver(self, selector: #selector(onColorPicked), name: Notification.ColorPicked, object: nil)
  }

  func applicationShouldTerminateAfterLastWindowClosed(_: NSApplication) -> Bool {
    false
  }

  func applicationShouldHandleReopen(_: NSApplication, hasVisibleWindows flag: Bool) -> Bool {
    if !flag {
      mainWindow.makeKeyAndOrderFront(nil)
    }

    return true
  }

  func copyColorToClipboard(withNofication: Bool = true) {
    let pasteboard = NSPasteboard.general

    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.setString(
      ColorFormatter.format(
        appModel.color,
        appModel.format,
        ColorFormatterOptions(useUpperCaseHex: appModel.useUpperCaseHex)
      ),
      forType: .string
    )

    if withNofication {
      NotificationCenter.default.post(name: Notification.ColorCopied, object: nil)
    }
  }

  @objc func onColorPicked() {
    if appModel.copyPickedColor {
      copyColorToClipboard(withNofication: false)
    }
  }

  @IBAction func openPreferencesWindow(sender _: AnyObject) {
    if preferencesWindow == nil {
      preferencesWindow = NSWindow(
        contentRect:
        NSRect(x: 0, y: 0, width: Constants.PreferencesWindowSize.width, height: Constants.PreferencesWindowSize.height),
        styleMask: [.titled, .closable, .fullSizeContentView],
        backing: .buffered, defer: false
      )
      preferencesWindow.center()
      preferencesWindow.isReleasedWhenClosed = false
      preferencesWindow.setFrameAutosaveName("Preferences")
      preferencesWindow.contentView = NSHostingView(rootView: Preferences().environmentObject(appModel))
    }

    preferencesWindow.makeKeyAndOrderFront(nil)
  }

  @IBAction func copy(sender _: AnyObject) {
    copyColorToClipboard()
  }
}
