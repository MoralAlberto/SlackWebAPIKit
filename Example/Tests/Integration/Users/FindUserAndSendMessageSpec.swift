import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindUserAndSendMessageSpec: QuickSpec {
    
    class MockUserAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.users.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    class MockChatAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.postmessage.user.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindUserAndPostMessageUseCase.self)) Spec") {
            context("find a send message to user") {
                
                var sut: FindUserAndPostMessageUseCaseProtocol!
                let mockUserAPIClient = MockUserAPIClient()
                let mockChatAPIClient = MockChatAPIClient()
                let userRemoteDatasource = UserDatasource(apiClient: mockUserAPIClient)
                let chatRemoteDatasource = ChatDatasource(apiClient: mockChatAPIClient)
                let userRepository = UserRepository(remoteDatasource: userRemoteDatasource)
                let chatRepository = ChatRepository(remoteDatasource: chatRemoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    let findUserUseCase = FindUserUseCase(repository: userRepository)
                    let postMessageUseCase = PostMessageUseCase(repository: chatRepository)
                    sut = FindUserAndPostMessageUseCase(findUserUseCase: findUserUseCase, postMessageUseCase: postMessageUseCase)
                }
                
                it("send message") {
                    sut.execute(text: "Hello", user: "alberto").subscribe(onNext: { isSent in
                        expect(isSent).to(equal(true))
                    }).addDisposableTo(disposeBag)
                }
                
                it("user NOT found") {
                    sut.execute(text: "Hello", user: "albertoo").subscribe(onError: { error in
                        expect(error as? UserDatasourceError).to(equal(UserDatasourceError.userNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
