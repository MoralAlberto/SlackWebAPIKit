import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class GroupsListUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.groups.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: GroupsListUseCase.self)) Spec") {
            context("list groups use case") {
                
                var sut: GroupsListUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = GroupDatasource(apiClient: mockAPIClient)
                let repository = GroupRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = GroupsListUseCase(repository: repository)
                }
                
                it("retrieve the correct number of groups") {
                    sut.execute().subscribe(onNext: { groups in
                        expect(groups.count).to(equal(1))
                    }).addDisposableTo(disposeBag)
                }
                
                it("the list is empty") {
                    sut.execute().subscribe(onError: { error in
                        expect(error as? GroupDatasourceError).to(equal(GroupDatasourceError.listIsEmpty))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
