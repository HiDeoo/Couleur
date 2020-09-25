//
//  TitleBar.swift
//  Couleur
//
//  Created by HiDeo on 22/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

/**
 * Colors composing the title bar gradients (starting from the top).
 */
var ActiveGradient = [Color("windowAltBackground"), Color("windowBackground")]
var InactiveGradient = [Color("windowInactiveAltBackground"), Color("windowInactiveBackground")]

struct TitleBar: View {
  @EnvironmentObject var appModel: AppModel

  @State private var showHistory: Bool = false
  @State private var isAppActive = NSApp.isActive

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: self.isAppActive ? ActiveGradient : InactiveGradient),
        startPoint: .top,
        endPoint: .bottom
      )
      HStack {
        Spacer()
        Button(action: {
          self.showHistory.toggle()
        }) {
          Text("􀐫")
            .padding(Constants.WindowPadding)
            .font(.system(.headline))
            .opacity(self.isAppActive ? 1 : 0.6)
        }
        .disabled(appModel.history.isEmpty)
        .buttonStyle(BorderlessButtonStyle())
        .foregroundColor(self.showHistory ? Color("windowTint") : .white)
        .opacity(appModel.history.isEmpty ? 0.4 : 1)
        .popover(
          isPresented: self.$showHistory,
          arrowEdge: .bottom
        ) {
          History(colors: self.appModel.history.values) { color in
            self.appModel.color = color
            self.showHistory.toggle()
          }
        }
        .overlay(Tooltip(tooltip: appModel.history.isEmpty ? "No history yet" : "History"))
      }
    }
    .frame(width: Constants.MainWindowSize.width, height: Constants.MainWindowTitleBarHeight)
    .edgesIgnoringSafeArea(.vertical)
    .onReceive(NotificationCenter.default.publisher(for: NSApplication.didResignActiveNotification)) { _ in
      self.isAppActive = false
    }
    .onReceive(NotificationCenter.default.publisher(for: NSApplication.didBecomeActiveNotification)) { _ in
      self.isAppActive = true
    }
  }
}

struct TitleBar_Previews: PreviewProvider {
  static var previews: some View {
    TitleBar()
  }
}
