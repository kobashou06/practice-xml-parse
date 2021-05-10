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

        var urlModel:URLModel

        switch index {

        case 0:
            urlModel = URLModel(word: self.words[0])
        case 1:
            urlModel = URLModel(word: self.words[1])
        case 2:
            urlModel = URLModel(word: self.words[2])
        case 3:
            urlModel = URLModel(word: self.words[3])
        case 4:
            urlModel = URLModel(word: self.words[4])
        case 5:
            urlModel = URLModel(word: self.words[5])
        default:
            urlModel = URLModel(word: self.words[0])
        }

        return NewsPageViewController(urlString: urlModel.url)

    }

}
