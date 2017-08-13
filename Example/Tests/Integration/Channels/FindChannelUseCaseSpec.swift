import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class FindChannelUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.find.channel.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: FindChannelUseCase.self)) Spec") {
            context("check find user use case") {
                
                var sut: FindChannelUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = ChannelDatasource(apiClient: mockAPIClient)
                let repository = ChannelRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = FindChannelUseCase(repository: repository)
                }
                
                it("channel is found") {
                    sut.execute(channel: "general").subscribe(onNext: { channel in
                        expect(channel.id).to(equal("C6G3ZN7MX"))
                        expect(channel.name).to(equal("general"))
                        expect(channel.numMembers).to(beNil())
                        expect(channel.topic?.value).to(equal("Company-wide announcements and work-based matters"))
                    }).addDisposableTo(disposeBag)
                }
                
                it("channel is NOT found") {
                    sut.execute(channel: "generaal").subscribe(onError: { error in
                        expect(error as? ChannelDatasourceError).to(equal(ChannelDatasourceError.channelNotFound))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}

