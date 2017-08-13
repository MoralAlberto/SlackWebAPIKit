import Quick
import Nimble
import Alamofire
@testable import SlackWebAPIKit

class AccessTokenAdapterSpec: QuickSpec {
    override func spec() {
        describe("\(String(describing: AccessTokenAdapter.self)) Spec") {
            context("check request interceptor") {
                
                let sut = AccessTokenAdapter(accessToken: "1234567890")
                let sessionManager = SessionManager()
                
                beforeEach {
                    sessionManager.adapter = sut
                }
                
                it("a token is inserted in every request") {
                    let url = URL(string: "https://slack.com/api/")
                    let request = URLRequest(url: url!)
                    
                    let finalRequest = try! sessionManager.adapter!.adapt(request)
                    expect(finalRequest.url?.absoluteString).to(equal("https://slack.com/api/?token=1234567890"))
                }
            }
        }
    }
}

