//
//  FirebaseFirestoreManager.swift
//  Airbnb-Clone-Bootcamp-FabioLopes.git
//
//  Created by Fabio Cristiano Lopes on 07/10/24.
//

import FirebaseFirestore
import FirebaseAuth


class FirestoreManager {

  static let shared = FirestoreManager()
  private let firestore = Firestore.firestore()

  private var currentUserID: String? {
    Auth.auth().currentUser?.uid
  }

  private init() { }

  func createUserWithEmailAndPassword(email: String, password: String, name: String, completion: @escaping (Result<Void, Error>) -> Void) {
    Auth.auth().createUser(withEmail: email, password: password) {
      result,
      error in
      if let error {
        completion(.failure(error))
      }

      guard let userID = result?.user.uid else {
        let error = NSError(domain: "Error ao acessar uid", code: 500)
        completion(.failure(error))
        return
      }

      let userDocument = self.firestore.collection("main").document("user").collection(userID).document("userData")

      let user = User(id: userID,
                      email: email,
                      name: name,
                      userImage: "",
                      favorite: [])

      do {
        try userDocument.setData(from: user)
        completion(.success(()))
      } catch {
        completion(.failure(error))
      }
    }
  }

  func getUserData(completion: @escaping (Result<User, Error>) -> Void) {
    getUserDocument { result in
      switch result {
      case .success(let document):
        do {
          let user = try document.data(as: User.self)
          completion(.success(user))
        } catch {
          completion(.failure(error))
        }
      case .failure(_):
        print("Deu ruim emm!")
      }
    }
  }

  private func getUserDocument(completion: @escaping (Result<DocumentSnapshot, Error>) -> Void) {
    guard let currentUserID else {
      let error = NSError(domain: "Error ao acessar uid", code: 500)
      completion(.failure(error))
      return
    }

    let userDocument = self.firestore.collection("main").document("user").collection(currentUserID).document("userData")

    userDocument.getDocument { document, error in
      if let error {
        completion(.failure(error))
      } else if let document, document.exists {
        completion(.success(document))
      } else {
        let error = NSError(domain: "Error, userData não encontrado", code: 500)
        completion(.failure(error))
      }
    }
  }

  func saveJsonDataOnFirebase() {
    // Primeira coisa é verificar se já existe os dados no firebase
    getPlaceFromFirebase { result in
      switch result {
      case .success(let places):
        print(places)
        print("Já existe os dados no firebase")
      case .failure(_):
        self.fetchPropertiesListMock { result in
          switch result {
          case .success(let properties):
            self.saveJsonDataOnFirebase(properties: properties)
          case .failure(_):
            print("Erro ao buscar os dados")
          }
        }
      }
    }
  }

  func saveJsonDataOnFirebase(properties: [PropertyDataModel]) {
    let placesData = properties.compactMap({ try? Firestore.Encoder().encode($0) })
    firestore.collection("main").document("places").setData(["placesList": placesData]) { error in
      if let error {
        print("Error saving data: \(error)")
      } else {
        print("Data saved successfully!")
      }
    }
  }

  func getPlaceFromFirebase(completion: @escaping (Result<[PropertyDataModel],Error>) -> Void) {
    let documentRef = firestore.collection("main").document("places")

    documentRef.getDocument { document, error in

      if let error {
        completion(.failure(error))
      }

      guard let document, document.exists,
            let placesData = document.data()?["placesList"] as? [[String: Any]] else {
        let error = NSError(domain: "Error, placesList não encontrado", code: 500)
        completion(.failure(error))
        return
      }

      let places = placesData.compactMap({ return try? JSONDecoder().decode(PropertyDataModel.self, from: JSONSerialization.data(withJSONObject: $0))})

      if places.isEmpty {
        let error = NSError(domain: "Error, placesList está vazio", code: 500)
        completion(.failure(error))
      } else {
        completion(.success(places))
      }
    }
  }

  func fetchPropertiesListMock(completion: @escaping (Result<[PropertyDataModel],Error>) -> Void) {
    LocalFileReader.loadJSON(fileName: "place", type: [PropertyDataModel].self) { result in
      switch result {
      case .success(let properties):
        completion(.success(properties))
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }

  // Verificar se o meu place especifico é favorito!
  func isPropertyFavorite(id: Int, completion: @escaping (Bool) -> Void) {
    getUserDocument { result in
      switch result {
      case .success(let document):
        do {
          let userData = try document.data(as: User.self)
          let isFavorite = userData.favorite.contains(id)
          print("É favorito o id \(id): \(isFavorite)")
          completion(isFavorite)
        } catch {
          print("Deu error")
          completion(false)
        }
      case .failure:
        print("Deu error")
        completion(false)
      }
    }
  }

  // Adicionar/Remover favorito do BD
  func toggleFavoriteProperty(id: Int, completion: @escaping (Result<Void,Error>) -> Void) {
    getUserDocument { result in
      switch result {
      case .success(let document):
        do {
          var userData = try document.data(as: User.self)
          if let index = userData.favorite.firstIndex(of: id) {
            userData.favorite.remove(at: index)
          } else {
            userData.favorite.append(id)
          }
          try document.reference.setData(from: userData)

          completion(.success(()))
        } catch {
          completion(.failure(error))
        }
      case .failure(let error):
        completion(.failure(error))
      }
    }
  }


  // Listen -> receber qualquer alteração do objeto User.favorite

  func listenToFavoriteProprieties(completion: @escaping (Result<[PropertyDataModel],Error>) -> Void) -> ListenerRegistration? {
    guard let currentUserID else {
      let error = NSError(domain: "FirestoreManager", code: 1, userInfo: nil)
      completion(.failure(error))
      return nil
    }

    let userDocument = firestore.collection("main").document("user").collection(currentUserID).document("userData")
    return userDocument.addSnapshotListener { documentSnapshot, error in
      if let error {
        completion(.failure(error))
        return
      } else if let document = documentSnapshot, document.exists {
        do {
          let userData = try document.data(as: User.self)
          self.getPlaceFromFirebase { result in
            switch result {
            case .success(let allPlaces):
              let listFavorite = allPlaces.filter({ userData.favorite.contains($0.id)})
              return completion(.success(listFavorite))
            case .failure(let error):
              completion(.failure(error))
              return
            }
          }
        } catch {
          completion(.failure(error))
          return
        }
      } else {
        let error = NSError(domain: "FirestoreManager", code: 1, userInfo: nil)
        completion(.failure(error))
        return
      }
    }
  }
}

