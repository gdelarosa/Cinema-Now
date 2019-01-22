import UIKit

class HomeViewController: UIViewController {
    
    //var delegateNow: NowPlayingDelegate?
    
    var categories = ["", "Popular Celebrities", "Now Playing", "Trending", "Top Rated"]
    
    @IBOutlet weak var mainTableView: UITableView!
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "goToSecondVC" {
            if segue.destination.isKind(of: DetailViewController.self) {
                
                let secondVC = segue.destination as! DetailViewController
                let indexPath = sender as! IndexPath
                let movie = movies[indexPath.row]
                
                secondVC.movie = movie
            }
        }
    }

    
    // MARK: - Properties
    
    let client = Service()
    var movies: [Movie] = []
    
    var cancelRequest: Bool = false
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cancelRequest = false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainTableView.reloadData()
    }
    
    override var preferredStatusBarStyle : UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        cancelRequest = true
    }
    
}

extension HomeViewController : UITableViewDataSource, UITableViewDelegate, NowPlayingDelegate {    
    
    //Nothing happens here
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//         guard movies.count > indexPath.row else { return }
//         let movie = movies[indexPath.row]
//
//         guard let detailVC = storyboard?.instantiateViewController(withIdentifier: "movieDetail") as? DetailViewController else { return }
//         detailVC.movie = movie
//         self.showDetailViewController(detailVC, sender: self)

    }
    
    func goToNowPlayingDetail() {
        print("Make something happen")
       // performSegue(withIdentifier: "goToSecondVC", sender: )
    }
    
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
            cell.delegate = self
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "trendingCell") as! TrendingRow
        
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "topRatedCell") as! TopRatedRow
            return cell
        }
    }
    

    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = #colorLiteral(red: 0.1538375616, green: 0.1488625407, blue: 0.1489177942, alpha: 1)
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = UIColor.white
        header.textLabel?.font = UIFont(name: "Futura", size: 14)
        
        
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
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            return 395
        }
        if indexPath.section == 1 {
            return 90
        }
        return 145
    }

}


