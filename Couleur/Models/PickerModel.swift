//
//  MainState.swift
//  Couleur
//
//  Created by HiDeo on 15/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation
import SwiftUI

class PickerModel: ObservableObject {
  /**
   * The color at the center of the picker while picking.
   */
  @Published var color: NSColor?
}
