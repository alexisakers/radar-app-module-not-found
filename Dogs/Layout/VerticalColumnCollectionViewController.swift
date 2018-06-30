import UIKit

/**
 * The number of columns to display depending on the width of the view.
 */

struct AdaptiveColumnLayout {

    /// The number of columns in compact horizontal size class.
    let compact: Int

    /// The number of columns in regular horizontal size class, for screens
    /// smaller than 1024pt.
    let regular: Int

    /// The number of columns in regular horizontal size class, for screens
    /// larger than 1024pt.
    let large: Int

}

/**
 * An abstract collection view container that allows displaying the cells into columns.
 *
 * You must implement the `collectionView(_:, sizeOfItemAt:)` method in your subclasses.
 */

class VerticalColumnCollectionViewController: UICollectionViewController, VerticalColumnCollectionViewLayoutDelegate {

    fileprivate let layout: VerticalColumnCollectionViewLayout
    fileprivate let columnLayout: AdaptiveColumnLayout

    /**
     * Creates the view controller.
     * - parameter interItemSpacing: The spacing between items in the same column.
     * - parameter interColumnSpacing: The spacing between columns.
     * - parameter columnLayout: The layout of the columns depending on the current size class.
     */

    init(interItemSpacing: CGFloat, interColumnSpacing: CGFloat, columnLayout: AdaptiveColumnLayout) {
        layout = VerticalColumnCollectionViewLayout()
        layout.interItemSpacing = interItemSpacing
        layout.interColumnSpacing = interColumnSpacing

        self.columnLayout = columnLayout
        super.init(collectionViewLayout: layout)
        layout.delegate = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - View lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        updateLayout()
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        coordinator.animate(alongsideTransition: { (context) in
            self.updateLayout(for: size)
        })
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.updateLayout()
    }

    // MARK: - Size Changes

    /**
     * Whether the current layout is in regular mode.
     *
     * The default implementation returns `true` if the horizontal size class of the view
     * is regular. You can override this method for testing purposes.
     */

    var isRegularLayout: Bool {
        return view.traitCollection.horizontalSizeClass == .regular
    }

    /**
     * Updates the layout of the view in response to a size change.
     *
     * - parameter size: The current size of the view. Defaults to the size of the view's bounds.
     *
     * You can override this method if you need to perform other layout updates when the
     * size of the view changes.
     */

    func updateLayout(for size: CGSize? = nil) {
        layout.numberOfColumns = numberOfColumns(inContainer: size?.width ?? view.bounds.width)
        layout.invalidateLayout()
        navigationItem.titleView?.setNeedsLayout()
    }

    private func numberOfColumns(inContainer width: CGFloat) -> Int {
        if isRegularLayout {
            return width < 1024 ? columnLayout.regular : columnLayout.large
        }
        return columnLayout.compact
    }

    // MARK: - Sizing

    func collectionView(_ collectionView: UICollectionView, sizeOfItemAt indexPath: IndexPath) -> CGSize {
        fatalError("Subclasses of 'VerticalColumnCollectionViewController' must implement this method.")
    }

}
