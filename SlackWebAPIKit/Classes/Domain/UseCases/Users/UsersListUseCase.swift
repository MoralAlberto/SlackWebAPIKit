import Foundation
import RxSwift

protocol UsersListUseCaseProtocol: class {
    func execute() -> Observable<[User]>
}

class UsersListUseCase: UsersListUseCaseProtocol {
    private let repository: UserRepositoryProtocol
    
    init(repository: UserRepositoryProtocol = UserRepository()) {
        self.repository = repository
    }
    
    func execute() -> Observable<[User]> {
        return repository.list()
    }
}
