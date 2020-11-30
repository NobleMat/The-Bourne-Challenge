# The-Bourne-Challenge

## About

### Architecture

The project makes use of a protocol based MVP architecture. This ensures that the everything that is given to the viewController can be tested and made sure that the correct values are sent and set. 

### Accessibility

This project also make sure the the project can show a larger font if needed. And does cater for Dark mode.

---

## Tools used

This project makes use of SwiftFormat and SwiftLint. To install each of them follow the following steps

### 1. Formatter

The application uses [SwiftFormat](https://github.com/nicklockwood/SwiftFormat) as the primary formatter. To set it up use `Homebrew` and run the following command.

``` bash
$ brew install swiftformat
```

Once done, check if the installation is successful by building the project, it should not have a `swiftFormat not found error`.


### 2. Linter

The application uses [SwiftLint](https://github.com/realm/SwiftLint) as the primary linter. To set it up use `Homebrew` and run the following command.

``` bash
$ brew install swiftlint
```

Once done, check if the installation is successful by building the project, it should not have a `swiftLint not found error`.

---

## Libraries Used

1. ### Alamofire

    Alamofire is used for fetching data from a server

2. ### Kingfisher

    Kingfisher is used for async downloading and caching images
