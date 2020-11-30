/// A Generic struct used to help in setting cells and views in a tableView
struct TableViewSection {
    public var headerItem: HeaderFooterDisplayable?
    public var items: [CellDisplayable]
    public var footerItem: HeaderFooterDisplayable?

    init(
        headerItem: HeaderFooterDisplayable? = nil,
        items: [CellDisplayable],
        footerItem: HeaderFooterDisplayable? = nil
    ) {
        self.headerItem = headerItem
        self.items = items
        self.footerItem = footerItem
    }
}
