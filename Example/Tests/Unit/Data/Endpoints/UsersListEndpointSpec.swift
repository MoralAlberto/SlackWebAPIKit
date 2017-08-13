import Quick
import Nimble
@testable import SlackWebAPIKit

class UsersListEndpointSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: UsersListEndpoint.self)) Spec") {
            context("check endpoint") {
                
                let sut = UsersListEndpoint()
                
                it("has the correct enpoint type") {
                    expect(sut.endpointType).to(equal(EndpointType.usersList))
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
