import UIKit
import NaverThirdPartyLogin
import Alamofire

class ViewController: UIViewController, NaverThirdPartyLoginConnectionDelegate {
    
    let naverLoginInstance = NaverThirdPartyLoginConnection.getSharedInstance()
    @IBOutlet weak var naverLoginButton: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        naverLoginInstance?.delegate = self
    }
    
    @IBAction func naverLoginButtonTapped(_ sender: Any) {
        naverLoginInstance?.requestThirdPartyLogin()
    }
    
    // MARK: Naver Login Function
    func oauth20ConnectionDidFinishRequestACTokenWithAuthCode() {
        getUserData()
        print("LOGIN SUCCESS")
        
        // completion -> 데이터 넘기는거 추가해야 함 !
        guard let mainVC = storyboard?.instantiateViewController(withIdentifier: "mainVC") as? MainViewController else { return }
        mainVC.modalPresentationStyle = .fullScreen
        present(mainVC, animated: true, completion: nil)
    }
    
    func oauth20ConnectionDidFinishRequestACTokenWithRefreshToken() {
        naverLoginInstance?.requestAccessTokenWithRefreshToken()
        naverLoginInstance?.accessToken
    }
    
    func oauth20ConnectionDidFinishDeleteToken() {
        naverLoginInstance?.requestDeleteToken()
    }
    
    func oauth20Connection(_ oauthConnection: NaverThirdPartyLoginConnection!, didFailWithError error: Error!) {
        print("error: \(error.localizedDescription)")
    }
    
    func getUserData() {
        guard let isValidAccessToken = naverLoginInstance?.isValidAccessTokenExpireTimeNow() else { return }
        
        if !isValidAccessToken {
            return
        }
        
        guard let tokenType = naverLoginInstance?.tokenType else { return }
        guard let accessToken = naverLoginInstance?.accessToken else { return }
        
        let urlStr = "https://openapi.naver.com/v1/nid/me"
        let url = URL(string: urlStr)!
        
        let authorization = "\(tokenType) \(accessToken)"
        
        let req = AF.request(url, method: .get, parameters: nil, encoding: JSONEncoding.default)
        
        req.responseJSON { response in
            guard let result = response.value as? [String: Any] else { return }
            guard let object = result["response"] as? [String: Any] else { return }
            guard let name = object["name"] as? String else { return }
            guard let email = object["email"] as? String else { return }
            guard let id = object["id"] as? String else {return}
        }
    }
}

