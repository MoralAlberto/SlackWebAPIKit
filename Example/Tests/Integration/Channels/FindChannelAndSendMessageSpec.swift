import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindChannelAndSendMessageSpec: QuickSpec {
    
    class MockChannelAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.channels.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    class MockChatAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.postmessage.channel.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindChannelAndPostMessageUseCase.self)) Spec") {
            context("list user use case") {
                
                var sut: FindChannelAndPostMessageUseCaseProtocol!
                let mockChannelAPIClient = MockChannelAPIClient()
                let mockChatAPIClient = MockChatAPIClient()
                let channelRemoteDatasource = ChannelDatasource(apiClient: mockChannelAPIClient)
                let chatRemoteDatasource = ChatDatasource(apiClient: mockChatAPIClient)
                let channelRepository = ChannelRepository(remoteDatasource: channelRemoteDatasource)
                let chatRepository = ChatRepository(remoteDatasource: chatRemoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    let findChannelUseCase = FindChannelUseCase(repository: channelRepository)
                    let postMessageUseCase = PostMessageUseCase(repository: chatRepository)
                    sut = FindChannelAndPostMessageUseCase(findChannelUseCase: findChannelUseCase, postMessageUseCase: postMessageUseCase)
                }
                
                it("send message") {
                    sut.execute(text: "Hello", channel: "general").subscribe(onNext: { isSent in
                        expect(isSent).to(equal(true))
                    }).addDisposableTo(disposeBag)
                }
                
                it("channel NOT found") {
                    sut.execute(text: "Hello", channel: "generaal").subscribe(onError: { error in
                        expect(error as? ChannelDatasourceError).to(equal(ChannelDatasourceError.channelNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
