//
//  Picker.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Carbon.HIToolbox
import SwiftUI

struct Picker: View {
  let window: NSWindow

  @State var previewImage: CGImage?
  @State var mouseMonitor: Any?

  @EnvironmentObject var appModel: AppModel

  // Remove the border width from both sides.
  let clippedFrameSize = Constants.PickerSize - 2

  var body: some View {
    ZStack {
      if self.previewImage != nil {
        Image(decorative: self.previewImage!, scale: 1)
          .interpolation(.none)
          .resizable()
          .clipShape(Circle())
      }
      PickerGrid()
    }
    .clipShape(Circle())
    .frame(width: clippedFrameSize, height: clippedFrameSize)
    .overlay(Circle().stroke(Color.black, lineWidth: 1))
    .frame(width: Constants.PickerSize, height: Constants.PickerSize)
    .onAppear {
      CGDisplayHideCursor(self.getWindowId())

      self.updatePreview(point: NSEvent.mouseLocation)

      self.mouseMonitor = NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved, .leftMouseUp, .keyDown], handler: { event in
        if event.type == .mouseMoved {
          self.onMouseMove(event: event)
        } else if event.type == .leftMouseUp {
          self.close(shouldPick: true)
        } else if event.type == .keyDown {
          self.onKeyDown(event: event)
        }

        return nil
      })
    }
  }

  func close(shouldPick: Bool) {
    if mouseMonitor != nil {
      NSEvent.removeMonitor(mouseMonitor!)
    }

    if let color = appModel.picker.color, shouldPick {
      appModel.selectedColor = CColor(color)
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

    let cursor = CGPoint(x: point.x, y: NSScreen.screens[0].frame.size.height - point.y)
    let pickerHalf = (Constants.PickerPointCount / 2).rounded()

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

      let pickerSizeHalf = Constants.PickerSize / 2
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
        appModel.picker.color = NSColor(
          colorSpace: bitmap.colorSpace,
          components: components,
          count: color.numberOfComponents
        )
      }
    }
  }

  func getWindowId() -> UInt32 {
    CGWindowID(window.windowNumber)
  }
}

struct Picker_Previews: PreviewProvider {
  static var previews: some View {
    Picker(window: NSWindow())
  }
}
