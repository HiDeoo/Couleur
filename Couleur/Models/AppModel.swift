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
   * The currently selected color (color picker excluded).
   */
  @Published var selectedColor = Constants.ColorPreviewDefaultColor

  /**
   * The currently selected color format.
   */
  @Published(forUserDefaultsKey: "selectedFormat") var selectedFormat = Constants.ColorDefaultFormat

  /**
   * The components editor current type.
   */
  @Published(forUserDefaultsKey: "componentsEditorType") var componentsEditorType = Constants.ComponentsEditorDefaultType

  var cancellable: AnyCancellable?

  init() {
    // Nested models are not yet supported in SwiftUI so we need to manually handle nested changes.
    cancellable = picker.objectWillChange.sink { _ in
      self.objectWillChange.send()
    }
  }
}
