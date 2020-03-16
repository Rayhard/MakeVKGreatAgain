//
//  LoginController.swift
//  MakeVKGreatAgain
//
//  Created by n.perezhogin on 16.03.2020.
//  Copyright © 2020 n.perezhogin. All rights reserved.
//

import UIKit
import WebKit
import Alamofire


class LoginController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!{
        didSet{
            webView.navigationDelegate = self
        }
    }
    @IBAction func loginButton(_ sender: Any) {
        webView.isHidden = false
    }
    
    let baseUrl = "https://api.vk.com"
    let apiVersion = "5.103"
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "oauth.vk.com"
        urlComponents.path = "/authorize"
        urlComponents.queryItems = [
            URLQueryItem(name: "client_id", value: "7360419"),
            URLQueryItem(name: "display", value: "mobile"),
            URLQueryItem(name: "redirect_uri", value: "https://oauth.vk.com/blank.html"),
            URLQueryItem(name: "scope", value: "262150"),
            URLQueryItem(name: "response_type", value: "token"),
            URLQueryItem(name: "v", value: "5.103")
        ]

        let request = URLRequest(url: urlComponents.url!)

        webView.load(request)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
}

extension LoginController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, decidePolicyFor navigationResponse: WKNavigationResponse, decisionHandler: @escaping (WKNavigationResponsePolicy) -> Void) {
        
        guard let url = navigationResponse.response.url, url.path == "/blank.html", let fragment = url.fragment  else {
            decisionHandler(.allow)
            return
        }
        
        let params = fragment
            .components(separatedBy: "&")
            .map { $0.components(separatedBy: "=") }
            .reduce([String: String]()) { result, param in
                var dict = result
                let key = param[0]
                let value = param[1]
                dict[key] = value
                return dict
        }
        
        let token = params["access_token"]
        let userId = params["user_id"]
        
        let session = Session.instance
        session.token = token ?? ""
        session.userId = Int(userId  ?? "0")!

//        loadFriendsData()
//        loadImagesData(session.userId)
//        loadGroupsData()
//        loadSearchGroupsData("GeekBrains")
        
        performSegue(withIdentifier: "goToNews", sender: nil)
        
        decisionHandler(.cancel)
    }
    
    // Пока сделал все запросы тут, в дальнейшем разнесу по нужным местам
    func loadFriendsData(){
        let session = Session.instance
        let path = "/method/friends.get"
        let parameters: Parameters = [
            "access_token": session.token,
            "v": apiVersion
        ]

        let url = baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
        
    }
    
    func loadImagesData(_ owner: Int){
        let session = Session.instance
        let path = "/method/photos.get"
        let parameters: Parameters = [
            "owner_id": owner,
            "album_id": "profile",
            "access_token": session.token,
            "v": apiVersion
        ]

        let url = baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
        
    }
    
    func loadGroupsData(){
        let session = Session.instance
        let path = "/method/groups.get"
        let parameters: Parameters = [
            "user_id": session.userId,
            "access_token": session.token,
            "v": apiVersion
        ]

        let url = baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
        
    }
    
    func loadSearchGroupsData(_ query: String){
        let session = Session.instance
        let path = "/method/groups.search"
        let parameters: Parameters = [
            "q": query,
            "access_token": session.token,
            "v": apiVersion
        ]

        let url = baseUrl+path

        AF.request(url, method: .get, parameters: parameters).responseJSON { repsonse in
            print(repsonse.value)
        }
        
    }

}

