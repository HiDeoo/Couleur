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
    HStack(spacing: 1) {
      ForEach(0 ..< options.count, id: \.self) { index in
        SegmentedButton(
          option: self.options[index],
          value: self.$value,
          valueRenderer: self.valueRenderer,
          leftRadius: index == 0 ? Constants.ControlCornerRadius : 0,
          rightRadius: index == self.options.count - 1 ? Constants.ControlCornerRadius : 0
        )
      }
    }
  }

  struct SegmentedButton<OptionType>: View where OptionType: Equatable {
    let option: OptionType
    @Binding var value: OptionType
    let valueRenderer: SegmentedControlValueRenderer<OptionType>
    let leftRadius: CGFloat
    let rightRadius: CGFloat

    var body: some View {
      let disabled = self.option == self.value

      return Button(action: {
        self.value = self.option
        }) {
        Text(valueRenderer(self.option))
          .padding(EdgeInsets(top: 4, leading: 14, bottom: 4, trailing: 14))
          .foregroundColor(.white)
          .background(
            RoundedCorners(
              color: disabled ? Color("windowTint") : Color("windowAltBackground"),
              topLeft: leftRadius,
              topRight: rightRadius,
              bottomLeft: leftRadius,
              bottomRight: rightRadius
            )
          )
      }
      .buttonStyle(PlainButtonStyle())
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
