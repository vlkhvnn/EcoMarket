import UIKit
import SnapKit

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()

        // Create a UIScrollView
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .gray
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)

        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }

        // Create a UIStackView to hold content horizontally
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false

        // Add content (labels) to the stack view
        for i in 0..<10 {
            let label = UILabel()
            label.text = "Item \(i+1)"
            label.textAlignment = .center
            label.backgroundColor = .blue
            label.widthAnchor.constraint(equalToConstant: 200).isActive = true
            stackView.addArrangedSubview(label)
        }

        scrollView.addSubview(stackView)

        stackView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview()
            make.leading.trailing.equalToSuperview()
            make.height.equalTo(scrollView)
            make.width.equalTo(220 * 10) // Adjust the width as needed
        }
    }
}
