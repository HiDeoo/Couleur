//
//  Tooltip.swift
//  Couleur
//
//  Created by HiDeo on 14/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Tooltip: NSViewRepresentable {
  let tooltip: String

  func makeNSView(context _: NSViewRepresentableContext<Tooltip>) -> NSView {
    let view = TooltipView()

    view.toolTip = tooltip

    return view
  }

  func updateNSView(_ nsView: NSView, context _: NSViewRepresentableContext<Tooltip>) {
    nsView.toolTip = tooltip
  }
}

class TooltipView: NSView {
  override func hitTest(_: NSPoint) -> NSView? {
    nil
  }
}
