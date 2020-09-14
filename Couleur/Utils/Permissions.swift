//
//  Permissions.swift
//  Couleur
//
//  Created by HiDeo on 16/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

class Permissions {
  // https://gist.github.com/soffes/da6ea98be4f56bc7b8e75079a5224b37
  static func canRecordScreen() -> Bool {
    if #available(macOS 10.15, *) {
      let runningApplication = NSRunningApplication.current
      let processIdentifier = runningApplication.processIdentifier

      guard let windows = CGWindowListCopyWindowInfo([.optionOnScreenOnly], kCGNullWindowID)
        as? [[String: AnyObject]]
      else {
        assertionFailure("Invalid window info")
        return false
      }

      for window in windows {
        // Get information for each window
        guard let windowProcessIdentifier = (window[String(kCGWindowOwnerPID)] as? Int).flatMap(pid_t.init) else {
          assertionFailure("Invalid window info")
          continue
        }

        // Don't check windows owned by this process
        if windowProcessIdentifier == processIdentifier {
          continue
        }

        // Get process information for each window
        guard let windowRunningApplication = NSRunningApplication(processIdentifier: windowProcessIdentifier) else {
          // Ignore processes we don't have access to, such as WindowServer, which manages the windows named
          // "Menubar" and "Backstop Menubar"
          continue
        }

        if window[String(kCGWindowName)] as? String != nil {
          if windowRunningApplication.executableURL?.lastPathComponent == "Dock" {
            // Ignore the Dock, which provides the desktop picture
            continue
          } else {
            return true
          }
        }
      }

      return false
    } else {
      return false
    }
  }
}
