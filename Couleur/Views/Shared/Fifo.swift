//
//  Fifo.swift
//  Couleur
//
//  Created by HiDeo on 23/09/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Foundation

struct Fifo<T: Codable>: Codable {
  var values: [T] {
    elements
  }

  var count: Int {
    elements.count
  }

  var isEmpty: Bool {
    count == 0
  }

  private var maxSize: Int
  private var elements: [T] = []

  init(maxSize: Int) {
    self.maxSize = maxSize
  }

  mutating func append(_ element: T) {
    if elements.count >= maxSize {
      elements.removeLast()
    }

    elements.insert(element, at: 0)
  }

  mutating func removeAll() {
    elements.removeAll()
  }
}
