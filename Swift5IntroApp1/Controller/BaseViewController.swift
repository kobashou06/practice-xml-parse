import UIKit
import SegementSlide


class BaseViewController: SegementSlideDefaultViewController{

    override func viewDidLoad() {

        super.viewDidLoad()

        reloadData()

        defaultSelectedIndex = 0

    }


    override func segementSlideHeaderView() -> UIView {

        let headerView = UIImageView()

        headerView.isUserInteractionEnabled = true

        headerView.contentMode = .scaleAspectFill

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

        return ["TOP","Abema TIMES","Yahoo! JAPAN クリエイターズプログラム","IT","BuzzFeed Japan","CNN.co.jp"]

    }




    //教材ではニュースページごとにコントローラーが分かれていたが、Switchでひとまとめにした
    override func segementSlideContentViewController(at index: Int) -> SegementSlideContentScrollViewDelegate? {

        let imageName:String
        let urlString:String

        switch index {

        case 0:

            imageName = "0"
            urlString = "https://news.yahoo.co.jp/rss/topics/top-picks.xml"

        case 1:

            imageName = "1"
            urlString = "https://news.yahoo.co.jp/rss/media/abema/all.xml"

        case 2:

            imageName = "2"
            urlString = "https://news.yahoo.co.jp/rss/media/ycreatp/all.xml"

        case 3:

            imageName = "3"
            urlString = "https://news.yahoo.co.jp/rss/topics/it.xml"

        case 4:

            imageName = "4"
            urlString = "https://news.yahoo.co.jp/rss/media/bfj/all.xml"

        case 5:

            imageName = "5"
            urlString = "https://news.yahoo.co.jp/rss/media/cnn/all.xml"

        default:

            imageName = "0"
            urlString = "https://news.yahoo.co.jp/rss/topics/top-picks.xml"

        }

        return NewsPageViewController(imageName: imageName, urlString: urlString)

    }

}


