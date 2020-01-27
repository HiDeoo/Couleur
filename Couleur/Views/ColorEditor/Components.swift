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
        Text("G")
        Text("B")
        Text("A")
      }
    }

    func setRed(red: CGFloat) {
      color.setRgb(red: red, green: color.green, blue: color.blue)
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
