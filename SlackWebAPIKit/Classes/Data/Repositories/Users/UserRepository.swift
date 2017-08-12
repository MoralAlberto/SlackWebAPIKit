import Foundation
import RxSwift

protocol UserRepositoryProtocol {
    func list() -> Observable<[User]>
    func find(user: String) -> Observable<User>
}

class UserRepository: UserRepositoryProtocol {
    
    fileprivate let remoteDatasource: UserDatasourceProtocol
    
    init(remoteDatasource: UserDatasourceProtocol = UserDatasource()) {
        self.remoteDatasource = remoteDatasource
    }
    
    func list() -> Observable<[User]> {
        return remoteDatasource.list().map { $0.map { $0.toModel() } }
    }
    
    func find(user: String) -> Observable<User> {
        return remoteDatasource.find(user: user).map { $0.toModel() }
    }
}
