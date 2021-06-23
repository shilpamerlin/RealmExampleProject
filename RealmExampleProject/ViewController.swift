//
//  ViewController.swift
//  RealmExampleProject
//
//  Created by Shilpa Joy on 2021-06-23.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {

    @IBOutlet weak var clickBtn: UIButton!
    private var realm : Realm?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        realm = try! Realm()
        readData()
    }

    @IBAction func btnTapped(_ sender: Any) {
        //start editing our realm
        
        let list = List<SomeArray>()
        
        var obj = SomeArray()
        obj.id = String(Date().timeIntervalSince1970)
        obj.name = "Array Object 1"
        obj.value = "Array Object value 1"
        list.append(obj)
        
        var obj1 = SomeArray()
        obj1.id = String(Date().timeIntervalSince1970)
        obj1.name = "Array Object 1"
        obj1.value = "Array Object value 2"
        list.append(obj1)
        
        let someObject = SomeObject()
        someObject.id = String(Date().timeIntervalSince1970)
        someObject.title = "Some Title"
        someObject.some_integer = 9
        someObject.some_double = 12.0
        someObject.some_array = list
        
        let mainModel = MainModelClass()
        mainModel.id = String(Date().timeIntervalSince1970)
        mainModel.name = "Shilpa Merlin"
        mainModel.some_object = someObject
        
        
        realm?.beginWrite()
        realm?.add(mainModel)
        try! realm?.commitWrite()
    }
    
    func readData() {
        realm?.beginWrite()
        let data = realm?.objects(MainModelClass.self)
        //encoding data into json format
        let jsonData = try! JSONEncoder().encode(data)
        print(String(data: jsonData, encoding: .utf8)!)
        try! realm?.commitWrite()
    }
}

