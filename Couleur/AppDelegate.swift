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
      NSRect(
        x: 0,
        y: 0,
        width: Constants.MainWindowSize.width,
        height: Constants.MainWindowSize.height + Constants.MainWindowTitleBarHeight
      ),
      styleMask: [.titled, .closable, .fullSizeContentView],
      backing: .buffered, defer: false
    )
    styleWindow(mainWindow)
    mainWindow.setFrameAutosaveName("Main")
    mainWindow.contentView = NSHostingView(rootView: main.environmentObject(appModel))

    let titleBar = TitleBar()

    let titleBarHostingView = NSHostingView(rootView: titleBar.environmentObject(appModel))
    titleBarHostingView.frame.size = titleBarHostingView.fittingSize

    let titlebarAccessory = NSTitlebarAccessoryViewController()
    titlebarAccessory.view = titleBarHostingView
    titlebarAccessory.layoutAttribute = .trailing

    mainWindow.toolbar = .init()
    mainWindow.titleVisibility = .hidden
    mainWindow.addTitlebarAccessoryViewController(titlebarAccessory)

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

  func styleWindow(_ window: NSWindow) {
    window.center()
    window.isReleasedWhenClosed = false
    window.titlebarAppearsTransparent = true
    window.backgroundColor = NSColor(named: "windowBackground")
    window.standardWindowButton(NSWindow.ButtonType.miniaturizeButton)?.isHidden = true
    window.standardWindowButton(NSWindow.ButtonType.zoomButton)?.isHidden = true
  }

  func copyColorToClipboard(withNofication: Bool = true) {
    let pasteboard = NSPasteboard.general

    pasteboard.declareTypes([.string], owner: nil)
    pasteboard.setString(
      ColorFormatter.format(
        appModel.color,
        appModel.format,
        ColorFormatterOptions(
          useUpperCaseHex: appModel.useUpperCaseHex,
          useSpaceSeparatedCss: appModel.useSpaceSeparatedCss
        )
      ),
      forType: .string
    )

    let firstHistoryColor = appModel.history.first

    if appModel.history.isEmpty || firstHistoryColor != appModel.color {
      appModel.history.append(appModel.color)
    }

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
      styleWindow(preferencesWindow)
      preferencesWindow.title = "Couleur Preferences"
      preferencesWindow.setFrameAutosaveName("Preferences")
      preferencesWindow.contentView = NSHostingView(rootView: Preferences().environmentObject(appModel))
    }

    preferencesWindow.makeKeyAndOrderFront(nil)
  }

  @IBAction func copy(sender _: AnyObject) {
    copyColorToClipboard()
  }

  @IBAction func paste(sender _: AnyObject) {
    let pasteboardStringItem = NSPasteboard.general.pasteboardItems?.first?.string(forType: .string)

    if let pasteboardString = pasteboardStringItem {
      if let color = ColorFormatter.match(pasteboardString) {
        appModel.color = color
      } else {
        NSSound.beep()
      }
    }
  }
}
