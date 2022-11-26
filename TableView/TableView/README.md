#  TableView

수직으로 이어짐
cell의 너비는 tableView의 너비와 같다. 
스크롤 방향도 수직이다.

가로 방향은 CollectionView가 따로 있다.
tableView는 section을 가질 수 있고 그 안에 Cell을 가질 수 있다.

셀의 위치는 section의 index, cell의 index로 관리된다( 이차원 배열 )
index 처리에는 indexPath를 가지고 처리한다. 

tableView는 groupedStyle(여백으로 구분 사이에 텍스트 출력 가능),
            plainStyle(여백으로 구분 없음 헤더/푸터(label)로 구분 floating, sticky가 혼합된 상태),
             
