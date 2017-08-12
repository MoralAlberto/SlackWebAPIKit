import Foundation
import RxSwift

protocol FindChannelUseCaseProtocol {
    func execute(channel: String) -> Observable<Channel>
}

class FindChannelUseCase: FindChannelUseCaseProtocol {
    private let repository: ChannelRepositoryProtocol
    
    init(repository: ChannelRepositoryProtocol = ChannelRepository()) {
        self.repository = repository
    }
    
    func execute(channel: String) -> Observable<Channel> {
        return repository.find(channel: channel)
    }
}
