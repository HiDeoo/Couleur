//
//  AppState.swift
//  Couleur
//
//  Created by HiDeo on 15/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation
import Combine

class AppModel: ObservableObject {
  @Published var picker = PickerModel()
  
  var anyCancellable: AnyCancellable? = nil
  
  init() {
    // Nested models are not yet supported in SwiftUI so we need to manually handle nested changes.
    anyCancellable = picker.objectWillChange.sink { (_) in
      self.objectWillChange.send()
    }
  }
}
