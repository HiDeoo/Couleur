//
//  PickerButton.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct PickerButton: View {
  let color: HSBColor
  let action: Action

  @State private var showColorCopiedNotification = false

  init(color: HSBColor, action: @escaping Action) {
    self.color = color
    self.action = action

    copiedNotificationColor = HSBColor(color.raw)
    copiedNotificationColor.setAlpha(1)
  }

  private var copiedNotificationColor: HSBColor

  var body: some View {
    Button(action: action) {
      ZStack {
        TransparencyLayer()
          .frame(width: Constants.MainWindowSize.width, height: Constants.ColorPreviewHeight)
        Rectangle()
          .fill(Color(color))
          .frame(width: Constants.MainWindowSize.width, height: Constants.ColorPreviewHeight)
        ZStack {
          if showColorCopiedNotification {
            Text("Copied")
              .padding(.vertical, 8)
              .padding(.horizontal, 12)
              .background(Color(color.getTextContrastColor()).opacity(0.7))
              .foregroundColor(Color(copiedNotificationColor))
              .cornerRadius(Constants.ControlCornerRadius * 2)
              .font(.system(.headline))
              .transition(AnyTransition.opacity.combined(with: .scale))
          }

        }.animation(.easeOut(duration: 0.25))
      }
    }
    .buttonStyle(BorderlessButtonStyle())
    .onReceive(NotificationCenter.default.publisher(for: Notification.ColorCopied), perform: onColorCopiedNotification)
  }

  func onColorCopiedNotification(notification _: Notification) {
    withAnimation {
      showColorCopiedNotification.toggle()
    }

    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
      self.showColorCopiedNotification.toggle()
    }
  }
}

struct PickerButton_Previews: PreviewProvider {
  static var previews: some View {
    PickerButton(color: HSBColor(.blue), action: {})
  }
}
