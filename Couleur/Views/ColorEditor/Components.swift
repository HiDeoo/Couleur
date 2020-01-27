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
  @Binding var type: ComponentsType

  var body: some View {
    VStack {
      SegmentedControl(options: ComponentsType.allCases, value: $type, valueRenderer: componentsTypeRenderer)
      Group {
        if type == .RGBA {
          RGBA
        } else if type == .HSBA {
          HSBA
        }
      }
    }
  }

  func componentsTypeRenderer(type: ComponentsType) -> String {
    type.rawValue
  }

  var RGBA = HStack {
    Text("R")
    Text("G")
    Text("B")
    Text("A")
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
    Components(type: .constant(.RGBA))
  }
}
