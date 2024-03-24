import UIKit
import RealmSwift
import SnapKit

class ViewController: UIViewController {
    let realm = try! Realm()
    var names = [UserInfo]()
    lazy var textField1: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 25)
        field.backgroundColor = .white
        field.placeholder = "Enter name"
        field.layer.borderColor = UIColor.blue.cgColor
        field.layer.borderWidth = 2.5
        field.textAlignment = .center
        return field
    }()
    lazy var textField2: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 25)
        field.backgroundColor = .white
        field.placeholder = "Enter surname"
        field.layer.borderColor = UIColor.blue.cgColor
        field.layer.borderWidth = 2.5
        field.textAlignment = .center
        return field
    }()
    lazy var textField3: UITextField = {
        let field = UITextField()
        field.font = .systemFont(ofSize: 25)
        field.backgroundColor = .white
        field.placeholder = "Enter password"
        field.layer.borderColor = UIColor.blue.cgColor
        field.layer.borderWidth = 2.5
        field.textAlignment = .center
        field.isSecureTextEntry = true
        return field
    }()
    
    lazy var button: UIButton = {
        let button = UIButton()
        button.setTitle("Tap me", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.addTarget(self, action: #selector(setName), for: .touchDragInside)
        return button
    }()
    
    lazy var updateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Update", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 30)
        button.addTarget(self, action: #selector(updateUserInfo), for: .touchUpInside)
        return button
    }()
    
    lazy var label: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var label2: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    
    lazy var label3: UILabel = {
        let label = UILabel()
        label.text = ""
        label.font = .systemFont(ofSize: 20, weight: .regular)
        return label
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUi()
        getNames()
    }
    
    private func setUi () {
        view.addSubview(textField1)
        view.addSubview(textField2)
        view.addSubview(textField3)
        view.addSubview(button)
        view.addSubview(updateButton)
        view.addSubview(label)
        view.addSubview(label2)
        view.addSubview(label3)
        textField1.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        textField2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField1.snp.bottom).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        textField3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField2.snp.bottom).offset(10)
            make.width.equalTo(300)
            make.height.equalTo(50)
        }
        button.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(textField3.snp.bottom).offset(30)
        }
        label2.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label.snp.bottom).offset(10)
        }
        label3.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(label2.snp.bottom).offset(10)
        }
        updateButton.snp.makeConstraints { make in
            make.right.equalToSuperview().inset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(10)
        }
    }
    @objc private func buttonTapped() {
        
        var userName = UserInfo()
        
        let enteredName = textField1.text ?? ""
        userName.name = enteredName
        label.text = enteredName
        
        let enteredSurname = textField2.text ?? ""
        userName.surname = enteredSurname
        label2.text = enteredSurname
        
        let enteredPassword = textField3.text ?? ""
        userName.password = enteredPassword
        label3.text = enteredPassword
        
        try! realm.write({
            realm.add(userName)
        })
    }
    @objc func setName() {
        getNames()
    }
    private func getNames () {
        let names = realm.objects(UserInfo.self)
        
        self.names = names.map({ names in
            names
        })
        label.text = names.last?.name
        
        label2.text = names.last?.surname
        
        label3.text = names.last?.password
        
    }
    
    @objc private func updateUserInfo() {
        let userInfo = realm.objects(UserInfo.self).last
        try! realm.write {
            userInfo?.name = textField1.text ?? ""
            userInfo?.surname = textField2.text ?? ""
            userInfo?.password = textField3.text ?? ""
        }
        label.text = userInfo?.name
        label2.text = userInfo?.surname
        label3.text = userInfo?.password
    }

}

