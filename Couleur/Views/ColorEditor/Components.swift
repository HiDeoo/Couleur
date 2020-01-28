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

  private let segmentedControlPadding: CGFloat = 5

  var body: some View {
    VStack {
      SegmentedControl(options: ComponentsType.allCases, value: $type, valueRenderer: componentsTypeRenderer)
        .padding(.bottom, segmentedControlPadding)
        .padding(.top, segmentedControlPadding)
      Group {
        if type == .RGBA {
          RGBA(color: self.$color)
        } else if type == .HSBA {
          HSBA(color: self.$color)
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
        ComponentField(label: "R", value: self.color.red, type: .Byte, onChange: setRed)
        ComponentField(label: "G", value: self.color.green, type: .Byte, onChange: setGreen)
        ComponentField(label: "B", value: self.color.blue, type: .Byte, onChange: setBlue)
        ComponentField(label: "A", value: self.color.alpha, type: .Percent, onChange: setAlpha)
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

  struct HSBA: View {
    @Binding var color: CColor

    var body: some View {
      HStack {
        ComponentField(label: "H", value: self.color.hue, type: .Angle, onChange: setHue)
        ComponentField(label: "S", value: self.color.saturation, type: .Percent, onChange: setSaturation)
        ComponentField(label: "B", value: self.color.brightness, type: .Percent, onChange: setBrightness)
        ComponentField(label: "A", value: self.color.alpha, type: .Percent, onChange: setAlpha)
      }
    }

    func setHue(hue: CGFloat) {
      color.setHue(hue)
    }

    func setSaturation(saturation: CGFloat) {
      color.setSaturationAndBrightness(saturation, color.brightness)
    }

    func setBrightness(brightness: CGFloat) {
      color.setSaturationAndBrightness(color.saturation, brightness)
    }

    func setAlpha(alpha: CGFloat) {
      color.setAlpha(alpha)
    }
  }
}

struct Components_Previews: PreviewProvider {
  static var previews: some View {
    Components(color: .constant(CColor(.blue)), type: .constant(.RGBA))
  }
}
