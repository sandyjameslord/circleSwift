//
//  ViewController.swift
//  webCirc
//
//  Created by Sandy Lord on 6/21/21.
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // call the function to make the api call to MongoDB
        self.loadData()
    }
    
    // structure of an individual circleImage
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
    
    // array to hold the 400 or so APIResponses. Should be cached ultimately.
    var circleData: Array<APIResponse> = []
    
    func loadData() {
        // accesses the API endpoint I have set up in a MongoDB Realm app. Access to it returns an array of circleImages
        let session = URLSession.shared

        let url = URL(string: "https://us-east-1.aws.webhooks.mongodb-realm.com/api/client/v2.0/app/cirdata-khyvx/service/cirData/incoming_webhook/cirlAPI")!

        let task = session.dataTask(with: url, completionHandler: { data, response, error in
            var result: APIResponse?
            do {
                // creates 'json', an __NSArrayI file
                if let json = try? JSONSerialization.jsonObject(with: data!, options: []) {
                    // able to print this 'json' file to the console
                    print(json)
                    print("------------------")
                    print("json file type", type(of: json))
                    
                    
                    // now I would like to store 'json' for later access. I've attempted many ways but it always seems to end up that the types are incompatible, or that the json object is not iterable. Ultimately it will be best to cache this information but for now I would like to simply be able to access it outside of this function.
                    
                    //attempting to get a result, but this throws an "Thread 7: signal SIGABRT" error
//                    result = try? JSONDecoder().decode(APIResponse.self, from: json as! Data)
                    //circleData.append(result)
                    
                }
            } catch {
                print("Failed to decode with error: \(error)")
            }
            // prints nil because nothing happened to it
            print("result: ",result)

        })
        task.resume()

    }
}

