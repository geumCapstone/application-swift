import UIKit
import NaverThirdPartyLogin

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let instance = NaverThirdPartyLoginConnection.getSharedInstance()
        
        // 네이버 앱 사용 인증 활성화
        instance?.isNaverAppOauthEnable = true
        
        // SafariViewController에서 인증 활성화
        instance?.isInAppOauthEnable = true
        
        // 세로화면 인증 활성화(세로화면에서만 가능하게끔 설정)
        instance?.isOnlyPortraitSupportedInIphone()
        
        instance?.serviceUrlScheme = kServiceAppUrlScheme // 네이버에 등록한 UrlScheme
        instance?.consumerKey = kConsumerKey // ClientId
        instance?.consumerSecret = kConsumerSecret // PW
        instance?.appName = kServiceAppName // APPLICATION NAME
        
        
        /** sleep 이용하여 didFinishLaunchingWithOptions 지연시킴, 로딩시간 3초 */
        sleep(3)

        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

