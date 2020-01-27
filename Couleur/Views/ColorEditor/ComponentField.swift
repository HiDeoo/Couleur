//
//  ComponentField.swift
//  Couleur
//
//  Created by HiDeo on 27/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

enum ComponentFieldError: Error {
  case invalid
  case tooBig
  case tooSmall
}

struct ComponentField: View {
  let label: String
  let value: CGFloat
  let multiplier: CGFloat
  let onChange: (_ newValue: CGFloat) -> Void

  @State private var displayValue: String?

  var body: some View {
    let valueBinding = Binding<String>(
      get: {
        String(format: "%.0f", round(self.getDisplayValue()))
      },
      set: { newValue in
        do {
          guard let numberValue = NumberFormatter().number(from: newValue) else {
            throw ComponentFieldError.invalid
          }

          let floatValue = CGFloat(truncating: numberValue)

          guard floatValue <= self.multiplier else {
            throw ComponentFieldError.tooBig
          }

          guard floatValue >= 0 else {
            throw ComponentFieldError.tooSmall
          }

          self.onChange(self.getValueFromDisplayValue(floatValue))
        } catch ComponentFieldError.tooBig {
          self.onChange(self.getValueFromDisplayValue(self.multiplier))
        } catch ComponentFieldError.tooSmall {
          self.onChange(self.getValueFromDisplayValue(0))
        } catch {
          self.onChange(self.value)
        }
      }
    )

    return TextField(label, text: valueBinding)
      .onAppear {
        valueBinding.wrappedValue = self.value.description
      }
  }

  func getDisplayValue() -> CGFloat {
    value * multiplier
  }

  func getValueFromDisplayValue(_ displayValue: CGFloat) -> CGFloat {
    displayValue / multiplier
  }
}

struct ComponentField_Previews: PreviewProvider {
  static func onChange(newValue _: CGFloat) {}

  static var previews: some View {
    ComponentField(label: "test", value: 0.5, multiplier: 100, onChange: onChange)
  }
}
