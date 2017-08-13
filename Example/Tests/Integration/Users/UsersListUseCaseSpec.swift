import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class UsersListUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.users.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: UsersListUseCase.self)) Spec") {
            context("list user use case") {
                
                var sut: UsersListUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = UserDatasource(apiClient: mockAPIClient)
                let repository = UserRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = UsersListUseCase(repository: repository)
                }
                
                it("retrieve the exact number of users") {
                    sut.execute().subscribe(onNext: { users in
                        expect(users.count).to(equal(2))
                    }).addDisposableTo(disposeBag)
                }
                
                it("the list is empty") {
                    sut.execute().subscribe(onError: { error in
                        expect(error as? UserDatasourceError).to(equal(UserDatasourceError.listIsEmpty))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
