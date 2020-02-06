//
//  StackedView.swift
//  Couleur
//
//  Created by HiDeo on 06/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct StackedView<Content>: View where Content: View {
  var content: Content

  @inlinable init(@ViewBuilder content: () -> Content) {
    self.content = content()
  }

  var body: some View {
    HStack(spacing: 0) {
      Rectangle()
        .frame(width: Constants.StackedViewOffset, height: Constants.MainWindowSize.height)
      ZStack(alignment: .leading) {
        self.content
        LinearGradient(
          gradient: Gradient(colors: [.black, .clear]),
          startPoint: .leading,
          endPoint: .trailing
        )
        .frame(width: 3, height: Constants.MainWindowSize.height)
      }
    }
    .frame(width: Constants.MainWindowSize.width, height: Constants.MainWindowSize.height)
  }
}

struct StackedView_Previews: PreviewProvider {
  static var previews: some View {
    StackedView {
      Text("test")
    }
  }
}
