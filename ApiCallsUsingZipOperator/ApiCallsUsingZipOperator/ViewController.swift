//
//  ViewController.swift
//  ApiCallsUsingZipOperator
//
//  Created by Sunil Kumar Reddy Sanepalli on 22/05/23.
//

import UIKit

class ViewController: UIViewController {

    private var viewModel = ViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        viewModel.getData()
    }
}

