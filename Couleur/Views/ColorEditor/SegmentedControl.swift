//
//  SegmentedControl.swift
//  Couleur
//
//  Created by HiDeo on 27/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

typealias SegmentedControlValueRenderer<T> = (T) -> String

struct SegmentedControl<OptionType>: View where OptionType: Equatable {
  let options: [OptionType]
  @Binding var value: OptionType
  let valueRenderer: SegmentedControlValueRenderer<OptionType>

  var body: some View {
    HStack {
      ForEach(0 ..< options.count, id: \.self) { index in
        SegmentedButton(option: self.options[index], value: self.$value, valueRenderer: self.valueRenderer)
      }
    }
  }

  struct SegmentedButton<OptionType>: View where OptionType: Equatable {
    let option: OptionType
    @Binding var value: OptionType
    let valueRenderer: SegmentedControlValueRenderer<OptionType>

    var body: some View {
      Button(action: {
        self.value = self.option
        }) {
        Text(valueRenderer(self.option))
      }
      .disabled(self.option == self.value)
    }
  }
}

struct SegmentedControl_Previews: PreviewProvider {
  static func valueRenderer(option _: String) -> String {
    "test"
  }

  static var previews: some View {
    SegmentedControl(options: ["a", "b", "c"], value: .constant("a"), valueRenderer: valueRenderer)
  }
}
