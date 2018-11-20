<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div class="tit_page clear2">
	<h2>동영상 관리</h2>
	
	<div class="location">
		<ul>
		<li>홈</li>
		<li>동영상 데이터 관리</li>
		<li class="loc_this">동영상 데이터 관리</li>
		</ul>
	</div>
</div>
<!--// page title end -->



<div class="cont">

	<!-- full area start -->
	<div class="full_area">
		<div class="type_label01 clear2">
			<!-- 검색 start -->
			<div class="label_01">
				<div class="cont_tit2 sub_tit">미디어 검색</div>
				<div class="cont_gray type_01 clear2" style="position: initial !important;">
					<div class="cont_tit2 ml_5 mt_10 mb_5" style="font-size:12px;">카테고리 : 
					<select id="search_form01"  style="padding : 1px;">
						<option>전체</option>
					</select>
					</div>
					<input type="text" class="white ml_5 mt_5 mb_10" style="width: 74.2%;font-size:12px;padding: 3px;" id="search_form02" placeholder="검색어를 입력해주세요." />
					<a href="#" class="btn_tit_box mt_5 mb_10">검색</a>
				</div>
			</div>
		<!--// 검색 end -->

			<div class="label_02">
				<div class="cont_tit2 sub_tit">미디어 목록</div>
				<table class="tbl_type02">
					<colgroup>
						<col style="width:3%">
						<col style="width:10%">
						<col>
						<col style="width:10%">
						<col style="width:10%">
						<col style="width:20%">
					</colgroup>
					<thead>
						<tr>
							<th scope="col"><input type="checkbox" name="mediaCheckAll" id="mediaCheckAll" value="ALL"/></th>
							<th scope="col">카테고리</th>
							<th scope="col">파일명</th>
							<th scope="col">담당자</th>
							<th scope="col">최종수정일</th>
							<th scope="col">Action</th>
						</tr>
					</thead>
					<tbody>
						<tr>
							<td><input type="checkbox" name="mediaCheck"  value="ALL"/></td>
							<td>개인방송</td>
							<td class="left"><a href="${pageContext.request.contextPath}/media/mediaView.do">쌈바홍의 Q&A 라디오! 근데 항아리게임을 왜 받았냐구요? [쌈바홍ssambahong 트위치] Hong jin young.mp4</a></td>
							<td>super</td>
							<td>2018-10-25</td>
							<td><a href="#" class="btn_td btn_tbl_del">영상삭제</a></td>
						</tr>
						<tr>
							<td><input type="checkbox" name="mediaCheck"  value="ALL"/></td>
							<td>개인방송</td>
							<td class="left"><a href="${pageContext.request.contextPath}/media/mediaView.do">풍월량 록맨11 가즈아~.mp4</a></td>
							<td>super</td>
							<td>2018-10-25</td>
							<td><a href="#" class="btn_td btn_tbl_del">영상삭제</a></td>
						</tr>
					</tbody>
				</table>
				
				<div class="list_info clear2 mt_5">
					<div class="float_l">총 1,223건</div>
					<div class="float_r">1 / 18 페이지</div>
				</div>

				<!-- 페이징 start -->
				<div class="mt_10">
					<ul class="paging">
						<li><a href="#" class="first">&nbsp;</a></li>
						<li><a href="#" class="prev">&nbsp;</a></li>
						<li><a href="#" class="on">1</a></li>
						<li><a href="#">2</a></li>
						<li><a href="#">3</a></li>
						<li><a href="#">4</a></li>
						<li><a href="#">5</a></li>
						<li><a href="#">6</a></li>
						<li><a href="#" class="next">&nbsp;</a></li>
						<li><a href="#" class="last">&nbsp;</a></li>
					</ul>
				</div>
		<!--// 페이징 end -->
			</div>
		</div>
	<!--// full area end -->
	</div>
</div>
