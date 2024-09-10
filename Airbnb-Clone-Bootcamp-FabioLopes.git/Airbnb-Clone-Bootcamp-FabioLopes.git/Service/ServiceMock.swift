//
//  ServiceMock.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 05/09/24.
//

import Foundation

struct ServiceMock {

  //  DispatchQueue.global(qos: .userInitiated): Cria ou acessa uma fila global para execução de tarefas assíncronas. O parâmetro qos: .userInitiated define o Quality of Service (QoS) da fila, que indica a prioridade da tarefa.
  //  O QoS .userInitiated é utilizado para tarefas que são iniciadas pelo usuário e que ele espera ver o resultado rapidamente, como carregar dados após uma interação na interface. O sistema vai dar uma prioridade alta para essa tarefa.

  static func loadJSON<T: Decodable>(fileName: String, type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
    DispatchQueue.global(qos: .userInitiated).async {
      guard let url = Bundle.main.url(forResource: fileName, withExtension: "json") else {
        DispatchQueue.main.async {
          completion(.failure(NSError(domain: "falha ao encontrar o arquivo", code: -1)))
        }
        return
      }

      do {
        let data = try Data(contentsOf: url)
        let object = try JSONDecoder().decode(T.self, from: data)
        DispatchQueue.main.async {
          completion(.success(object))
        }
      } catch {
        DispatchQueue.main.async {
          completion(.failure(error))
        }
      }
    }
  }
}

