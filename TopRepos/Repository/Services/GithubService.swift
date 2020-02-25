//
//  ReposServices.swift
//  TopRepos
//
//  Created by Silvia Florido on 25/02/20.
//  Copyright © 2020 Silvia Florido. All rights reserved.
//

import Foundation
import UIKit

class GithubService: NSObject {
    var session = URLSession.shared
    
    let parseError = NSError(domain: "convertData", code: 1, userInfo: [NSLocalizedDescriptionKey: [NSLocalizedDescriptionKey : "Couldn't parsed the json results key."]])
    
    
    func getPullsByRepo(userName: String, repoName: String, _ completionHandler: @escaping (_ response: [Pull]?, _ error: NSError?) -> Void) {

        let request = BaseRequest()
        let dict = [ParameterKeys.UserName:userName,
                    ParameterKeys.RepoName:repoName]
        let mutableMethod = request.replaceKeysInMethod(GithubService.Methods.PullsByRepo, keyValues: dict) ?? ""

        _ = request.taskForGETMethod(mutableMethod, parameters: nil, responseType: [Pull].self) { (response, error) in
            DispatchQueue.main.async {
                completionHandler(response, error)
            }
        }
    }
    
    
    func getRepoByLanguage(language: String, sort: String, page: String, _ completionHandler: @escaping (_ response: [Repo]?, _ error: NSError?) -> Void) {
        
        let request = BaseRequest()
        let languageQualifier = GithubService.QueryKeys.formatQualifier(value: language, for: GithubService.QueryKeys.Qualifiers.language)
        
        let parameters = [GithubService.QueryKeys.Query:languageQualifier as AnyObject,
                          GithubService.QueryKeys.Page:page as AnyObject,
                          GithubService.QueryKeys.Sort:sort as AnyObject]
        
        _ = request.taskForGETMethod(Methods.RepoList, parameters: parameters, responseType: ReposByLanguageResponse.self) { (response, error) in
            DispatchQueue.main.async {
                completionHandler(response?.repos, error)
            }
        }
    }
    
    func getImage(withURL url:URL, completion: @escaping (_ image:UIImage?)->()) {
        BaseRequest.getImage(withURL: url, completion: completion)
    }
    
    // MARK: Shared
    class func sharedInstance() -> GithubService {
        struct Singleton {
            static var sharedInstance = GithubService()
        }
        return Singleton.sharedInstance
    }
}


extension GithubService {
    
    struct Constants {
        static let ApiKey = ""
        static let ApiScheme = "https"
        static let ApiHost = "api.github.com"
        static let ApiPath = ""
        static let PageSize = 30
    }
    
    struct Methods {
        static let RepoList = "/search/repositories"
        static let PullsByRepo = "/repos/{userName}/{repoName}/pulls"
    }
    
    struct ParameterKeys {
        static var UserName = "userName"
        static var RepoName = "repoName"
    }
    
    struct QueryKeys {
        static var Query = "q"
        static var Sort = "sort"
        static var Page = "page"
        
        enum Qualifiers: String {
            case language
        }
        
        static func formatQualifier(value: String, for q:Qualifiers) -> String {
            return "\(q.rawValue):\(value)"
        }
    }
}
