import Foundation
import RxSwift

protocol GroupRepositoryProtocol {
    func list() -> Observable<[Group]>
    func find(group: String) -> Observable<Group>
}

class GroupRepository: GroupRepositoryProtocol {
    
    fileprivate let remoteDatasource: GroupDatasourceProtocol
    
    init(remoteDatasource: GroupDatasourceProtocol = GroupDatasource()) {
        self.remoteDatasource = remoteDatasource
    }
    
    func list() -> Observable<[Group]> {
        return remoteDatasource.list().map { $0.map { $0.toModel() } }
    }
    
    func find(group: String) -> Observable<Group> {
        return remoteDatasource.find(group: group).map { $0.toModel() }
    }
}
