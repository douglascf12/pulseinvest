import UIKit

final class CoinsViewController: UIViewController {
    
    // MARK: - Properties
    private let viewModel: CoinsViewModel
    
    private var coins: [Coin] = []
    
    private let tableView: UITableView = UITableView()
    
    private let stateContainer: UIView = UIView()
    private let stackView: UIStackView = UIStackView()
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
        stateContainer.isHidden = false
        
        switch state {
            
        case .loading:
            loadingIndicator.startAnimating()
            
        case let .success(coins):
            self.coins = coins
            tableView.reloadData()
            tableView.isHidden = false
            stateContainer.isHidden = true
            
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
        tableView.delegate = self
        
        tableView.register(CoinTableViewCell.self, forCellReuseIdentifier: CoinTableViewCell.reuseIdentifier)
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
        view.addSubview(stateContainer)
        
        stateContainer.addSubview(stackView)
        
        stackView.addArrangedSubview(loadingIndicator)
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(retryButton)
    }
    
    func setupConstraints() {
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        stateContainer.translatesAutoresizingMaskIntoConstraints = false
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stateContainer.topAnchor.constraint(equalTo: view.topAnchor),
            stateContainer.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            stateContainer.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            stateContainer.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            stackView.centerXAnchor.constraint(equalTo: stateContainer.centerXAnchor),
            stackView.centerYAnchor.constraint(equalTo: stateContainer.centerYAnchor)
        ])
    }
    
    func setupStyles() {
        stackView.axis = .vertical
        stackView.spacing = 16
        stackView.alignment = .center
        
        label.textAlignment = .center
        retryButton.setTitle("Tentar novamente", for: .normal)
    }

}

// MARK: - UITableViewDataSource + UITableViewDelegate
extension CoinsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coins.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CoinTableViewCell.reuseIdentifier, for: indexPath) as? CoinTableViewCell else {
            return UITableViewCell()
        }
        
        let coin = coins[indexPath.row]
        let viewModel = CoinCellViewModelMapper.map(coin)
        
        cell.configure(with: viewModel)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected", coins[indexPath.row].name)
    }
    
}
