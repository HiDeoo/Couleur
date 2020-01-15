//
//  Picker.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Picker: View {
  let window: NSWindow
   
  @State var previewImage: CGImage?
  @State var mouseMonitor: Any?
  
  // Remove the border width from both sides.
  let clippedFrameSize = Constants.PickerSize - 2
  
  var body: some View {
    ZStack {
      if ((self.previewImage) != nil) {
        Image(decorative: self.previewImage!, scale: 1.0)
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
      self.updatePreview(point: NSEvent.mouseLocation)
      
      self.mouseMonitor = NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved, .leftMouseUp], handler: { event in
        if event.type == .mouseMoved {
          self.onMouseMove(event: event)
        } else if event.type == .leftMouseUp {
          if self.mouseMonitor != nil {
            NSEvent.removeMonitor(self.mouseMonitor!)
          }
          
          self.window.close()
        }
        
        return nil
      })
    }
  }
  
  func onMouseMove(event: NSEvent) {
    self.updatePreview(point: NSEvent.mouseLocation)
  }
  
  func updatePreview(point: NSPoint) {
    if !self.window.isKeyWindow {
      self.window.makeKeyAndOrderFront(nil)
    }
    
    let cursor = CGPoint(x: point.x, y: NSScreen.screens[0].frame.size.height - point.y)
    let pickerHalf = (Constants.PickerPointCount / 2).rounded()
    
    let rect = CGRect(
      x: cursor.x - pickerHalf,
      y: cursor.y - pickerHalf,
      width: Constants.PickerPointCount,
      height: Constants.PickerPointCount)

    let screenshot = CGWindowListCreateImage(rect,
                                             .optionOnScreenBelowWindow,
                                             CGWindowID(window.windowNumber),
                                             .nominalResolution)
    
    if let previewImage = screenshot {
      self.previewImage = previewImage
      
      let pickerSizeHalf = Constants.PickerSize / 2
      self.window.setFrameOrigin(NSMakePoint(point.x - pickerSizeHalf, point.y - pickerSizeHalf))
    }
  }
}

struct Picker_Previews: PreviewProvider {
  static var window = NSWindow()
  
  static var previews: some View {
    Picker(window: window)
  }
}
