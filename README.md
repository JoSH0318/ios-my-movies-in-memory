# 🎬 MyMoviesInMemory

- [App 소개](#app-소개)
- [팀원](#팀원)
- [실행화면](#실행화면)
- [라이브러리](#라이브러리)
- [Architecture](#app-구조)

---

## 📌App 소개
`MyMoviesInMemory`은 사용자가 본 영화를 티켓 형태로 기록하고, 평점과 감상평을 저장할 수 있는 기능을 제공합니다. 사용자는 영화를 보고 난 후, 이 앱을 사용하여 영화에 대한 자신만의 평가와 감상을 기록할 수 있습니다.

이 앱은 사용자가 저장한 영화들을 티켓 형태로 보여줍니다. 
사용자는 자신이 저장한 영화들을 티켓으로 관리하면서, 언제든지 해당 영화에 대한 자신의 평가와 감상평을 확인할 수 있습니다.

또한, 사용자는 저장된 영화들을 검색하여 찾아볼 수 있습니다. 이 앱은 영화 검색 기능을 제공하여, 새로 감상한 영화를 찾고, 새로운 감상평을 저장할 수 있습니다.

이러한 기능을 제공하는 `MyMoviesInMemory`은 영화를 좋아하는 사용자들에게 큰 도움을 줄 것입니다.

---

## 📌팀원

|<img src="https://i.imgur.com/gTVUCZs.jpg" height="250">|
|:---:|
|[mmim](https://github.com/JoSH0318)|

---

## 📌실행화면
|홈 - 티켓 화면|리뷰 상세화면|리뷰 수정|
|:---:|:---:|:---:|
|<img src="https://i.imgur.com/Kb4eFFF.gif" width="200">|<img src="https://i.imgur.com/onrx7i0.gif" width="200">|<img src="https://i.imgur.com/dqxAWqi.gif" width="200">|

|검색|검색 상세화면|영화 등록|
|:---:|:---:|:---:|
|<img src="https://i.imgur.com/iqPf68F.gif" width="200">|<img src="https://i.imgur.com/MMbUq5M.gif" width="200">|<img src="https://i.imgur.com/koxAtAs.gif" width="200">|

|삭제|별점 기능|
|:---:|:---:|
|<img src="https://i.imgur.com/x7lUdYg.gif" width="200">|<img src="https://i.imgur.com/C6LGdyO.gif" width="200">|


---

## 📌라이브러리
![Swift](https://img.shields.io/static/v1?label=&message=RxSwift&color=green) ![Swift](https://img.shields.io/static/v1?label=&message=RxCocoa&color=yellow) ![Swift](https://img.shields.io/static/v1?label=&message=RxDataSource&color=red) ![Swift](https://img.shields.io/static/v1?label=&message=SnapKit&color=blue)

---

## 📌App 구조

### 🌲파일트리 
<details><summary>펼쳐보기</summary>
    
```
MyMoviesInMemory
├── Application
│   ├── Coordinator
│   │   ├── Coordinator
│   │   └── AppCoordinator
│   ├── AppDelegate
│   └── SceneDelegate
│
├── Data
│   ├── ResponseModel
│   │   └── Network
│   │       ├── MoviewResponse
│   │       ├── MoviewResult
│   │       ├── MoviewDetailResponse
│   │       ├── CreditsResponse
│   │       ├── MovieOfficial
│   │       └── GenreID
│   ├── Network
│   │   ├── NetworkProvider
│   │   └── NetworkError
│   ├── CoreData
│   │   ├── CoreDataError
│   │   ├── CoreDataManager
│   │   └── CoreDataModel
│   └── Repository
│       ├── MovieRepository
│       └── ReviewRepository
│
├── Domain
│   ├── Interface
│   │   ├── NetworkRepository
│   │   └── CoreDataRepository
│   ├── Entity
│   │   ├── Movie
│   │   ├── MovieDetail
│   │   └── Review
│   └── UseCases
│       ├── Protocol
│       │   ├── MovieUseCaseType
│       │   └── ReviewUseCaseType
│       ├── MovieUseCase
│       └── ReviewUseCase
│
├── Presentation
│   ├── Common
│   │   ├── Protocol
│   │   ├── View
│   │   ├── ViewModel
│   │   ├── Alert
│   │   └── CollectionLayout
│   ├── Home
│   │   ├── Coornator
│   │   │   └── HomeCoordinator
│   │   ├── View
│   │   │   ├── HomeView
│   │   │   ├── HomeViewController
│   │   │   └── Cell
│   │   │       ├── View
│   │   │       │   ├── ReviewCell
│   │   │       │   └── TicketView
│   │   │       └── ViewModel
│   │   │           ├── ReviewCellViewModel
│   │   │           ├── ReviewCellViewModelItem
│   │   │           └── ReviewSection
│   │   └── ViewModel
│   │       └──HomeViewModel
│   ├── ReviewDetail
│   │   ├── Coornator
│   │   │   └── ReviewDetailCoordinator
│   │   ├── View
│   │   │   ├── ReviewDetailView
│   │   │   └── ReviewDetailViewController
│   │   └── ViewModel
│   │       ├── ReviewDetailViewModel
│   │       └── ReviewDetailViewModelItem
│   ├── Modification
│   │   ├── Coornator
│   │   │   └── ModificationCoordinator
│   │   ├── View
│   │   │   └── ModificationViewController
│   │   └── ViewModel
│   │       └── ModificationViewModel
│   ├── Search
│   │   ├── Coornator
│   │   │   └── SearchCoordinator
│   │   ├── View
│   │   │   ├── SearchViewController
│   │   │   └── Cell
│   │   │       ├── View
│   │   │       │   └── SearchCell
│   │   │       └── ViewModel
│   │   │           ├── SearchCellViewModel
│   │   │           ├── SearchCellViewModelItem
│   │   │           └── MovieSection
│   │   └── ViewModel
│   │       └──SearchViewModel
│   ├── SearchDetail
│   │   ├── Coornator
│   │   │   └── SearchDetailCoordinator
│   │   ├── View
│   │   │   ├── SearchDetailView
│   │   │   └── SearchDetailViewController
│   │   └── ViewModel
│   │       ├── SearchDetailViewModel
│   │       └── SearchDetailViewModelItem
│   └── Record
│       ├── Coornator
│       │   └── RecordCoordinator
│       ├── View
│       │   └── RecordViewController
│       └── ViewModel
│           └── RecordViewModel
│    
├── Util
├── Resource
└── Legacy
```
    
</details> 

### 🏗️Architecture(Clean Architecture + MVVM)

<img src="https://i.imgur.com/AjjPSp9.png" width="700">

#### Clean Architecture
이전 프로젝트를 경험하면서 그 규모가 커질수록 기능 확장에 어려움을 느꼈다. 객체간의 관계가 복잡하기 때문에 객체의 수정/추가에 따라 다른 객체에 영향을 미치는 경우가 많았다. 따라서 이를 개선하기 위해 Clean Architecture를 적용했다. 이를 통해 몇가지 이점을 얻을 수 있었다.

1. 유지보수성 향상: 코드가 각각 독립된 레이어로 분리되기 때문에 한 레이어의 변경이 다른 레이어에 영향을 미치지 않는다는 것을 보장받을 수 있다.
2. 확장성: 새로운 기능을 추가하거나 기존 기능을 변경할 때, 한 레이어의 변경이 다른 레이어에 영향을 미치지 않기 때문에 앱의 확장성이 용이하다.
3. 개발 생산성 향상: 한 레이어는 다른 레이어에 영향을 미치지 않기 때문에 각 레이어는 독립적으로 작업할 수 있다. 따라서 여러 개발자가 동시에 작업할 때 코드 충돌이나 혼란을 방지할 수 있다.

#### MVVM
ViewController가 거대해지는 것을 피하고, 비지니스 로직을 분리함으로서 역할을 명확히 나누고자 했다. 때문에 아래와 같은 이점을 얻을 수 있다.

1. 코드 분리: MVVM은 앱의 데이터 모델(Model)과 비즈니스 로직을 뷰(View)와 분리한다. 이로 인해 코드를 유지 보수하기 쉬워진다.
2. 테스트 용이성: View와 ViewModel이 분리되어 있으므로 ViewModel의 기능을 단위 테스트할 수 있다.
3. 재사용성: ViewModel은 여러 View에서 재사용될 수 있다. 이로 인해 코드의 재사용성이 높아진다.
4. 비즈니스 로직 중심: MVVM은 비즈니스 로직을 중심으로 구성된다. 앱의 로직을 간단하게 유지하면서도 코드를 효율적으로 구성할 수 있도록 도와준다.
5. 데이터 바인딩: MVVM은 데이터 바인딩을 사용하여 뷰와 ViewModel을 연결한다. 이를 통해 뷰는 ViewModel에서 데이터를 가져와 직접 업데이트할 수 있으므로 코드가 간결해지고, UI 업데이트가 더욱 빠르고 안정적으로 이루어진다.

---
