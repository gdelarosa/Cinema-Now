import UIKit

class ViewController: UIViewController {
    
    var categories = ["", "", "Now Playing", "Trending", "Top Rated"]
    
    @IBOutlet weak var mainTableView: UITableView! //testing
    
    // MARK: - Properties
    
    let client = Service()
    var movies: [Movie] = []
    var row: NowPlayingRow!
    
    
    var cancelRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancelRequest = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
  
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelRequest = true
    }
}

extension ViewController : UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "upcomingCell") as!  UpcomingRow
            return cell
        }
        else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "movieCell") as! ActorsRow
            return cell
        } else if indexPath.section == 2 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NowPlayingRow
            return cell
        } else { 
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! NowPlayingRow
            return cell
        }
    }
    
    
func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        (view as! UITableViewHeaderFooterView).backgroundView?.backgroundColor = UIColor.clear 
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return nil
        } else {
           return categories[section]
        }
       
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return categories.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//            tableView.deselectRow(at: indexPath, animated: true)
//            guard movies.count > indexPath.row else { return }
//            let movie = movies[indexPath.row]
//            guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailViewController else { return }
//            detailVC.movie = movie
//            self.showDetailViewController(detailVC, sender: self)
//    }
    
}



