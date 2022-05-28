//
//  ViewController.swift
//  RealmPractice
//
//  Created by Apple New on 2022-05-19.
//

import UIKit
import RealmSwift
import Realm
import Elements

class ViewController: UIViewController {
    
    lazy var contentField : BaseUITextField = {
        let tf = BaseUITextField()
        tf.placeholder = "content... ex) Study math"
        tf.backgroundColor = .secondarySystemBackground
        tf.layer.shadowColor = UIColor.lightGray.cgColor
        tf.heightAnchor.constraint(equalToConstant: 50).isActive = true
        tf.widthAnchor.constraint(equalToConstant: 300).isActive = true
        tf.returnKeyType = .done
        return tf
    }()
    
    lazy var dataDisplayLabel : BaseUILabel = {
        let label = BaseUILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.textAlignment = .center
        label.heightAnchor.constraint(equalToConstant: 50).isActive = true
        label.widthAnchor.constraint(equalToConstant: 300).isActive = true
        return label
    }()
    
    lazy var saveBTN: BaseUIButton = {
        let button = BaseUIButton()
        button.setTitle("save", for: .normal)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(saveHandler), for: .touchUpInside)
        return button
    }()
    
    
    lazy var deleteBTN: BaseUIButton = {
        let button = BaseUIButton()
        button.setTitle("delete", for: .normal)
        button.setTitleColor(UIColor.systemRed, for: .normal)
        button.layer.borderColor = UIColor.systemBackground.cgColor
        button.layer.borderWidth = 2
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.layer.cornerRadius = 15
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .headline)
        button.addTarget(self, action: #selector(deleteHandler), for: .touchUpInside)
        return button
    }()
    
    lazy var btnStack : HStack = {
        let stack = HStack()
        stack.addArrangedSubview(saveBTN)
        stack.addArrangedSubview(deleteBTN)
        stack.alignment = .center
        return stack
    }()
    
    lazy var contentStack : VStack = {
        let stack = VStack()
        stack.addArrangedSubview(contentField)
        stack.addArrangedSubview(dataDisplayLabel)
        stack.addArrangedSubview(btnStack)
        stack.alignment = .center
        return stack
    }()
    
    let realm = try! Realm()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(contentStack)
        defaultValue()
        
        NSLayoutConstraint.activate([
            
            contentStack.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            contentStack.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentStack.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentStack.bottomAnchor.constraint(equalTo: view.bottomAnchor),

        ])
    }
    
    func defaultValue(){
        let joe = Person()
        joe.firstName = "Joe"
        joe.lastName = "Smith"

        realm.beginWrite()
        realm.add(joe)
        dataDisplayLabel.text = joe.firstName + " " + joe.lastName
        try! realm.commitWrite()
    }

    @objc func saveHandler(){
        let new = Person()
        
        realm.beginWrite()
        realm.add(new)
        new.lastName = "Smith"
        new.firstName = contentField.text ?? "Not typed yet"
        dataDisplayLabel.text = new.firstName + " " + new.lastName
        try! realm.commitWrite()
    }
    
    @objc func deleteHandler(){
        realm.beginWrite()
        realm.delete(realm.objects(Person.self))
        print("Completed")
        try! realm.commitWrite()
        
        
        print()
    }

}

class Person: Object {
    @objc dynamic var firstName: String = ""
    @objc dynamic var lastName: String = ""
    @objc dynamic var ageName: Int = 0
//    @objc dynamic var firstName: String = ""
}
