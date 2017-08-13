import Quick
import Nimble
@testable import SlackWebAPIKit

class PostMessageEndpointSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: PostMessageEndpoint.self)) Spec") {
            context("check endpoint") {
                
                let sut = PostMessageEndpoint(text: "new message", channel: "general")
                
                it("has the correct enpoint type") {
                    expect(sut.endpointType).to(equal(EndpointType.postMessage))
                }
                
                it("has the correct numnber of parameters") {
                    expect(sut.parameters?.count).to(equal(3))
                }
                
                it("contains the correct parameters") {
                    expect(sut.parameters?["text"]).to(equal("new message"))
                    expect(sut.parameters?["channel"]).to(equal("general"))
                    expect(sut.parameters?["as_user"]).to(equal(String(describing: "true")))
                }
            }
        }
    }
}
