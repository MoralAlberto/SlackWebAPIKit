# SlackWebAPIKit

<p align="center">
<a href="https://cocoapods.org/pods/SlackWebAPIKit">
<img src="https://img.shields.io/cocoapods/v/SlackWebAPIKit.svg" alt="CocoaPods" />
</a>
<a href="https://twitter.com/albertmoral">
<img src="https://img.shields.io/badge/contact-@albertmoral-blue.svg?style=flat" alt="Twitter: @albertmoral" />
</a>
</p>


## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

SlackWebAPIKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "SlackWebAPIKit"
```

## Examples

Get users

```swift
getUsers()
.observeOn(MainScheduler.instance)
.subscribe(onNext: { [weak self] users in
guard let strongSelf = self else { return }
strongSelf.buildUsersViewModel(users: users)
}, onError: { error in
print("Error \(error)")
}).disposed(by: disposeBag)
```

Get Channels

```swift
getChannels()
.observeOn(MainScheduler.instance)
.subscribe(onNext: { [weak self] channels in
guard let strongSelf = self else { return }
strongSelf.buildChannelsViewModel(channels: channels)
}, onError: { error in
print("Error \(error)")
}).disposed(by: disposeBag)
```

Get Groups (Private Channels)

```swift
getGroups()
.observeOn(MainScheduler.instance)
.subscribe(onNext: { [weak self] groups in
guard let strongSelf = self else { return }
strongSelf.buildGroupsViewModel(groups: groups)
}, onError: { error in
print("Error \( error)")
}).disposed(by: disposeBag)
```

Get Team Info

```swift
getTeamInfo()
.observeOn(MainScheduler.instance)
.subscribe(onNext: { [weak self] team in
guard let strongSelf = self else { return }
guard let name = team.name else { return }
strongSelf.delegate?.update(team: name)
}, onError: { [weak self] error in
guard let strongSelf = self else { return }
strongSelf.delegate?.update(team: "Error")
}, onCompleted: {
print("Completed")
}).disposed(by: disposeBag)
```

Send Message

```swift
send(message: message, channel: channel, type: type)
.observeOn(MainScheduler.instance)
.subscribe(onNext: { [weak self] isSent in
guard let strongSelf = self else { return }
strongSelf.delegate?.update(notification: "Last message sent to: \(channel)")
}, onError: { [weak self] error in
guard let strongSelf = self else { return }
strongSelf.delegate?.update(notification: "Error trying to send the message")
}).disposed(by: disposeBag)
```

## Author

MoralAlberto, alberto.moral.g@gmail.com

## License

SlackWebAPIKit is available under the MIT license. See the LICENSE file for more info.
