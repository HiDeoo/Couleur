//
//  DebugView.swift
//  Couleur
//
//  Created by HiDeo on 15/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

extension View {
  func debugView(color: Color = .red) -> some View {
    #if DEBUG
      return overlay(Rectangle().stroke(color))
    #else
      return self
    #endif
  }
}
