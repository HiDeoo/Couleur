//
//  Components.swift
//  Couleur
//
//  Created by HiDeo on 27/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

enum ComponentsType: String, CaseIterable {
  case RGBA
  case HSBA
}

struct Components: View {
  @Binding var color: CColor
  @Binding var type: ComponentsType

  var body: some View {
    VStack {
      SegmentedControl(options: ComponentsType.allCases, value: $type, valueRenderer: componentsTypeRenderer)
      Group {
        if type == .RGBA {
          RGBA(color: self.$color)
        } else if type == .HSBA {
          HSBA
        }
      }
    }
  }

  func componentsTypeRenderer(type: ComponentsType) -> String {
    type.rawValue
  }

  struct RGBA: View {
    @Binding var color: CColor

    var body: some View {
      HStack {
        ComponentField(label: "R", value: self.color.red, multiplier: 255, onChange: setRed)
        ComponentField(label: "G", value: self.color.green, multiplier: 255, onChange: setGreen)
        ComponentField(label: "B", value: self.color.blue, multiplier: 255, onChange: setBlue)
        ComponentField(label: "A", value: self.color.alpha, multiplier: 100, onChange: setAlpha)
      }
    }

    func setRed(red: CGFloat) {
      color.setRgb(red: red, green: color.green, blue: color.blue)
    }

    func setGreen(green: CGFloat) {
      color.setRgb(red: color.red, green: green, blue: color.blue)
    }

    func setBlue(blue: CGFloat) {
      color.setRgb(red: color.red, green: color.green, blue: blue)
    }

    func setAlpha(alpha: CGFloat) {
      color.setAlpha(alpha)
    }
  }

  var HSBA = HStack {
    Text("H")
    Text("S")
    Text("B")
    Text("A")
  }
}

struct Components_Previews: PreviewProvider {
  static var previews: some View {
    Components(color: .constant(CColor(.blue)), type: .constant(.RGBA))
  }
}
