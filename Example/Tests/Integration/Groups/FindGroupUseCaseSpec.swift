import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindGroupUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.find.group.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindGroupUseCase.self)) Spec") {
            context("check find user use case") {
                
                var sut: FindGroupUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = GroupDatasource(apiClient: mockAPIClient)
                let repository = GroupRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = FindGroupUseCase(repository: repository)
                }
                
                it("group is found") {
                    sut.execute(group: "secret").subscribe(onNext: { group in
                        expect(group.id).to(equal("G6LCS6LTU"))
                        expect(group.name).to(equal("secret"))
                        expect(group.numMembers).to(beNil())
                        expect(group.topic?.value).to(equal(""))
                    }).addDisposableTo(disposeBag)
                }
                
                it("group is NOT found") {
                    sut.execute(group: "channel-five").subscribe(onError: { error in
                        expect(error as? GroupDatasourceError).to(equal(GroupDatasourceError.groupNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}

