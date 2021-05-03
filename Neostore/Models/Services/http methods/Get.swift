import Foundation
class Get
{
    // MARK Variables
    var responseData : GetUserData?
    
     func get(){
        // Create URL
        let url = URL(string: "http://staging.php-dev.in:8844/trainingapp/api/users/getUserData")
        guard let requestUrl = url else { fatalError() }
        
        // Create URL Request
        var request = URLRequest(url: requestUrl)
        
        // Specify HTTP Method to use
        request.httpMethod = "GET"
        request.setValue("606c9b3641f8b", forHTTPHeaderField: "access_token")
        
        // Send HTTP Request
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            
            // Check if Error took place
            if let error = error {
                print("Error took place \(error)")
                return
            }
            
            // Read HTTP Response Status code
            if let response = response as? HTTPURLResponse {
                print("Response HTTP Status code: \(response.statusCode)")
            }
            
            // Convert HTTP Response Data to a simple String
            if let data = data, let dataString = String(data: data, encoding: .utf8) {
            }
            let data2 = data as! Foundation.Data
            do{
                self.responseData = try JSONDecoder().decode(GetUserData.self, from: data2)
                guard  let responseData = self.responseData else {return}
               print(responseData)
            }
            catch {
                print("failed to load data")
            }
            
        }
        task.resume()
    }
}
