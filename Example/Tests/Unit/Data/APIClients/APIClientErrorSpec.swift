import Quick
import Nimble
import Alamofire
@testable import SlackWebAPIKit

class APIClientErrorSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: APIClientError.self)) Spec") {
            context("check API errors") {
                
                it("channel is NOT found") {
                    let error = APIClientError(type: "channel_not_found")
                    expect(error).toNot(beNil())
                }
            }
        }
    }
}
