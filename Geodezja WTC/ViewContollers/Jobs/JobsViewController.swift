//
//  JobsViewController.swift
//  Geodezja WTC
//
//  Created by Maciej Matuszewski on 12.02.2018.
//  Copyright © 2018 Maciej Matuszewski. All rights reserved.
//

import UIKit

class JobsViewController: UIViewController {

    init() {
        super.init(nibName: nil, bundle: nil)
        navigationController?.tabBarItem.title = "Current jobs".localized
    }

    @available (*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
