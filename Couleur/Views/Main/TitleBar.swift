//
//  TitleBar.swift
//  Couleur
//
//  Created by HiDeo on 22/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct TitleBar: View {
  @EnvironmentObject var appModel: AppModel

  @State private var showHistory: Bool = false

  var body: some View {
    ZStack {
      LinearGradient(
        gradient: Gradient(colors: [Color("windowAltBackground"), Color("windowBackground")]),
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
  }
}

struct TitleBar_Previews: PreviewProvider {
  static var previews: some View {
    TitleBar()
  }
}
