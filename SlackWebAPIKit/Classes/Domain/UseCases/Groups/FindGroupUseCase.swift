import Foundation
import RxSwift

protocol FindGroupUseCaseProtocol: class {
    func execute(group: String) -> Observable<Group>
}

class FindGroupUseCase: FindGroupUseCaseProtocol {
    private let repository: GroupRepositoryProtocol
    
    init(repository: GroupRepositoryProtocol = GroupRepository()) {
        self.repository = repository
    }
    
    func execute(group: String) -> Observable<Group> {
        return repository.find(group: group)
    }
}
