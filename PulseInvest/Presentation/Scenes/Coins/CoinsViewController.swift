import UIKit

final class CoinsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: CoinsViewModel
    
    private let tableView: UITableView = UITableView()
    private var coins: [Coin] = []
    
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let label: UILabel = UILabel()
    private let retryButton: UIButton = UIButton(type: .system)
    
    // MARK: - Init
    init(viewModel: CoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupTableView()
        bind()
        viewModel.fetchCoins()
    }
    
    // MARK: - Private methods
    private func bind() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: CoinsViewState) {
        
        loadingIndicator.stopAnimating()
        label.isHidden = true
        retryButton.isHidden = true
        retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
        tableView.isHidden = true
        
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            
        case let .success(coins):
            self.coins = coins
            tableView.reloadData()
            tableView.isHidden = false
            
        case let .error(error):
            label.text = error.message
            label.isHidden = false
            retryButton.isHidden = false
            
        case .empty:
            label.text = "Nenhum dado encontrado"
            label.isHidden = false
        }
    }
    
    private func setupTableView() {
        tableView.dataSource = self
    }
    
    @objc private func didTapRetry() {
        viewModel.fetchCoins()
    }
    
}

// MARK: - ViewCode
extension CoinsViewController: ViewCodeProtocol {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }
    
    func setupHierarchy() {
        view.addSubview(tableView)
        view.addSubview(loadingIndicator)
        view.addSubview(label)
        view.addSubview(retryButton)
    }
    
    func setupConstraints() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            label.topAnchor.constraint(equalTo: loadingIndicator.bottomAnchor, constant: 20),
            
            retryButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            retryButton.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 16)
        ])
    }
    
    func setupStyles() {
        label.textAlignment = .center
        retryButton.setTitle("Tentar novamente", for: .normal)
    }

}

// MARK: - UITableViewDataSource
extension CoinsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "cell")
        let coin = coins[indexPath.row]
        
        cell.textLabel?.text = coin.name
        cell.detailTextLabel?.text = "$\(coin.currentPrice)"
        
        return cell
    }
    
}
