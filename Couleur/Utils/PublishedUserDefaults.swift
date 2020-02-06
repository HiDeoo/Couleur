//
//  PublishedUserDefaults.swift
//  Couleur
//
//  Created by HiDeo on 06/02/2020.
//  Copyright © 2020 HiDeoo. All rights reserved.
//

import Combine
import Foundation

private var publishedCancellables = [String: AnyCancellable]()

extension Published where Value: Codable {
  init(wrappedValue defaultValue: Value, forUserDefaultsKey key: String) {
    if let data = UserDefaults.standard.data(forKey: key) {
      do {
        let value = try JSONDecoder().decode(Value.self, from: data)
        self.init(initialValue: value)
      } catch {
        self.init(initialValue: defaultValue)
      }
    } else {
      self.init(initialValue: defaultValue)
    }

    publishedCancellables[key] = projectedValue.sink { value in
      let data = try? JSONEncoder().encode(value)

      UserDefaults.standard.set(data, forKey: key)
    }
  }
}
