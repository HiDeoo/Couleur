//
//  TextField.swift
//  Couleur
//
//  Created by HiDeo on 30/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct TextField: View {
  @Binding var value: String

  var body: some View {
    TextFieldRepresentable(value: $value)
      .padding(EdgeInsets(top: 4, leading: 6, bottom: 4, trailing: 6))
      .textFieldStyle(PlainTextFieldStyle())
      .background(Color("windowAltBackground"))
      .border(Color.clear)
      .cornerRadius(Constants.ControlCornerRadius)
  }
}

struct TextFieldRepresentable: NSViewRepresentable {
  @Binding var value: String

  func makeNSView(context: NSViewRepresentableContext<TextFieldRepresentable>) -> NSTextField {
    let textField = AutoSelectTextField(string: value)
    textField.delegate = context.coordinator
    textField.isBordered = false
    textField.backgroundColor = .clear
    textField.focusRingType = .none

    return textField
  }

  func updateNSView(_ textField: NSTextField, context _: NSViewRepresentableContext<TextFieldRepresentable>) {
    textField.stringValue = value
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

struct TextField_Previews: PreviewProvider {
  static var previews: some View {
    TextFieldRepresentable(value: .constant("test"))
  }
}

class AutoSelectTextField: NSTextField {
  override func mouseDown(with event: NSEvent) {
    super.mouseDown(with: event)

    if let textEditor = currentEditor() {
      textEditor.selectAll(self)
    }
  }
}
