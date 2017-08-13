import Foundation
@testable import SlackWebAPIKit

class KeyClass {}

func readJSON(name: String) -> AnyObject? {
    let bundle = Bundle(for: KeyClass.self)
    
    let url = bundle.url(forResource: name, withExtension: "json")!
    let data = NSData(contentsOf: url)
    let jsonResult = try? JSONSerialization.jsonObject(with: data! as Data, options: []) as AnyObject
    
    return jsonResult
}
