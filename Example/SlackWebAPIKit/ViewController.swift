import UIKit
import RxSwift
import SlackWebAPIKit

class ViewController: UIViewController {

    var postUserMessageUseCase: FindUserAndPostMessageUseCase?
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        postUserMessageUseCase = FindUserAndPostMessageUseCase()
        postUserMessageUseCase?.execute(text: "Test", user: "alberto")
            .subscribe(onNext: { (isSent) in
                print("onNext \(isSent)")
            }, onError: { (error) in
                print("onError \(error)")
            }, onCompleted: {
                print("onComplete")
        }).addDisposableTo(disposeBag)
    }
}
