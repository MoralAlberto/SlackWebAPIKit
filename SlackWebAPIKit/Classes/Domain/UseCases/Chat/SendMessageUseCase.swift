import Foundation
import RxSwift

protocol PostMessageUseCaseProtocol {
    func execute(text: String, channel: String) -> Observable<Bool>
}

class PostMessageUseCase: PostMessageUseCaseProtocol {
    private let repository: ChatRepositoryProtocol
    
    init(repository: ChatRepositoryProtocol = ChatRepository()) {
        self.repository = repository
    }

    func execute(text: String, channel: String) -> Observable<Bool> {
        return repository.postMessage(text: text, channel: channel)
    }
}
