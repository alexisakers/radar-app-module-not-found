import UIKit

/**
 * A view controller that displays dogs in columns.
 */

class DogsViewController: VerticalColumnCollectionViewController {

    /// The dogs to display.
    let dogs: [Dog]

    // MARK: - Initialization

    init(dogs: [Dog], breed: String) {
        self.dogs = dogs
        let layout = AdaptiveColumnLayout(compact: 2, regular: 3, large: 4)
        super.init(interItemSpacing: 1, interColumnSpacing: 1, columnLayout: layout)
        self.title = breed
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = .white
        collectionView?.register(ImageCollectionViewCell.self, forCellWithReuseIdentifier: "dog")
    }

    // MARK: - Collection View

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dogs.count
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let dog = dogs[indexPath.row]

        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "dog", for: indexPath) as! ImageCollectionViewCell
        cell.imageView.image = dog.image

        return cell
    }

    override func collectionView(_ collectionView: UICollectionView, sizeOfItemAt indexPath: IndexPath) -> CGSize {
        return dogs[indexPath.row].imageSize
    }

}
