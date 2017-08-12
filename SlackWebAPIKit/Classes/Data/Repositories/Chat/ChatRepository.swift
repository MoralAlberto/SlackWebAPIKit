import Foundation
import RxSwift

protocol ChatRepositoryProtocol {
    func postMessage(text: String, channel: String) -> Observable<Bool>
}

class ChatRepository: ChatRepositoryProtocol {
    
    fileprivate let remoteDatasource: ChatDatasourceProtocol
    
    init(remoteDatasource: ChatDatasourceProtocol = ChatDatasource()) {
        self.remoteDatasource = remoteDatasource
    }
    
    func postMessage(text: String, channel: String) -> Observable<Bool> {
        return remoteDatasource.postMessage(text: text, channel: channel)
    }
}
