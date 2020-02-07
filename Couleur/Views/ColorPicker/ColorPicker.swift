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
  @State private var previewFlipped = true

  // Remove the border width from both sides.
  let clippedFrameSize = Constants.PickerDimension - 2

  var body: some View {
    VStack {
      if previewFlipped {
        appModel.picker.color.map {
          ColorPickerPreview(color: $0, format: appModel.format)
        }
      }
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
      .frame(width: Constants.PickerDimension, height: Constants.PickerDimension)
      if !previewFlipped {
        appModel.picker.color.map {
          ColorPickerPreview(color: $0, format: appModel.format)
        }
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

    // TODO: Pick proper screen
    let screenHeight = NSScreen.screens[0].frame.size.height
    let previewHeightOffset = Constants.PickerPreviewHeight * (previewFlipped ? 0 : 1)
    let cursor = CGPoint(x: point.x, y: screenHeight - point.y - previewHeightOffset)
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
      window.setFrameOrigin(NSMakePoint(point.x - pickerSizeHalf, point.y - pickerSizeHalf))
    }
  }

  func updateColor() {
    if let image = previewImage {
      let bitmap = NSBitmapImageRep(cgImage: image)
      let center = Int(floor(Constants.PickerPointCount / 2))
      let centerColor = bitmap.colorAt(x: center, y: center)

      if let color = centerColor {
        // The color doesn't match the screen color space.
        // https://stackoverflow.com/a/47005433/1945960
        let components = UnsafeMutablePointer<CGFloat>.allocate(capacity: color.numberOfComponents)

        // Grab the color components.
        color.getComponents(components)

        // Get a new color with the proper color space.
        appModel.picker.color = HSBColor(
          NSColor(
            colorSpace: bitmap.colorSpace,
            components: components,
            count: color.numberOfComponents
          )
        )
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
