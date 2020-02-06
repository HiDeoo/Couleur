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
  @Published var selectedFormat = ColorFormatter.Format.Hex

  /**
   * The components editor current type.
   */
  @Published var componentsEditorType = Constants.ComponentsEditorDefaultType

  var anyCancellable: AnyCancellable?

  init() {
    // Nested models are not yet supported in SwiftUI so we need to manually handle nested changes.
    anyCancellable = picker.objectWillChange.sink { _ in
      self.objectWillChange.send()
    }
  }
}
