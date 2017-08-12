import Foundation
import RxSwift

protocol FindUserAndPostMessageUseCaseProtocol: class {
    func execute(text: String, user: String) -> Observable<Bool>
}

class FindUserAndPostMessageUseCase: FindUserAndPostMessageUseCaseProtocol {
    let findUserUseCase: FindUserUseCaseProtocol
    let postMessageUseCase: PostMessageUseCaseProtocol
    
    init(findUserUseCase: FindUserUseCaseProtocol = FindUserUseCase(),
         postMessageUseCase: PostMessageUseCaseProtocol = PostMessageUseCase()) {
        self.findUserUseCase = findUserUseCase
        self.postMessageUseCase = postMessageUseCase
    }
    
    func execute(text: String, user: String) -> Observable<Bool> {
        return findUserUseCase.execute(user: user).flatMap { [weak self] foundUser -> Observable<Bool> in
            guard let strongSelf = self,
                let userId = foundUser.id
                else {
                    return Observable.just(false)
            }
            return strongSelf.postMessageUseCase.execute(text: text, channel: userId)
        }
    }
}
