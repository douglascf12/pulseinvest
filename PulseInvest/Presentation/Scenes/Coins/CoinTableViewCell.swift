import UIKit

final class CoinTableViewCell: UITableViewCell {
    
    static let reuseIdentifier: String = "CoinsTableViewCell"
    
    private let leftStack: UIStackView = UIStackView()
    private let rightStack: UIStackView = UIStackView()
    private let containerStack: UIStackView = UIStackView()
    
    private let iconImageView: UIImageView = UIImageView()
    private let nameLabel: UILabel = UILabel()
    private let symbolLabel: UILabel = UILabel()
    private let priceLabel: UILabel = UILabel()
    private let changeLabel: UILabel = UILabel()
    
    // MARK: Init
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Configure
    func configure(with viewModel: CoinCellViewModel) {
        
        nameLabel.text = viewModel.name
        symbolLabel.text = viewModel.symbol
        priceLabel.text = viewModel.price
        changeLabel.text = viewModel.change
        changeLabel.textColor = viewModel.changeColor
        
        // simple image (placeholder)
        iconImageView.backgroundColor = .systemGray5
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        iconImageView.image = nil
        nameLabel.text = nil
        symbolLabel.text = nil
        priceLabel.text = nil
        changeLabel.text = nil
    }
}

// MARK: - ViewCode
extension CoinTableViewCell: ViewCodeProtocol {
    
    func setupView() {
        setupHierarchy()
        setupConstraints()
        setupStyles()
    }
    
    func setupHierarchy() {
        contentView.addSubview(containerStack)
        
        leftStack.addArrangedSubview(nameLabel)
        leftStack.addArrangedSubview(symbolLabel)
        
        rightStack.addArrangedSubview(priceLabel)
        rightStack.addArrangedSubview(changeLabel)
        
        containerStack.addArrangedSubview(iconImageView)
        containerStack.addArrangedSubview(leftStack)
        containerStack.addArrangedSubview(rightStack)
    }
    
    func setupConstraints() {
        
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            containerStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            containerStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12)
        ])
    }
    
    func setupStyles() {
        
        containerStack.axis = .horizontal
        containerStack.spacing = 12
        containerStack.alignment = .center
        
        leftStack.axis = .vertical
        leftStack.spacing = 4
        
        rightStack.axis = .vertical
        rightStack.spacing = 4
        rightStack.alignment = .trailing
        
        iconImageView.widthAnchor.constraint(equalToConstant: 40).isActive = true
        iconImageView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
        nameLabel.font = .systemFont(ofSize: 16, weight: .semibold)
        symbolLabel.font = .systemFont(ofSize: 12)
        symbolLabel.textColor = .secondaryLabel
        
        priceLabel.font = .systemFont(ofSize: 14, weight: .medium)
        changeLabel.font = .systemFont(ofSize: 12)
    }
    
}
