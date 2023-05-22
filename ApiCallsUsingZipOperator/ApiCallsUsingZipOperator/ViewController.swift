//
//  ViewController.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import UIKit
import Combine

class ViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    private var viewModel = ViewModel()
    
    private var cancellables = Set<AnyCancellable>()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        bindViewModel()
    }
    @IBAction func detailsButtonTapped(_ sender: UIButton) {
        getData()
    }
    
    func getData() {
        viewModel.getData()
    }
    func bindViewModel() {
        viewModel.$allData
            .receive(on: DispatchQueue.main)
            .sink {[weak self] _ in
                self?.tableView.reloadData()
            }
            .store(in: &self.cancellables)
    }
}

extension ViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
           return viewModel.allData?.usersModel.count ?? 0
        } else {
           return viewModel.allData?.postModel.count ?? 0
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return section == 0 ? "Users List" : "Posts List"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell") {
            if indexPath.section == 0 {
                let data = viewModel.allData?.usersModel[indexPath.row]
                cell.textLabel?.text = "\(data?.username ?? "") (id: \(data?.id ?? 0))"
            } else {
                let data = viewModel.allData?.postModel[indexPath.row]
                cell.textLabel?.text = "(id: \(data?.id ?? 0)) \(data?.title ?? "") "
            }
            return cell
        }
        return UITableViewCell()
    }
}

