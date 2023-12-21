//
//  TestFile.swift
//  DangerSwiftTest
//
//  Created by Vinh Nguyen Xuan on 21/12/2023.
//

import Foundation

struct TestValue {
    var foo: String!
    
    func doSomething() {
        let url = URL(string: foo)!
        print(url)
    }
}
