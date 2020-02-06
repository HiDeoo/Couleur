//
//  TransparencyLayer.swift
//  Couleur
//
//  Created by HiDeo on 03/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import SwiftUI

struct TransparencyLayer: View {
  var body: some View {
    GeometryReader { geometry in
      self.createPattern(geometry)
    }
  }

  func createPattern(_ geometry: GeometryProxy) -> some View {
    let vSquares = Int(ceil(geometry.size.height / Constants.TransparencyLayerSquareDimension))
    let hSquares = Int(ceil(geometry.size.width / Constants.TransparencyLayerSquareDimension))

    return VStack(alignment: .leading, spacing: 0) {
      ForEach(0 ... vSquares, id: \.self) { vIndex in
        HStack(spacing: 0) {
          ForEach(0 ... hSquares, id: \.self) { hIndex in
            Rectangle()
              .fill((hIndex + vIndex) % 2 == 0 ? Color("TransparencyLayerLight") : Color("TransparencyLayerDark"))
              .frame(width: Constants.TransparencyLayerSquareDimension, height: Constants.TransparencyLayerSquareDimension)
          }
        }
      }
    }
    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
  }
}

struct TransparencyLayer_Previews: PreviewProvider {
  static var previews: some View {
    TransparencyLayer()
  }
}
