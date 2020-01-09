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
  
  var body: some View {
    VStack {
      if ((self.previewImage) != nil) {
        Image(decorative: self.previewImage!, scale: 1.0).border(Color.pink)
      }
    }
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
    
    let previewSize: CGFloat = 300
    let cursor = CGPoint(x: point.x, y: NSScreen.screens[0].frame.size.height - point.y)
    let rect = CGRect(x: cursor.x - previewSize / 2, y: cursor.y - previewSize / 2, width: previewSize, height: previewSize)
      
    self.previewImage = CGWindowListCreateImage(rect, .optionOnScreenBelowWindow, CGWindowID(window.windowNumber), .bestResolution)
    
    self.window.setFrameOrigin(point)
  }
}

struct Picker_Previews: PreviewProvider {
  static var window = NSWindow()
  
  static var previews: some View {
    Picker(window: window)
  }
}
