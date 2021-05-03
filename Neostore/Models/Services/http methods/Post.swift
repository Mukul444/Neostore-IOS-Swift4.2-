
import Foundation
struct Post
{
    // MARK Variables
   
    
    func post(){
        let request = NSMutableURLRequest(url: NSURL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/register")! as URL)
        request.httpMethod = "POST"
        
        let postString = "first_name=kannan&last_name=maravar&email=tefffsuserlal@wwindia.com&password=Kannan123&confirm_password=Kannan123&gender=M&phone_no=7715020"
        request.httpBody = postString.data(using: String.Encoding.utf8)
        
        request.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        
        //create dataTask using the session object to send data to the server
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: { data, response, error in
            
            guard error == nil else {
                print(error)
                return
            }
            
            guard let data = data else {
                print("data not found")
                return
            }
            
            do {
                //create json object from data
                if let jsonObj = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any] {
                    print(jsonObj)
                   // completionHandler(.success(value: data))
                }
            } catch let error {
                print(error.localizedDescription)
               // completionHandler(.failure(error: error))
            }
        })
        task.resume()
    }
}
