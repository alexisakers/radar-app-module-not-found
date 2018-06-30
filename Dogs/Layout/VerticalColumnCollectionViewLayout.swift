import UIKit

protocol VerticalColumnCollectionViewLayoutDelegate: class {
    func collectionView(_ collectionView: UICollectionView, sizeOfItemAt indexPath: IndexPath) -> CGSize
}

/**
 * A collection view layout that displays its contents within multiple columns.
 */

class VerticalColumnCollectionViewLayout: UICollectionViewLayout {

    // MARK: - Configuration

    /// The object providing size information to the layout.
    weak var delegate: VerticalColumnCollectionViewLayoutDelegate?

    /// The number of columns to use to organize the content.
    var numberOfColumns: Int = 1 {
        didSet {
            invalidateLayout()
        }
    }

    /// The spacing between columns.
    var interColumnSpacing: CGFloat = 10 {
        didSet {
            invalidateLayout()
        }
    }

    /// The spacing between two items in the same column.
    var interItemSpacing: CGFloat = 10 {
        didSet {
            invalidateLayout()
        }
    }

    // MARK: - Properties

    /// The cached layout attributes.
    fileprivate var cache = [UICollectionViewLayoutAttributes]()

    /// The height of the represented content.
    fileprivate var contentHeight: CGFloat = 0

    /// The width of the collection container.
    fileprivate var contentWidth: CGFloat {
        guard let collectionView = self.collectionView else {
            return 0
        }

        let insets = collectionView.contentInset
        return collectionView.bounds.width - (insets.left + insets.right)
    }

    override var collectionViewContentSize: CGSize {
        return CGSize(width: contentWidth, height: contentHeight)
    }

    // MARK: - Layout

    override func prepare() {

        guard cache.isEmpty == true, let collectionView = collectionView else {
            return
        }

        // Calculate the offset of every column
        let columnWidth = contentWidth / CGFloat(numberOfColumns)

        let xOffset = (0 ..< numberOfColumns).map { CGFloat($0) * columnWidth }
        var yOffset: [CGFloat] = Array(repeating: 0, count: numberOfColumns)

        // Separate the items by column

        var currentColumn: Int = 0

        for i in 0 ..< collectionView.numberOfItems(inSection: 0) {

            let indexPath = IndexPath(row: i, section: 0)

            // Get the size of the item
            let itemSize = delegate?.collectionView(collectionView, sizeOfItemAt: indexPath) ?? .zero
            let itemHorizontalSpacing = currentColumn == 0 ? 0 : interColumnSpacing
            let itemVerticalSpacing = cache.count < numberOfColumns ? 0 : interItemSpacing

            let adjustedWidth = columnWidth - itemHorizontalSpacing
            let adjustedHeight = ((itemSize.height * adjustedWidth) / itemSize.width)

            let frame = CGRect(x: xOffset[currentColumn], y: yOffset[currentColumn],
                               width: adjustedWidth, height: adjustedHeight)

            let positionTransform = CGAffineTransform(translationX: itemHorizontalSpacing,
                                                      y: itemVerticalSpacing)

            let insetFrame = frame.applying(positionTransform)

            // Create the attributes
            let attributes = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            attributes.frame = insetFrame
            cache.append(attributes)

            // Update the state
            contentHeight = max(contentHeight, insetFrame.maxY)
            yOffset[currentColumn] = insetFrame.maxY

            // Move to the next column
            let next = currentColumn + 1
            currentColumn = next < numberOfColumns ? next : 0

        }

    }

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cache.filter { $0.frame.intersects(rect) }
    }

    override func layoutAttributesForItem(at indexPath: IndexPath) -> UICollectionViewLayoutAttributes? {
        return cache[indexPath.item]
    }

    // MARK: - Invalidation

    override func invalidateLayout() {
        cache = []
        super.invalidateLayout()
    }

}
