//
//  AppState.swift
//  Couleur
//
//  Created by HiDeo on 15/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Combine
import SwiftUI

class AppModel: ObservableObject {
  @Published var picker = PickerModel()

  /**
   * The current color (color picker excluded).
   */
  @Published(forUserDefaultsKey: "color") var color = Constants.ColorPreviewDefaultColor

  /**
   * The current color format.
   */
  @Published(forUserDefaultsKey: "format") var format = Constants.ColorDefaultFormat

  /**
   * The current components editor current type.
   */
  @Published(forUserDefaultsKey: "componentsEditorType") var componentsEditorType = Constants.ComponentsEditorDefaultType

  /**
   * Defines if upper case letters should be used for hexadecimal color formats.
   */
  @Published(forUserDefaultsKey: "useUpperCaseHex") var useUpperCaseHex = Constants.UseUpperCaseHexDefault

  /**
   * Defines if upper case letters should be used for hexadecimal color formats.
   */
  @Published(forUserDefaultsKey: "copyPickedColor") var copyPickedColor = Constants.CopyPickedColorDefault

  /**
   * Copied colors history.
   */
  @Published(forUserDefaultsKey: "history") var history = [HSBColor]()

  var cancellable: AnyCancellable?

  init() {
    // Nested models are not yet supported in SwiftUI so we need to manually handle nested changes.
    cancellable = picker.objectWillChange.sink { _ in
      self.objectWillChange.send()
    }
  }
}
