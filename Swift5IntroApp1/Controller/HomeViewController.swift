import UIKit
import SegementSlide
import ImpressiveNotifications

//ニュース記事一覧画面


class HomeViewController: SegementSlideDefaultViewController {
    
    //Change JSON Parse or XML Parse
    var forChangeFlgSwitch = UISwitch()
    
    private var jsonParseFlg: Bool = true
    
    private var titleInSwitcherModel = TitleInSwitcherModel()

    private var urlModel = URLModel()
    
    override func viewDidLoad() {

        super.viewDidLoad()
        
        view.addSubview(forChangeFlgSwitch)
        
        setupForChangeFlgSwitch()

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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        reloadData()
        defaultSelectedIndex = 0
    }
    
    private func setupForChangeFlgSwitch() {
        //最前面に配置する
        view.bringSubviewToFront(forChangeFlgSwitch)
        
        //初期値はtrue
        forChangeFlgSwitch.setOn(true, animated: true)
        
        //操作時の関数割り当て
        forChangeFlgSwitch.addTarget(self, action: #selector(jsonParseFlgSwitch(sender:)), for: UIControl.Event.valueChanged)
        
        //AutoLayoutの設定
        forChangeFlgSwitch.translatesAutoresizingMaskIntoConstraints = false
        forChangeFlgSwitch.topAnchor.constraint(equalTo: view.topAnchor, constant: 20).isActive = true
        forChangeFlgSwitch.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.2).isActive = true
        forChangeFlgSwitch.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.1).isActive = true
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
        return titleInSwitcherModel.getTitle(jsonParseFlg: jsonParseFlg)
    }
    
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {
 
        //nilの場合、defaultUrlを返す
        guard let homeVCUrlString = urlModel.getURLString(index: index, jsonParseFlg: jsonParseFlg) else {
            
            return NewsPageViewController(urlString: urlModel.defaultUrl, jsonParseFlg: jsonParseFlg)
            
        }
        
        return NewsPageViewController(urlString: homeVCUrlString, jsonParseFlg: jsonParseFlg)
        
    }
    
    @objc public func jsonParseFlgSwitch(sender: UISwitch) {
        
        //フラグの操作
        if sender.isOn {
            self.jsonParseFlg = true
        }else{
            self.jsonParseFlg = false
        }
        //フラグ変更後、画面をリロードする
        reloadData()
        defaultSelectedIndex = 0
    
    }

}
