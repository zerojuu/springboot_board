package data.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.GuestDto;
import data.mapper.GuestMapper;

@Controller
public class GuestController {

	@Autowired
	GuestMapper mapper;
	
	
	@GetMapping("/guest/list")
	public ModelAndView list(
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		int totalCount=mapper.getTotalCount();
		
////////////페이징처리에 필요한 변수		
	int totalPage; //총페이지수
	int startPage; //각블럭의 시작페이지
	int endPage; //각블럭의 끝페이지
	int start; //각페이지의 시작번호
	int perPage=5; //한페이지에 보여질 글의개수
	int perBlock=5; //한페이지에 보여지는 페이지 개수
	
	//총페이지개수구하기
	totalPage=totalCount/perPage+(totalCount%perPage==0?0:1);

	//각블럭의 시작페이지
	//예: 현재페이지:3 startPage:1, endpge=5 
	//예: 현재페이지:6 startPage:6, endpge=10
	startPage=(currentPage-1)/perBlock*perBlock+1;

	endPage=startPage+perBlock-1;

	//만약 총페이지 수가 8일경우 
	//2번재 블럭은 st:6 endPage:10이 되야한다
	//이때는 endPage를 8로 수정해 주어야 한다
		if(endPage>totalPage)
			endPage=totalPage;

	//각페이지에서 불러올시작번호
	//현재페이지가  1 일경우 start는 1,2일경우 6....
	start=(currentPage-1)*perPage;

	//각페이지에서 필요한 게시글 가져오기
	HashMap<String, Integer> map=new HashMap<String, Integer>();
	map.put("start", start);
	map.put("perPage", perPage);
	
	List<GuestDto> list=mapper.getList(map);		
	
	//각글앞에 붙힐 시작번호 구하기
	//총글이 20개일겨웅 1페이지 20,2페이지 15부터
	//출력해서 1씩 감소해가면서 출력할것
	int	no=totalCount-(currentPage-1)*perPage;
		
	//출력에 필요한 변수들을 request 에 저장
	model.addObject("list",list);
	model.addObject("startPage",startPage);
	model.addObject("endPage",endPage);
	model.addObject("totalPage",totalPage);
	model.addObject("totalCount",totalCount);
	model.addObject("no",no);
	model.addObject("currentPage",currentPage);
///////////////////////////////
		
		model.setViewName("/guest/guestlist");
		return model;
	}
	
	@PostMapping("/guest/insert")
	public String insert(
			@RequestParam ArrayList<MultipartFile> photos,
			@ModelAttribute GuestDto dto,
			HttpSession session
			) {
		//사진 업로드 폴더
		String path=session.getServletContext().getRealPath("/photo");
		
		//업로드 파일명
		//업로드 안할 경우 파일명 null
		String photo="";
		
		if(photos.get(0).getOriginalFilename().equals(""))
			photo="null";
		else {
			//업로드한 경우
			for(MultipartFile f:photos)
			{
				String fName=f.getOriginalFilename();
				photo+=fName+",";
					
			//실제업로드
			try {
				f.transferTo(new File(path+"\\"+fName));
			} catch (IllegalStateException | IOException e) {
			}
		}
		photo=photo.substring(0, photo.length()-1);
		}		
		//insert
		dto.setPhoto(photo);
		mapper.insertGuest(dto);
		
		return "redirect:list";
	}
}
