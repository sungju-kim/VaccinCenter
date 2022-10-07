# VaccinCenter

## 구현사항

- [x] 페이지네이션 구현
- [x] updateAt 기준 내림차순 정렬
- [x] 아이템 선택시 디테일 화면 이동
- [x] 선택한 아이템 정보 출력
- [x] 사용자 위치, 접종센터 마커 표시

## 실행화면

| 리스트화면                                                   | 사용자 위치 기반 가까운 센터 정렬                            | 위치정보 권한 미보유 알림                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://user-images.githubusercontent.com/78553659/194595534-5316c924-97e9-4071-bf88-327c40a3fdb9.gif) | ![](https://user-images.githubusercontent.com/78553659/194639260-0a092d2b-ce52-4c4d-94a1-2e83b542ddb3.gif) | ![](https://user-images.githubusercontent.com/78553659/194639041-b59634e9-7e2d-4bca-b1d6-9c8f27aac49a.gif) |



| 상세화면                                                     | 현재위치로, 센터위치로 이동                                  | 위치정보 접근 권한 재요청                                    |
| ------------------------------------------------------------ | ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://user-images.githubusercontent.com/78553659/194595571-b1d24f99-c60c-404d-ae38-ba4bcee39580.gif) | ![](https://user-images.githubusercontent.com/78553659/194596019-0c2c575a-b109-4bcc-ab05-14d28b14a1ad.gif) | ![](https://user-images.githubusercontent.com/78553659/194597093-f2e2bad2-bce7-4c2a-a614-4fdd53d9728a.gif) |



## 트러블 슈팅

<details>
<summary>CenterListCell의 Label</summary>


### 문제

1. `CenterListCell`의 경우 `titleStackView` + `informationStackView`로 이루어져 있고, `informationStack`의 Label의 크기가 클경우 `titleStackView`의 Label이 깨지는 문제 발생
2. `titleStackView`의 경우 컴파일시점에 text가 정해지고, `informationStackView`의 경우 런타임에 text가 정해지기에 각 cell마다 stackView의 크기가 다른 문제 발생

### 고민

1. `UIStackView`를 사용하지 않고 라벨별로 각각 레이아웃 잡기
   - 표시해야할 정보가 늘어나면 작성해야할 코드가 상대적으로 많아짐
2. `titleStackView`크기를 고정 시키고 cell의 나머지 부분을 `informationStackView`로 채우기
   - `informationStackView`에 들어가는 text값이 길어질수록 나머지 부분이 생략됨
   - `Label.numberOfLines = 0`으로 Label의 정보를 표시해보았지만 각 cell별로 크기가 달라져 사용자 경험 저하 우려

### 해결방안

`DetailView`로 이동시 해당 센터의 정보를 모두 표시하기에 `ListView`에서는 간략히 표시하기로 결정

### 구현

- `titleStackView`에 들어가는 Label의 `huggingPriority = 251`, `compresstionReststancePriority = 1000` 으로 주어 `titleStackView`의 경우 Label이 생략되지않고 모두 표시할 수 있도록 구현
  </details>

<details>
<summary>Pagination</summary>


### 문제

1.  RxSwift의 ControllEvent로 Cell을 그려주기에 `UITableViewDelegate`를 사용할 수 없어 `TableViewCell`의 마지막 Cell을 그리는 시점을 찾기 어려움

### 고민

1. `UITableViewDataSource` + `UITableViewDelegate`를 활용한 코드로 변경
   - 변경해야할 코드가 많아짐
2. `UIScrollViewDelegate`활용
   - 추가적으로 선언해줘야할 변수가 많아지고 가독성이 떨어짐 우려
3. `CustomControlEvent`활용
   - 로직 구현 어려움

### 해결방안

가독성과 편의성을 고려하여 `CustomControlEvent`활용하는 방법으로 결정

### 구현

- `UIScrollView`가 scroll될때 `contentSize.height`(스크롤뷰의 세로길이) - `frame.height` (보여지는 부분) 보다 `contentOffset.y`가 커질때 이벤트를 발생
- 이벤트가 여러번 반복되지 않도록 `.distincUntilChanged`를 활용하여 이전 값과 값이 다를때만 반환

</details>

<details>
<summary>DetailView</summary>


### 문제

1.  각 Information이 담긴 뷰 타입에 대한 고민

### 고민

1. `CustomView` + `UIStackView` 활용
   - StackView의 경우 런타임에 subView의 `intrinsicContentSize`에 맞춰 크기가 바뀌며 View에 들어가는 Image와 Label의 크기가 달라서 고정된 크기의 뷰를 보여주기 어려움
   - StackView의 레이아웃을 직접 잡아서 그릴수 있지만, 새로운 정보의 뷰가 추가될때 변경이 어려움

2. `UICollectionView` + `CompositionalLayout` 활용
   - cell안의 subView 레이아웃만 잡으면 각 cell 마다 동일한 위치에 해당 정보 표시 가능
   - 새로운 정보의 뷰가 추가될때 'dataSource`에 값만 추가하고 사용가능
   - 새로운 레이아웃이 필요할때 `groupSize`만 조정하여 레이아웃 변경가능

### 해결방안

`UICollectionView` + `CompositionalLayout` 활용


</details>

<details>
<summary>Center의 각 파라미터값을 각 InformationViewModel에 전달</summary>


### 문제

1. `Center`의 각 파라미터의 `title`값과 `value`값을 InformationCell에 넘겨주어야함

### 고민

1. cell에 직접 `title`에 해당하는 String과 `value`에 해당하는 String을 전달
   - Information이 추가될때마다 작성해야할 코드가 많아짐.

2. `Center`의 파라미터 타입을 `Information`타입으로 통일 및 Dictionary활용 ([InformationType: Information])
   - 변경할 코드가 많아지지만, 해당 타입과 `value`에 접근 용이
   - 런타임마다 Information의 순서가 변경되어 사용자경험 저하 우려

3. `InformationType` + `CaseIterable` 활용
   - 변경해야할 코드가 줄어듬
   - `InformationType.allcases`를 활용하여 새로운 Information이 추가되어도 작성할 코드 현저히 줄어듬
   - `Center`를 통한 `InformationViewModel`생성로직이 다소 복잡해짐

### 해결방안

`InformationType` + `CaseIterable` 활용

### 구현

`InformationType.title`로 해당 Information 타입에 대한 title 저장 (센터명, 빌딩명 등)
`Center`의 `value(for type: InformationType)`메소드로 해당 타입에 대한 value값 반환
`title`+`value`정보로 `[InformationViewModel]`생성 및 collectionView의 dataSource로 활용

</details>

<details>
<summary>UIRefreshContorl을 활용하여 refresh시 사용자 위치기준 가까운순으로 정렬 </summary>

### 문제

1. 사용자 위치 권한 `alert`, 권한 요구 `alert` present시 `refrechControl`애니메이션이 정지하는 현상 발생

### 고민

1. `alert`와 동시에 `refreshContorl.endRefreshing()`이 실행되어 `refreshContorl`이 반응하지 않음
   - `DispatchQueue.main.async`를 활용해보았으나 현상 동일

### 해결방안

1. `alert` 대신 `UILabel`을 이용하여 알림

### 구현

`toastLabel`을 생성하여 `alpha = 0`으로 만들어준후 알림이 필요할때 `alpha=1`로 변경후 `UIView.animate`메소드를 이용하여 `toastLabel`의 `alpha`값을 0으로 만들어주는 방식으로 구현
</details>

## 필요 개선사항

- `refreshControl`기능을 구현하면서 `CenterListViewModel`과 `LocationRepositoryImpl` 두 객체의 가독성이 떨어짐
- Network 로직에 대한 error 핸들링 필요

