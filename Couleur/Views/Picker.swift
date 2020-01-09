//
//  Picker.swift
//  Couleur
//
//  Created by HiDeo on 09/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Picker: View {
  let windowId: UInt32
  
  @State var previewImage: CGImage?
  
  var body: some View {
    VStack {
      if ((self.previewImage) != nil) {
        Image(decorative: self.previewImage!, scale: 1.0).border(Color.pink)
      }
    }
    .onAppear {
      self.updatePreview(point: NSEvent.mouseLocation)
      
      NSEvent.addLocalMonitorForEvents(matching: [.mouseMoved], handler: { event in
          self.onMouseMove(event: event)
          return nil
      })
    }
  }
  
  func onMouseMove(event: NSEvent) {
    self.updatePreview(point: NSEvent.mouseLocation)
  }
  
  func updatePreview(point: NSPoint) {
    let previewSize: CGFloat = 300
    let cursor = CGPoint(x: point.x, y: NSScreen.screens[0].frame.size.height - point.y)
    let rect = CGRect(x: cursor.x - previewSize / 2, y: cursor.y - previewSize / 2, width: previewSize, height: previewSize)
      
    self.previewImage = CGWindowListCreateImage(rect, .optionOnScreenBelowWindow, self.windowId, .bestResolution)
  }
}

struct Picker_Previews: PreviewProvider {
  static var windowId: UInt32 = 0
  
  static var previews: some View {
    Picker(windowId: windowId)
  }
}
