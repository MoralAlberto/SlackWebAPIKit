import Foundation
import RxSwift

protocol FindUserUseCaseProtocol: class {
    func execute(user: String) -> Observable<User>
}

class FindUserUseCase: FindUserUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func execute(user: String) -> Observable<User> {
        return repository.find(user: user)
    }
}
