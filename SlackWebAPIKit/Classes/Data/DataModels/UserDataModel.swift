import Foundation
import ObjectMapper

class UserDataModel: Mappable {
    var id: String?
    var teamId: String?
    var name: String?
    var deleted: Bool?
    var color: String?
    var realName: String?
    var profileImage: String?
    
    required init?(map: Map) { }
    
    // Mappable
    func mapping(map: Map) {
        id           <- map["id"]
        teamId       <- map["team_id"]
        name         <- map["name"]
        deleted      <- map["deleted"]
        color        <- map["color"]
        realName     <- map["real_name"]
        profileImage <- map["profile.image_48"]
    }
}
