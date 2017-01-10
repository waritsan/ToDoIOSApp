# To-do
A simple to-do app.

## Interfaces
### Model
- ToDoItem
```swift
internal struct ToDoItem : Equatable {
    internal let title: String
    internal let itemDescription: String?
    internal let timestamp: Double?
    internal let location: Location?

    internal init(title: String, itemDescription: String? = default, timestamp: Double? = default, location: Location? = default)
}
internal func ==(lhs: ToDoItem, rhs: ToDoItem) -> Bool
```
- Location
```swift
internal struct Location : Equatable {
    internal let name: String
    internal let coordinate: CLLocationCoordinate2D?

    internal init(name: String, coordinate: CLLocationCoordinate2D? = default)
}
internal func ==(lhs: Location, rhs: Location) -> Bool
```
- ItemManager
```swift
internal class ItemManager {
    internal var toDoCount: Int { get }
    internal var doneCount: Int { get }

    internal func addItem(item: ToDoItem)
    internal func itemAtIndex(index: Int) -> ToDoIOSApp.ToDoItem
    internal func checkItemAtIndex(index: Int)
    internal func doneItemAtIndex(index: Int) -> ToDoIOSApp.ToDoItem
    internal func removeAllItems()
}
```

### ViewController
- ItemListViewCntroller
- DataProvider
- DetailViewController
- InputViewController

- DataProvider consists of DataSource and Delegate of ItemListViewCntroller. They communicate via protocol.

### Test
- Travis CI
