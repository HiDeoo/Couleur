//
//  CTextField.swift
//  Couleur
//
//  Created by HiDeo on 30/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct CTextField: View {
  @Binding var value: String

  var body: some View {
    CNSTextField(value: $value)
      .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
      .textFieldStyle(PlainTextFieldStyle())
      .background(Color("windowAltBackground"))
      .border(Color.clear)
      .cornerRadius(4)
  }
}

struct CNSTextField: NSViewRepresentable {
  @Binding var value: String

  func makeNSView(context: NSViewRepresentableContext<CNSTextField>) -> NSTextField {
    let textField = NSTextField(string: value)
    textField.delegate = context.coordinator
    textField.isBordered = false
    textField.backgroundColor = .clear
    textField.focusRingType = .none

    return textField
  }

  func updateNSView(_ nsView: NSTextField, context _: NSViewRepresentableContext<CNSTextField>) {
    nsView.stringValue = value
  }

  func makeCoordinator() -> Coordinator {
    Coordinator {
      self.value = $0
    }
  }

  final class Coordinator: NSObject, NSTextFieldDelegate {
    var setValue: (String) -> Void

    init(_ setValue: @escaping (String) -> Void) {
      self.setValue = setValue
    }

    func controlTextDidChange(_ obj: Notification) {
      if let textField = obj.object as? NSTextField {
        setValue(textField.stringValue)
      }
    }
  }
}

struct CNSTextField_Previews: PreviewProvider {
  static var previews: some View {
    CNSTextField(value: .constant("test"))
  }
}
