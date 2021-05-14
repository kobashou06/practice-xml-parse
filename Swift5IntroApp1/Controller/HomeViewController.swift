import UIKit
import SegementSlide
import ImpressiveNotifications

//ニュース記事一覧画面


class HomeViewController: SegementSlideDefaultViewController {
    
    //Change JSON Parse or XML Parse
    private var forChangeFlagSwitch = UISwitch()
    
    private var jsonParseFlag = true
    
    private var titleInSwitcherModel = TitleInSwitcherModel()

    private var urlModel = URLModel()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        view.addSubview(forChangeFlagSwitch)
        
        setupForChangeFlagSwitch()

        reloadData()

        defaultSelectedIndex = 0
        
        //ImpressiveNotificationsを使って、通知を出してみる（ログイン成功を伝える）
        INNotifications.show(type: .success,
                             data: INNotificationData(title: "Success",
                                                      image: nil,
                                                      delay: 2.0))

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        defaultSelectedIndex = 0
    }
    
    private func setupForChangeFlagSwitch() {
        //最前面に配置する
        view.bringSubviewToFront(forChangeFlagSwitch)
        
        //初期値はtrue
        forChangeFlagSwitch.setOn(true, animated: true)
        
        //操作時の関数割り当て
        forChangeFlagSwitch.addTarget(self, action: #selector(jsonParseFlagSwitch(sender:)), for: UIControl.Event.valueChanged)
        
        //AutoLayoutの設定
        forChangeFlagSwitch.translatesAutoresizingMaskIntoConstraints = false
        forChangeFlagSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: view.bounds.size.height / 6).isActive = true
        forChangeFlagSwitch.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        forChangeFlagSwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
    }
    
    override func segementSlideHeaderView() -> UIView {

        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true
        headerView.contentMode = .scaleToFill
        headerView.image = UIImage(named: "header")
        headerView.translatesAutoresizingMaskIntoConstraints = false

        let headerHeight: CGFloat

        if #available(iOS 11.0, *) {

            headerHeight = view.bounds.height / 4 + view.safeAreaInsets.top

        } else {

            headerHeight = view.bounds.height / 4 + topLayoutGuide.length

        }

        headerView.heightAnchor.constraint(equalToConstant: headerHeight).isActive = true

        return headerView

    }

    override var titlesInSwitcher: [String] {
        return titleInSwitcherModel.getTitle(jsonParseFlag: jsonParseFlag)
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
 
        //nilの場合、defaultUrlを返す
        guard let homeVCUrlString = urlModel.getURLString(index: index, jsonParseFlag: jsonParseFlag) else {
            
            return NewsPageViewController(urlString: urlModel.defaultUrl, jsonParseFlag: jsonParseFlag)
            
        }
        
        return NewsPageViewController(urlString: homeVCUrlString, jsonParseFlag: jsonParseFlag)
        
    }
    
    @objc private func jsonParseFlagSwitch(sender: UISwitch) {
        
        //フラグの操作
        if sender.isOn {
            jsonParseFlag = true
        } else {
            jsonParseFlag = false
        }
        //フラグ変更後、画面をリロードする
        reloadData()
        defaultSelectedIndex = 0
    
    }

}
