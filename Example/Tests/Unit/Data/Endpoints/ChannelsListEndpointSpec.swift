import Quick
import Nimble
@testable import SlackWebAPIKit

class ChannelsListEndpointSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: ChannelsListEndpoint.self)) Spec") {
            context("check endpoint") {
                
                let sut = ChannelsListEndpoint()
                
                it("has the correct enpoint type") {
                    expect(sut.endpointType).to(equal(EndpointType.channelsList))
                }
                
                it("has the correct numnber of parameters") {
                    expect(sut.parameters?.count).to(beNil())
                }
                
                it("contains the correct parameters") {
                    expect(sut.parameters).to(beNil())
                }
            }
        }
    }
}
