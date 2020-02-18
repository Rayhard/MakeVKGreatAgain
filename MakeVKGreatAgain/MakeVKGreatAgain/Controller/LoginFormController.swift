//
//  LoginFormController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 08.02.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit

class LoginFormController: UIViewController {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBAction func singInButton(_ sender: Any) {

    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        let checkResult = checkUserData()
        
        if checkResult == false{
            showLoginError()
        }
        
        return checkResult
    }
    
    func checkUserData() -> Bool {
        guard let login = loginTextField.text,
            let password = passwordTextField.text else { return false }
        
        if login == "admin" && password == "admin" {
            return true
        } else {
            return false
        }
    }
    
    func showLoginError() {
        let alter = UIAlertController(title: "Ошибка", message: "Введен не верный логин или пароль", preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alter.addAction(action)
        present(alter, animated: true, completion: nil)
    }


    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        scrollView.addGestureRecognizer(tapGesture)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillShow(notification: Notification){
        let info = notification.userInfo! as NSDictionary
        let size = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        
        let contentInsets = UIEdgeInsets(top: 0, left: 0, bottom: size.height, right: 0)
        self.scrollView?.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }
    
    @objc func keyboardWillHide(notification: Notification){
        scrollView.contentInset = .zero
    }
    
    @objc func hideKeyboard() {
        self.scrollView.endEditing(true)
    }
}
