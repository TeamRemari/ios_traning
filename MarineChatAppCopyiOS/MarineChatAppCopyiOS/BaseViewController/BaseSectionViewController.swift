//  Copyright © 2019 Sho Morita. All rights reserved.
//

import UIKit

class BaseSectionViewController: UIViewController {
    
    private(set) var feedTableView: UITableView
    var layoutTrait: FeedTableViewLayoutTrait
    private var tabBarTintColor: UIColor?
    
    init(layoutTrait: FeedTableViewLayoutTrait = .fullWidth, feedTableView: UITableView = UITableView(),
         tabBarTintColor: UIColor? = nil) {
        self.layoutTrait = layoutTrait
        self.feedTableView = feedTableView
        self.tabBarTintColor = tabBarTintColor
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(feedTableView)
        setupFeedTableView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupFeedTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        tabBarController?.tabBar.tintColor = tabBarTintColor
    }
    
    private func setupFeedTableView() {
        switch layoutTrait {
        case .compactWidth:
            feedTableView.frame.size.width = view.bounds.width > 768 ? 768 : view.bounds.size.width
        case .fullWidth:
            feedTableView.frame.size.width = view.bounds.size.width
        }
        
        feedTableView.frame.origin = CGPoint(x: (view.bounds.width - feedTableView.bounds.width) / 2 ,
                                             y: 0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

enum FeedTableViewLayoutTrait {
    case compactWidth
    case fullWidth
}
