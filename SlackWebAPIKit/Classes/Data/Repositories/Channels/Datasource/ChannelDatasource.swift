import Foundation
import RxSwift
import ObjectMapper

enum ChannelDatasourceError: Error {
    case channelNotFound
    case invalidJSON
    case listIsEmpty
}

protocol ChannelDatasourceProtocol: class {
    func list() -> Observable<[ChannelDataModel]>
    func find(channel: String) -> Observable<ChannelDataModel>
}

class ChannelDatasource: ChannelDatasourceProtocol {
    
    fileprivate let apiClient: APIClientProtocol
    fileprivate let endpoint: Endpoint
    
    init(apiClient: APIClientProtocol = APIClient(), endpoint: Endpoint = ChannelsListEndpoint()) {
        self.apiClient = apiClient
        self.endpoint = endpoint
    }
    
    func find(channel: String) -> Observable<ChannelDataModel> {
        return apiClient.execute(withURL: endpoint.url).flatMap { (json) -> Observable<ChannelDataModel> in
            guard let JSONChannels = json["channels"] as? [[String: Any]],
                let channels = Mapper<ChannelDataModel>().mapArray(JSONObject: JSONChannels) else {
                return Observable.error(ChannelDatasourceError.invalidJSON)
            }
            guard let channelFound = channels.filter({ $0.name == channel }).first else {
                return Observable.error(ChannelDatasourceError.channelNotFound)
            }
            return Observable.just(channelFound)
        }
    }
    
    func list() -> Observable<[ChannelDataModel]> {
        return apiClient.execute(withURL: endpoint.url).flatMap { (json) -> Observable<[ChannelDataModel]> in
            guard let JSONChannels = json["channels"] as? [[String: Any]],
                let channels = Mapper<ChannelDataModel>().mapArray(JSONObject: JSONChannels) else {
                return Observable.error(ChannelDatasourceError.invalidJSON)
            }
            if channels.isEmpty { return Observable.error(ChannelDatasourceError.listIsEmpty) }
            return Observable.from(optional: channels)
        }
    }
}
