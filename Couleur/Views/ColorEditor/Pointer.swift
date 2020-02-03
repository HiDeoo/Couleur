//
//  Pointer.swift
//  Couleur
//
//  Created by HiDeo on 20/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Pointer: View {
  private static var isVisible = true

  var body: some View {
    ZStack {
      ForEach(0 ..< 2, id: \.self) { index in
        Circle()
          .stroke(index % 2 == 0 ? Color.white : Color.black, lineWidth: 1)
          .frame(
            width: Constants.PointerDiameter - CGFloat(index) * 2,
            height: Constants.PointerDiameter - CGFloat(index) * 2
          )
      }
    }
  }

  static func onDragStart() {
    if isVisible {
      isVisible = false
      NSCursor.hide()
    }
  }

  static func onDragEnd() {
    if !isVisible {
      isVisible = true
      NSCursor.unhide()
    }
  }
}

struct Pointer_Previews: PreviewProvider {
  static var previews: some View {
    Pointer()
  }
}
