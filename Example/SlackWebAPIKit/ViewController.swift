import UIKit
import SlackWebAPIKit

class ViewController: UIViewController {

    let postUserMessageUseCase = FindUserAndPostMessageUseCase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        _ = postUserMessageUseCase.execute(text: "Test", user: "alberto")
            .subscribe(onNext: { (isSent) in
                print("onNext \(isSent)")
            }, onError: { (error) in
                print("onError \(error)")
            }, onCompleted: {
                print("onComplete")
            })
    }
}

