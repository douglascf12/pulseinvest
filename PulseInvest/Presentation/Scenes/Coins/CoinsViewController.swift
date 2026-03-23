import UIKit

final class CoinsViewController: UIViewController {
    
    private let viewModel: CoinsViewModel
    
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView(style: .large)
    private let label: UILabel = UILabel()
    private let retryButton: UIButton = UIButton(type: .system)
    
    init(viewModel: CoinsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        bind()
        viewModel.fetchCoins()
        
        retryButton.addTarget(self, action: #selector(didTapRetry), for: .touchUpInside)
    }
    
    private func bind() {
        viewModel.onStateChange = { [weak self] state in
            self?.render(state)
        }
    }
    
    private func render(_ state: CoinsViewState) {
        loadingIndicator.stopAnimating()
        label.isHidden = true
        retryButton.isHidden = true
        
        switch state {
        case .loading:
            loadingIndicator.startAnimating()
            
        case let .success(coins):
            label.text = "Loaded \(coins.count) coins"
            label.isHidden = false
            
        case let .error(error):
            label.text = error.message
            label.isHidden = false
            retryButton.isHidden = false
            
        case .empty:
            label.text = "Nenhum dado encontrado"
            label.isHidden = false
        }
    }
    
    @objc private func didTapRetry() {
        viewModel.fetchCoins()
    }
    
}

extension CoinsViewController: ViewCodeProtocol {
    
    func setupView() {
        view.backgroundColor = .systemBackground
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }
    
    func setupHierarchy() {
        view.addSubview(loadingIndicator)
        view.addSubview(label)
        view.addSubview(retryButton)
    }
    
    func setupConstraints() {
        loadingIndicator.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        retryButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
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
