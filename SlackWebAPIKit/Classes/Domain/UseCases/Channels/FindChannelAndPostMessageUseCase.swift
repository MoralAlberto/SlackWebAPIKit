import Foundation
import RxSwift

protocol FindChannelAndPostMessageUseCaseProtocol: class {
    func execute(text: String, channel: String) -> Observable<Bool>
}

class FindChannelAndPostMessageUseCase: FindChannelAndPostMessageUseCaseProtocol {
    let findChannelUseCase: FindChannelUseCaseProtocol
    let postMessageUseCase: PostMessageUseCaseProtocol
    
    init(findChannelUseCase: FindChannelUseCaseProtocol = FindChannelUseCase(),
         postMessageUseCase: PostMessageUseCaseProtocol = PostMessageUseCase()) {
        self.findChannelUseCase = findChannelUseCase
        self.postMessageUseCase = postMessageUseCase
    }
    
    func execute(text: String, channel: String) -> Observable<Bool> {
        return findChannelUseCase.execute(channel: channel).flatMap { [weak self] foundChannel -> Observable<Bool> in
            guard let strongSelf = self,
                let channelId = foundChannel.id
                else {
                    return Observable.just(false)
            }
            return strongSelf.postMessageUseCase.execute(text: text, channel: channelId)
        }
    }
}
