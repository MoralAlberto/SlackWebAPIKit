import Foundation
import RxSwift

protocol FindGroupAndPostMessageUseCaseProtocol: class {
    func execute(text: String, group: String) -> Observable<Bool>
}

class FindGroupAndPostMessageUseCase: FindGroupAndPostMessageUseCaseProtocol {
    let findGroupUseCase: FindGroupUseCaseProtocol
    let postMessageUseCase: PostMessageUseCaseProtocol
    
    init(findGroupUseCase: FindGroupUseCaseProtocol = FindGroupUseCase(),
         postMessageUseCase: PostMessageUseCaseProtocol = PostMessageUseCase()) {
        self.findGroupUseCase = findGroupUseCase
        self.postMessageUseCase = postMessageUseCase
    }
    
    func execute(text: String, group: String) -> Observable<Bool> {
        return findGroupUseCase.execute(group: group).flatMap { [weak self] foundGroup -> Observable<Bool> in
            guard let strongSelf = self,
                let groupId = foundGroup.id
                else {
                    return Observable.just(false)
            }
            return strongSelf.postMessageUseCase.execute(text: text, channel: groupId)
        }
    }
}
