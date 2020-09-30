//
//  ColorPicker.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Carbon.HIToolbox
import SwiftUI

struct ColorPicker: View {
  let window: NSWindow

  @EnvironmentObject var appModel: AppModel

  @State private var previewImage: CGImage?
  @State private var eventMonitor: Any?
  @State private var previewFlipped = false

  // Remove the border width from both sides.
  let clippedFrameSize = Constants.PickerDimension - 2

  var body: some View {
    ZStack {
      ZStack {
        if self.previewImage != nil {
          Image(decorative: self.previewImage!, scale: 1)
            .interpolation(.none)
            .resizable()
            .clipShape(Circle())
        }
        ColorPickerGrid()
      }
      .clipShape(Circle())
      .frame(width: clippedFrameSize, height: clippedFrameSize)
      .overlay(Circle().stroke(Color.black, lineWidth: 1))
      .frame(width: Constants.PickerDimension, height: Constants.PickerDimension + Constants.PickerPreviewHeight * 2)
      if appModel.picker.color != nil {
        ColorPickerPreview(color: appModel.picker.color!,
                           format: appModel.format,
                           useUpperCaseHex: appModel.useUpperCaseHex,
                           useSpaceSeparatedCss: appModel.useSpaceSeparatedCss,
                           flipped: previewFlipped)
      }
    }
    .onAppear {
      CGDisplayHideCursor(self.getWindowId())

      self.updatePreview(point: NSEvent.mouseLocation)

      self.eventMonitor = NSEvent.addLocalMonitorForEvents(
        matching: [.mouseMoved, .leftMouseUp, .keyDown],
        handler: { event in
          if event.type == .mouseMoved {
            self.onMouseMove(event: event)
          } else if event.type == .leftMouseUp {
            self.close(shouldPick: true)
          } else if event.type == .keyDown {
            self.onKeyDown(event: event)
          }

          return nil
        }
      )
    }
  }

  func close(shouldPick: Bool) {
    if eventMonitor != nil {
      NSEvent.removeMonitor(eventMonitor!)
    }

    if let color = appModel.picker.color, shouldPick {
      appModel.color = color
    }

    NotificationCenter.default.post(name: Notification.ColorPicked, object: nil)

    window.close()

    CGDisplayShowCursor(getWindowId())
  }

  func onMouseMove(event _: NSEvent) {
    updatePreview(point: NSEvent.mouseLocation)
  }

  func onKeyDown(event: NSEvent) {
    if event.keyCode == kVK_Escape {
      close(shouldPick: false)
    }
  }

  func updatePreview(point: NSPoint) {
    if !window.isKeyWindow {
      window.makeKeyAndOrderFront(nil)
    }

    if let screen = NSScreen.main {
      let screenHeight = screen.frame.size.height
      let cursor = CGPoint(x: point.x, y: max(1, screenHeight - point.y + screen.frame.origin.y))
      let pickerHalf = (Constants.PickerPointCount / 2).rounded()

      previewFlipped = screenHeight - cursor.y < Constants.PickerPreviewFlipOffset

      let rect = CGRect(
        x: cursor.x - pickerHalf,
        y: cursor.y - pickerHalf,
        width: Constants.PickerPointCount,
        height: Constants.PickerPointCount
      )

      let screenshot = CGWindowListCreateImage(rect, .optionOnScreenBelowWindow, getWindowId(), .nominalResolution)

      if let previewImage = screenshot {
        self.previewImage = previewImage

        updateColor()

        let pickerSizeHalf = Constants.PickerDimension / 2

        window.setFrameOrigin(
          NSMakePoint(
            point.x - pickerSizeHalf,
            min(
              point.y - pickerSizeHalf - Constants.PickerPreviewHeight,
              screenHeight - pickerSizeHalf - Constants.PickerPreviewHeight
            )
          )
        )
      }
    }
  }

  func updateColor() {
    if let image = previewImage {
      let bitmap = NSBitmapImageRep(cgImage: image)
      let center = Int(floor(Constants.PickerPointCount / 2))
      let centerColor = bitmap.colorAt(x: center, y: center)

      if let color = centerColor {
        appModel.picker.color = HSBColor(color)
      }
    }
  }

  func getWindowId() -> UInt32 {
    CGWindowID(window.windowNumber)
  }
}

struct ColorPicker_Previews: PreviewProvider {
  static var previews: some View {
    ColorPicker(window: NSWindow())
  }
}
