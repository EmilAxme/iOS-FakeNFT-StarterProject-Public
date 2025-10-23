import Foundation

typealias NftCompletion = (Result<Nft, Error>) -> Void

protocol NftService {
    func loadNft(id: String, completion: @escaping NftCompletion)
}

final class NftServiceImpl: NftService {

    private let networkClient: NetworkClient
    private let storage: NftStorage

    init(networkClient: NetworkClient, storage: NftStorage) {
        self.storage = storage
        self.networkClient = networkClient
    }

    func loadNft(id: String, completion: @escaping NftCompletion) {
        if let nft = storage.getNft(with: id) {
            completion(.success(nft))
            return
        }

        let request = NFTRequest(id: id)
        networkClient.send(request: request, type: Nft.self) { [weak storage] result in
            switch result {
            case .success(let nft):
                storage?.saveNft(nft)
                completion(.success(nft))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

extension NftServiceImpl {
    func loadNfts(ids: [String], completion: @escaping (Result<[Nft], Error>) -> Void) {
        var result: [Nft] = []
        var lastError: Error?
        let group = DispatchGroup()
        
        for id in ids {
            group.enter()
            loadNft(id: id) { nftResult in
                switch nftResult {
                case .success(let nft):
                    result.append(nft)
                case .failure(let error):
                    lastError = error
                }
                group.leave()
            }
        }
        
        group.notify(queue: .main) {
            if let error = lastError, result.isEmpty {
                completion(.failure(error))
            } else {
                completion(.success(result))
            }
        }
    }
}
