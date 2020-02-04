//
//  Alerts.swift
//  Couleur
//
//  Created by HiDeo on 19/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

func getPermissionsAlert(action: Action?) -> Alert {
  Alert(
    title: Text("Screen Recording permission is required"),
    message: Text("Couleur uses Screen Recording to pick a color.\n\nOpen the Security & Privacy panel in System Preferences and put a checkmark next to Couleur in the Screen Recording section."),
    dismissButton: .default(Text("OK"), action: action)
  )
}
