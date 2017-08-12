import Foundation
import RxSwift

protocol ChannelsListUseCaseProtocol: class {
    func execute() -> Observable<[Channel]>
}

class ChannelsListUseCase: ChannelsListUseCaseProtocol {
    private let repository: ChannelRepositoryProtocol
    
    init(repository: ChannelRepositoryProtocol = ChannelRepository()) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Channel]> {
        return repository.list()
    }
}
