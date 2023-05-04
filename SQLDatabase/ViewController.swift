//
//  ViewController.swift
//  SQLDatabase
//
//  Created by R93 on 20/09/34.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    @IBAction func onClickShow(_ sender: UIButton) {
        let x = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ShowData")
        self.navigationController?.pushViewController(x, animated: true)
    }
    @IBAction func onClickData(_ sender: UIButton) {
        let x = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "DataData")
        self.navigationController?.pushViewController(x, animated: true)
    }

}

