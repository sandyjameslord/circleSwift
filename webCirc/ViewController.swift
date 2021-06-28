//
//  ViewController.swift
//  webCirc
//
//  Created by Sandy Lord on 6/21/21.
//

import UIKit
import Foundation

struct APIResponse: Codable {
    let _id: APIID?
    let abQuestion: String?
    let abQuestionDomain: String?
    let abSentence: String?
    let bcQuestion: String?
    let bcQuestionDomain: String?
    let bcSentence: String?
    let imageName: String?
    let numSyll: APINumSyll?
    let photo: String?
    let progName: String?
    let syllStructure: String?
    let theme: String?
    let unit: APIUnit?
    let vocabulary: String?
}
    
// individual structures for parts of the APIResponse
struct APIUnit: Codable {
    let numberInt: Int
}
struct APINumSyll: Codable {
    let numberInt: Int
}
struct APIID: Codable {
    let oid: String
}

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getData { (array) in

            for image in array {
                print("image",image) // prints each result in terminal, one at a time
//                let result = try? JSONDecoder().decode(APIResponse.self, from: image as! Data) // if run: Thread 3: signal SIGABRT
//                print(result)
            }
        }
    }
    
    func getData(_ completion: @escaping (Array<Any>) -> ()) {
        let urlPath = "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/cirdata-khyvx/service/cirData/incoming_webhook/cirlAPI"

        guard let url = URL(string: urlPath) else { return }

        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            guard let data = data else { return }
            print("data",data) // some 304000 bytes, indicating success
            do {
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSArray {
                    completion(jsonResult as! Array<Any>)
                }
            } catch {
                //Catch Error here...
            }
        }
        task.resume()
    }
}

