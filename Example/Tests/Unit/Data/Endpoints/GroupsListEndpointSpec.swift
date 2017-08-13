import Quick
import Nimble
@testable import SlackWebAPIKit

class GroupsListEndpointSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: GroupsListEndpoint.self)) Spec") {
            context("check endpoint") {
                
                let sut = GroupsListEndpoint()
                
                it("has the correct enpoint type") {
                    expect(sut.endpointType).to(equal(EndpointType.groupsList))
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
