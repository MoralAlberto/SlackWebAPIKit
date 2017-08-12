import Foundation
import RxSwift

protocol ChannelRepositoryProtocol {
    func list() -> Observable<[Channel]>
    func find(channel: String) -> Observable<Channel>
}

class ChannelRepository: ChannelRepositoryProtocol {
    
    fileprivate let remoteDatasource: ChannelDatasourceProtocol
    
    init(remoteDatasource: ChannelDatasourceProtocol = ChannelDatasource()) {
        self.remoteDatasource = remoteDatasource
    }
    
    func list() -> Observable<[Channel]> {
        return remoteDatasource.list().map { $0.map { $0.toModel() } }
    }
    
    func find(channel: String) -> Observable<Channel> {
        return remoteDatasource.find(channel: channel).map { $0.toModel() }
    }
}
