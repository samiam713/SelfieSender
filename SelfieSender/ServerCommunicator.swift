//
//  ServerCommunicator.swift
//  SelfieSender
//
//  Created by Samuel Donovan on 2/15/21.
//

import Foundation

// Sends HTTPRequests and handles the responses
class ServerCommunicator {

    static func getEndPointURL(path: String) -> URL {
        var urlComponents = URLComponents(string: "https://www.aws.com/")!
        urlComponents.port = 8000
        urlComponents.path = path
        return urlComponents.url!
    }

    static let serverURL = URL(string:"https://www.aws.com:8080")!
    
//    example update of UserData
//    class UserData: Codable {
//
//    }
//
//    static func updateUserProfileData(userData: UserData) {
//        let jsonEncoder = JSONEncoder()
//        var urlRequest = URLRequest(url: getEndPointURL(path: "updateProfilePic"))
//
//        urlRequest.httpBody = try! jsonEncoder.encode(userData)
//    }
    
    static func updateUserProfile(pngData: Data) {
        var urlRequest = URLRequest(url: getEndPointURL(path: "updateProfilePic"))
        urlRequest.httpBody = pngData
        urlRequest.httpMethod = "POST"

        let task = URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            // Check for Error
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {return}
            print((200..<300).contains(httpResponse.statusCode))
            
            // Convert HTTP Response Data to a String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
                print("Response data string:\n \(dataString)")
            }
        }
        task.resume()
    }

}
