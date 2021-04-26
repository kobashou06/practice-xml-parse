import UIKit
import SegementSlide
import ImpressiveNotifications

//ニュース記事一覧画面


class BaseViewController: SegementSlideDefaultViewController {

    let words = ["Swift","CocoaPods","Carthage","Xcode","SwiftUI","アーキテクチャ"]
    
    override func viewDidLoad() {

        super.viewDidLoad()

        reloadData()

        defaultSelectedIndex = 0
        
        //ImpressiveNotificationsを使って、通知を出してみる（ログイン成功を伝える）
        INNotifications.show(type: .success,data: INNotificationData(title: "Success",
                                                                     description: "Login was successful!",
                                                                     image: nil,
                                                                     delay: 2.0,
                                                                     completionHandler: {print("Login was successful")})
        )

    }

    
    override func segementSlideHeaderView() -> UIView {

        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let headerHeight: CGFloat

        if #available(iOS 11.0, *) {

            headerHeight = view.bounds.height/4+view.safeAreaInsets.top

        } else {

            headerHeight = view.bounds.height/4+topLayoutGuide.length

        }

        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

        return headerView

    }

    override var titlesInSwitcher: [String] {
        return words
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {

        let urlString:String

        switch index {

        case 0:
            urlString = "https://qiita.com/api/v2/items?query=\(words[0])"

        case 1:
            urlString = "https://qiita.com/api/v2/items?query=\(words[1])"

        case 2:
            urlString = "https://qiita.com/api/v2/items?query=\(words[2])"

        case 3:
            urlString = "https://qiita.com/api/v2/items?query=\(words[3])"

        case 4:
            urlString = "https://qiita.com/api/v2/items?query=\(words[4])"

        case 5:
            urlString = "https://qiita.com/api/v2/items?query=\(words[5])"

        default:
            urlString = "https://qiita.com/api/v2/items?query=\(words[0])"

        }

        return NewsPageViewController(urlString: urlString)

    }

}
