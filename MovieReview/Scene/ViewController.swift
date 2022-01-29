//
//  ViewController.swift
//  MovieReview
//
//  Created by 김민지 on 2022/01/29.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovieSearchManager().request(from: "Starwars") { movies in
            print(movies)
        }
    }
}
