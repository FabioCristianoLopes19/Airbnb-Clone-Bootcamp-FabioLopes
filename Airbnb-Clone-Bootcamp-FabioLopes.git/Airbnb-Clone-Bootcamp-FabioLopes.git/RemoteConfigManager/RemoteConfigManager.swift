//
//  RemoteConfigManager.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/10/24.
//

import FirebaseRemoteConfig

class RemoteConfigManager {

  static let shared = RemoteConfigManager()

  private let remoteConfig: RemoteConfig = RemoteConfig.remoteConfig()

  private init() {
    let setting = RemoteConfigSettings()
    setting.minimumFetchInterval = 0
    remoteConfig.configSettings = setting
  }

  func fetchRemoteConfig(completion: @escaping (Bool) -> Void) {
    remoteConfig.fetch { result, error in
      if result == .success {
        self.remoteConfig.activate { _, _ in
          completion(true)
        }
      } else {
        print("Falha em buscar o remote config")
        completion(false)
      }
    }
  }

  // MARK: - Get Remote Config Values

  func getStringValue(key: String) -> String {
    return remoteConfig[key].stringValue
  }

  func getNumberValue(key: String) -> Double {
    return remoteConfig[key].numberValue.doubleValue
  }

  func getBoolValue(key: String) -> Bool {
    return remoteConfig[key].boolValue
  }

  func getJSONValue(key: String) -> [String: Any]? {
    let jsonString = remoteConfig[key].stringValue
    if let data = jsonString.data(using: .utf8) {
      do {
        return try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any]
      } catch {
        print("Error ao converter JSON: \(error.localizedDescription)")
        return nil
      }
    } else {
      return nil
    }
  }
}
