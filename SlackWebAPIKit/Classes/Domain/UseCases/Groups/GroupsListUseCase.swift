import Foundation
import RxSwift

protocol GroupsListUseCaseProtocol: class {
    func execute() -> Observable<[Group]>
}

class GroupsListUseCase: GroupsListUseCaseProtocol {
    private let repository: GroupRepositoryProtocol
    
    init(repository: GroupRepositoryProtocol = GroupRepository()) {
        self.repository = repository
    }
    
    func execute() -> Observable<[Group]> {
        return repository.list()
    }
}
