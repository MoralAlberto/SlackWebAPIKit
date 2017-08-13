import Quick
import Nimble
import Alamofire
import RxSwift
@testable import SlackWebAPIKit

class ChannelsListUseCaseSpec: QuickSpec {
    
    class MockAPIClient: APIClientProtocol {
        func execute(withURL url: URL?) -> Observable<[String: Any]> {
            let json = readJSON(name: "apiclient.list.channels.succeed") as? [String: Any]
            return Observable.from(optional: json)
        }
    }
    
    override func spec() {
        describe("\(String(describing: ChannelsListUseCase.self)) Spec") {
            context("list channels use case") {
                
                var sut: ChannelsListUseCaseProtocol!
                let mockAPIClient = MockAPIClient()
                let remoteDatasource = ChannelDatasource(apiClient: mockAPIClient)
                let repository = ChannelRepository(remoteDatasource: remoteDatasource)
                let disposeBag = DisposeBag()
                
                beforeEach {
                    sut = ChannelsListUseCase(repository: repository)
                }
                
                it("retrieve the correct number of channels") {
                    sut.execute().subscribe(onNext: { channels in
                        expect(channels.count).to(equal(5))
                    }).addDisposableTo(disposeBag)
                }
                
                it("the list is empty") {
                    sut.execute().subscribe(onError: { error in
                        expect(error as? ChannelDatasourceError).to(equal(ChannelDatasourceError.listIsEmpty))
                    }).addDisposableTo(disposeBag)
                }
            }
        }
    }
}
