//
//  ViewController.swift
//  CarTrack
//
//  Created by Raj Kumar Gola on 08/12/22.
//

import UIKit

//MARK: used this Controller for login screen
class CTLoginViewController: CTBaseViewController {
    @IBOutlet weak var loginTableView: UITableView!
    lazy var loginViewModel = CTLoginViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerTableCell()
        loginViewModel.delegate = self
        // Do any additional setup after loading the view.
    }
    
    private func registerTableCell(){
        loginTableView.register(CTLoginHeaderCell.self)
        loginTableView.register(CTInputTFCell.self)
        loginTableView.register(CTActionButtonCell.self)
    }
    
    private func tableViewSetup(){
        loginTableView.estimatedRowHeight = 100
        loginTableView.rowHeight = UITableView.automaticDimension
    }
}

//MARK: table view delegate datasource handling
extension CTLoginViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return loginViewModel.cellViewModel.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case LoginPageCells.CellTypeHeader.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CTLoginHeaderCell.nibName, for: indexPath) as! CTLoginHeaderCell
            cell.configureCell(model: loginViewModel.cellViewModel[indexPath.row] as? CTHeaderLabelCellModel)
            return cell
        case LoginPageCells.CellTypeEmail.rawValue,LoginPageCells.CellTypeDropdown.rawValue,LoginPageCells.CellTypePassword.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CTInputTFCell.nibName, for: indexPath) as! CTInputTFCell
            cell.configureCell(model: loginViewModel.cellViewModel[indexPath.row] as? CTInputTFCellModel)
            cell.delegate = loginViewModel
            return cell
        case LoginPageCells.CellTypeLoginBtn.rawValue:
            let cell = tableView.dequeueReusableCell(withIdentifier: CTActionButtonCell.nibName, for: indexPath) as! CTActionButtonCell
            
            cell.configureCell(model: loginViewModel.cellViewModel[indexPath.row] as? CTActionButtonCellModel)
            cell.delegate = loginViewModel
            return cell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case LoginPageCells.CellTypeHeader.rawValue:
            return 150
        default:
            return UITableView.automaticDimension
        }
    }
}

//MARK: ViewModelDelegate callback handling
extension CTLoginViewController:CTLoginViewModelDelegate{
    func configureCellOnEditingBases(row: Int) {
        if self.loginViewModel.cellViewModel.count > row,let cell = self.loginTableView.cellForRow(at: IndexPath(row: row, section: 0)) as? CTInputTFCell{
            cell.configureCell(model: self.loginViewModel.cellViewModel[row] as? CTInputTFCellModel)
        }
    }
    
    func loginSuccessful() {
        loginViewModel.goToUserListingScreen(from: self)
    }
    
    func wrongCredentials() {
        self.showMessage(with: Constants.validationError)
    }
    
    func endTheViewEditing() {
        self.view.endEditing(true)
    }

}
