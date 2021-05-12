import UIKit
import SegementSlide
import ImpressiveNotifications

//ニュース記事一覧画面


class HomeViewController: SegementSlideDefaultViewController {
    
    var titleInSwitcherModel = TitleInSwitcherModel()

    var urlModel = URLModel()
    
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
        return titleInSwitcherModel.words
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
        let homeVCword = titleInSwitcherModel.words[index]
        
        //homeVCUrlStringがnilの場合、defaultUrlを返す
        guard let homeVCUrlString = urlModel.getURLString(word: homeVCword) else {
            return NewsPageViewController(urlString: urlModel.defaultUrl)
        }
        
        return NewsPageViewController(urlString: homeVCUrlString)
        
    }

}
