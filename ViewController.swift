//
//  ViewController.swift
//  Task-vajro
//
//  Created by Nabbel on 08/11/24.
//

import UIKit

class ViewController: UIViewController {
    
    
    private let ArticleViewModel = ViewModel()
    
    var pullToRefresh : UIRefreshControl?
    
    @IBOutlet weak var articleTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        ArticleViewModel.fetchArticles()

        articleTableView.register(ArticlesTableViewCell.self, forCellReuseIdentifier: "ArticlesTableViewCell")
                
        articleTableView.separatorStyle = .none
        
        articleTableView.backgroundColor = .white
        
        setupBindings()
        
        setupPullToRefresh()
        
        titleBtn()
                
        view.backgroundColor = .black
        
        navigationController?.navigationBar.barTintColor = UIColor.black

        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
          super.viewWillAppear(animated)
      
          if let selectedIndexPath = articleTableView.indexPathForSelectedRow {
              articleTableView.deselectRow(at: selectedIndexPath, animated: true)
          }
      }
      
    
//MARK: - Setups and pull to refresh and Buttons
    
    func titleBtn() {
        let titleButton = UIButton(type: .system)
        titleButton.setTitle("Blogs", for: .normal)
        titleButton.setTitleColor(.white, for: .normal)
        titleButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        self.navigationItem.titleView = titleButton
    }
    
 
    private func setupBindings() {
        ArticleViewModel.reloadTableView = { [weak self] in
            self?.articleTableView.reloadData()
          }
      }
    
    private func setupPullToRefresh() {
        
        pullToRefresh = UIRefreshControl()
        articleTableView.addSubview(pullToRefresh!)
        pullToRefresh?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
       }
    
    @objc private func refreshData() {
        ArticleViewModel.fetchArticles()
        pullToRefresh?.endRefreshing()
        print("Successfully Refreshed")
      }
    
}
//MARK: - Table View Delegates and Datasource
extension ViewController : UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ArticleViewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = articleTableView.dequeueReusableCell(withIdentifier: "ArticlesTableViewCell", for: indexPath) as! ArticlesTableViewCell
        
        let article = ArticleViewModel.article(at: indexPath)
        
        cell.configure(with: article)
    
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("User Tapped")
        let article = ArticleViewModel.article(at: indexPath)
        
        let webViewController = WebViewController()
        
        webViewController.htmlContents = article.body_html
        
        navigationController?.pushViewController(webViewController, animated: true)

    }

}

