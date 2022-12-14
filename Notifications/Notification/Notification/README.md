# Notification

1. Notification (Authorization Not Required)
```Swift

<Foundation> 
객체 간의 통신
Sender -> Notification Center(Singletone)_NSNotifiationCenter -> Observer

Forground: ✅ Background: ✅ NotRunning: ❎
```

///UserNotification(iOS 10 +) Authorization Required
2. Local Notification
```swift
하나의 앱에서 지역적으로 사용할 수 있는 (타이머와 같은)
UserNotificationCenter에 스케쥴링, Deliver

Forground: ✅ Background: ✅ NotRunning: ✅
```

3. Remote Nofication
```
(Push인증서를 가지고 ) -> Apple Developer 가입되어야
Provider ->(JSON) -> Apple Notification Center(APNs) -> Device

Forground: ✅ Background: ✅ NotRunning: ✅
``
