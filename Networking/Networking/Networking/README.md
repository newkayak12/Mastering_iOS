#  NETWORK
*** ip주소, 네트워크 인터페이스가 바뀌는 경우가 많음 + 보안 문제가 있음
- 애플의 가이드
> Use High-Level APIs
> Transfer only as much data as required
> Use Caches
> Use Asynchronous APIs
> Use Hostnames
> Use HTTPS(IPV4  관련 사용을 삼가야한다.)


## URLSession  
> API Request
> File Transfer
> Authentication

--> Shared Session( Default Configuration + Completion Handler)
--> Default Session ( Default Configuation/Custom Configuration + Completion Handler/Deletagtion + Response Caching(Disk&Memory))
--> Ephemeral Session ( Default Configuation/Custom Configuration + Completion Handler/Deletagtion + Response Caching(Memory ONLY))
--> Background Sessions ( Default Configuration/Custom Configuartion + Delegation + Background Transfer)

DataTask // Download/UploadTask // Stream Task

```swift
URLSession.shared ..Task(...)
-> Task는 Suspended 상태로 만들어짐 resume()을 해야 함 
```

- 서버에서 전달된 데이터를 처리하는 방법 
1. CompletionHandler
        OR
2. SessionDelegate 
 
## WebKit
> Display web contents
> Browser Feature
> Script Injection

## GameKit
> Bluetooh, Wifi lan connection
> Game Cetner Integration
> Voice Chat

## MultipeerConnectivity
> Wifi
> Peer-to-Peer Wifi
> Bluetooh Personal Area Network

## Boujour
> Automactic discover of devices and services
> on a local network

##CFNetwork(socket)
> Access network services
> Handle changes in network configuartions

##Network(iOS 12+)
> Direct acess to TLS, TCP, and UDP



##ATS KEYS
NSAppTransportSecurity: Dictionary {
    NSAllowsArbitarryLoads: Boolean, //ATS 활성화 상태 ✓
    NSAloowsArbitaryLoadsForMedia: Boolean, //미디어 요청에 대해서 안전하지 않은 연결 허용 ✓
    NSAloowsArbitaryLoadsInWebContents: Boolean, //webview에서 http 요청을 허용할 때 ✓
    NSAllowsLocalNetworking: Boolean //로컬 네트워크 접속을 허용할 때
    NSExceptionDomains: Dictionary { //특정 도메인에 대한 
        <domain-name-string> : Dictionary {
            NSIncludesSubdomains: Boolean, //서브 도메인 포함여부 
            NSExceptionAllowsInsecureHTTPLoads: Boolean, //HTTP 연결을 허용할 때 (전역설정이 아닌 특정도메인만) ✓
            NSExceptionMinimumTLSVersion: String, //보안 ✓
            NSEceptionRequiresForwardSecrecy: Boolean, 
            NSRequestCertificateTransparency: Boolean
        }
    }
}

    ✓는 심사에 마이너스가 되는 요인들 -> 가능한 사용하지 않는게 좋고 사용한다면 정당한 사유가 있어야함
