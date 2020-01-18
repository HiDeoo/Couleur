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
   * The currently selected color in the main window.
   */
  @Published var selectedColor: NSColor?

  var anyCancellable: AnyCancellable?

  init() {
    // Nested models are not yet supported in SwiftUI so we need to manually handle nested changes.
    anyCancellable = picker.objectWillChange.sink { _ in
      self.objectWillChange.send()
    }
  }
}
