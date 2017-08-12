import Foundation
import ObjectMapper

class TopicDataModel: Mappable {
    var value: String?
    var creator: String?
    var lastSet: Int?
    
    required init?(map: Map) { }
    
    // Mappable
    func mapping(map: Map) {
        value     <- map["value"]
        creator     <- map["creator"]
        lastSet     <- map["lastSet"]
    }
}
