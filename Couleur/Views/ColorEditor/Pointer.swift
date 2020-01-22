//
//  Pointer.swift
//  Couleur
//
//  Created by HiDeo on 20/01/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct Pointer: View {
  var body: some View {
    RoundedRectangle(cornerRadius: 10)
      .stroke(lineWidth: 3)
      .frame(width: 10, height: 10)
      .foregroundColor(Color.green)
  }
}

struct Pointer_Previews: PreviewProvider {
  static var previews: some View {
    Pointer()
  }
}
