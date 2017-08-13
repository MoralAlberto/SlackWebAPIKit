import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindGroupAndSendMessageSpec: QuickSpec {
    
    class MockGroupAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.groups.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    class MockChatAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.postmessage.group.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindGroupAndPostMessageUseCase.self)) Spec") {
            context("list user use case") {
                
                var sut: FindGroupAndPostMessageUseCaseProtocol!
                let mockGroupAPIClient = MockGroupAPIClient()
                let mockChatAPIClient = MockChatAPIClient()
                let groupRemoteDatasource = GroupDatasource(apiClient: mockGroupAPIClient)
                let chatRemoteDatasource = ChatDatasource(apiClient: mockChatAPIClient)
                let groupRepository = GroupRepository(remoteDatasource: groupRemoteDatasource)
                let chatRepository = ChatRepository(remoteDatasource: chatRemoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    let findGroupUseCase = FindGroupUseCase(repository: groupRepository)
                    let postMessageUseCase = PostMessageUseCase(repository: chatRepository)
                    sut = FindGroupAndPostMessageUseCase(findGroupUseCase: findGroupUseCase, postMessageUseCase: postMessageUseCase)
                }
                
                it("send message") {
                    sut.execute(text: "Hello", group: "secret").subscribe(onNext: { isSent in
                        expect(isSent).to(equal(true))
                    }).addDisposableTo(disposeBag)
                }
                
                it("group NOT found") {
                    sut.execute(text: "Hello", group: "channel-five").subscribe(onError: { error in
                        expect(error as? GroupDatasourceError).to(equal(GroupDatasourceError.groupNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
