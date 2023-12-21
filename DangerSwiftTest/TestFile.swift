//
//  TestFile.swift
//  DangerSwiftTest
//
//  Created by Vinh Nguyen Xuan on 21/12/2023.
//

import Foundation

struct TestValue {
    var myVariable: String?
    
    func doSomething() {
        if let url = URL(string: myVariable ?? "") {
            print(url)
        }
    }
}
