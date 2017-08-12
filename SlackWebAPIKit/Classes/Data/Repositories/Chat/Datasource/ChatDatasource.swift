import Foundation
import RxSwift

protocol ChatDatasourceProtocol: class {
    func postMessage(text: String, channel: String) -> Observable<Bool>
}

class ChatDatasource: ChatDatasourceProtocol {
    
    fileprivate let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol = APIClient()) {
        self.apiClient = apiClient
    }
    
    func postMessage(text: String, channel: String) -> Observable<Bool> {
        let postMessage = PostMessageEndpoint(text: text, channel: channel)
        return apiClient.execute(withURL: postMessage.url).flatMap { _ -> Observable<Bool> in
            return Observable.just(true)
        }
    }
}
