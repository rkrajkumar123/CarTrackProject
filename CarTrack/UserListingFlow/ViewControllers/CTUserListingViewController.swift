//
//  UserListingViewController.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 09/12/22.
//

import UIKit

//MARK: viewcontroller is used for showing listing of users
class CTUserListingViewController: CTBaseViewController {
    @IBOutlet weak var userListTableView: UITableView!
    lazy var viewModel = CTUserListingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        initializer()
        fetchQuizData()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.showNavigationBar(with: Constants.usersList)
        addNavigationRightButton()
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.hideNavigationBar()
    }
    
    private func initializer() {
        viewModel.delegate = self
        userListTableView.isHidden = true
    }
    
    private func registerTableCell(){
        userListTableView.register(CTUserDetailTableViewCell.self)
        userListTableView.register(CTDataNotFoundTableViewCell.self)
    }
    
    private func addNavigationRightButton(){
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: Constants.logout, style: .plain, target: self, action: #selector(logOut))
    }
    @objc func logOut(){
        self.hideNavigationBar()
        viewModel.goToLoginScreen(from: self)
    }
    
    // MARK: - Fetching Quiz Data Form Api
    private func fetchQuizData(){
        self.showProgressView()
        viewModel.getUserLists {
            Utils.getMainQueue {
                self.hideProgressView()
            }
        }
    }
}

//MARK: UITableView Delegate and DataSource Handling
extension CTUserListingViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewModel = viewModel.cellViewModel[indexPath.row]
        switch cellViewModel.cellType{
        case .userDetail:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CTUserDetailTableViewCell.nibName, for: indexPath) as? CTUserDetailTableViewCell else{ return UITableViewCell()}
            cell.configureCell(cellModel: cellViewModel)
            cell.tag = indexPath.row
            cell.delegate = self
            return cell
        case .dataNotFound:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: CTDataNotFoundTableViewCell.nibName, for: indexPath) as? CTDataNotFoundTableViewCell else{ return UITableViewCell()}
            cell.configureCell(cellModel: cellViewModel)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cellViewModel = viewModel.cellViewModel[indexPath.row]
        switch cellViewModel.cellType{
        case .userDetail:
            return 350
        case .dataNotFound:
            return 300
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cellViewModel = viewModel.cellViewModel[indexPath.row]
        switch cellViewModel.cellType{
        case .userDetail:
            viewModel.goToUserLocationViewController(from: self, for: indexPath.row)
        default:
            break
        }
    }
}

//MARK: User listing viewModel delegates handling
extension CTUserListingViewController:UserListingViewModelDelegate{
    func reloadTableView() {
        Utils.getMainQueue { [weak self] in
            self?.userListTableView.isHidden = false
            self?.userListTableView.reloadData()
        }
    }
}

//MARK: User detail tableView cell delegate handling
extension CTUserListingViewController:CTUserDetailTableViewCellDelegate{
    func linkClicked(at row: Int) {
        viewModel.openWebLink(for: self, and: row)
    }
}
