import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindUserUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.find.user.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindUserUseCase.self)) Spec") {
            context("find user") {
                
                var sut: FindUserUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = UserDatasource(apiClient: mockAPIClient)
                let repository = UserRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = FindUserUseCase(repository: repository)
                }
                
                it("user is found") {
                    sut.execute(user: "alberto").subscribe(onNext: { user in
                        expect(user.id).to(equal("U6HGG4S94"))
                        expect(user.name).to(equal("alberto"))
                        expect(user.realName).to(equal("Alberto Moral"))
                        expect(user.profileImage).to(equal("https://secure.gravatar.com/avatar/83d68bb2865a41a9918d018ddb4d9c54.jpg?s=48&d=https%3A%2F%2Fa.slack-edge.com%2F66f9%2Fimg%2Favatars%2Fava_0013-48.png"))
                    }).addDisposableTo(disposeBag)
                }
                
                it("user is NOT found") {
                    sut.execute(user: "albertoo").subscribe(onError: { error in
                        expect(error as? UserDatasourceError).to(equal(UserDatasourceError.userNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}

