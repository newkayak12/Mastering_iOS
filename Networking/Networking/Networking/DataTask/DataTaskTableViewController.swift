import UIKit

class DataTaskTableViewController: UITableViewController {
   
   var list = [Book]()
   
   @IBAction func sendRequest(_ sender: Any) {
      let booksUrlStr = "https://kxcoding-study.azurewebsites.net/api/books"
      
      // Code Input Point #1
       guard let url = URL(string: booksUrlStr) else { fatalError("Invalid URL") }
       let session = URLSession.shared
       let task = session.dataTask(with: url) { (data, response, error ) in
           if let error = error {
               self.showErrorAlert(with: error.localizedDescription)
               print(error)
               return
           }
           
           guard let httpResponse = response as? HTTPURLResponse else {
               self.showErrorAlert(with: "Invalid Response")
               return
           }
           
           guard (200...299).contains(httpResponse.statusCode) else {
               self.showErrorAlert(with: "\(httpResponse.statusCode)")
               return
           }
           
           guard let data = data else {
               fatalError("Invalid Data")
           }
           
           
           do {
               let decoder = JSONDecoder()
               decoder.dateDecodingStrategy = .custom({ (decoder) -> Date in
                   let container = try decoder.singleValueContainer()
                   let dateStr = try container.decode(String.self)
                   
                   let formatter = ISO8601DateFormatter()
                   formatter.formatOptions = [.withFullDate, .withDashSeparatorInDate, .withColonSeparatorInTime]
                   return formatter.date(from: dateStr)!
               })
               let bookList = try decoder.decode(BookList.self, from: data)
               
               if bookList.code == 200 {
                   self.list = bookList.list
                   DispatchQueue.main.async {
                       self.tableView.reloadData()
                   }
               } else {
                   self.showErrorAlert(with: bookList.message ?? "ERROR!")
               }
               
           } catch {
              print(error)
               self.showErrorAlert(with: error.localizedDescription)
           }
           
       }
       // MARK: RESUME()!!!!
       task.resume()
      
       
      // Code Input Point #1
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if let destVC = segue.destination as? BookDetailTableViewController {
         if let cell = sender as? UITableViewCell, let indexPath = tableView.indexPath(for: cell) {
            // Code Input Point #5
             destVC.book = list[indexPath.row]
            // Code Input Point #5
         }
      }
   }
}

extension DataTaskTableViewController {
   override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return list.count
   }
   
   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
      
      // Code Input Point #2
       let target = list[indexPath.row]
       cell.textLabel?.text = target.title
      // Code Input Point #2
      
      return cell
   }
}
