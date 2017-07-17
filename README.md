# ResidenceManager

WIP

# Get Started to Develop

```console
$ git clone git@github.com:ginpei/ResidenceManager.git
$ cd ResidenceManager
$ cp ResidenceManager/keys.example.plist ResidenceManager/keys.plist
```

Then edit the file `ResidenceManager/keys.plist`. You can find and edit it using Xcode.

## Access to the values

```swift
let keys = NSDictionary(contentsOfFile: Bundle.main.path(forResource: "keys", ofType: "plist")!)!
let name = "OneOfSecretKeys"
let value = keys[name]!
print(value)
```
