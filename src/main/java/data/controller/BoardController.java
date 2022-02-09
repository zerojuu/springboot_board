package data.controller;

import java.io.File;




import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import data.dto.BoardDto;
import data.mapper.BoardMapper;
import data.mapper.MemberMapper;
import data.service.BoardAnswerService;
import data.service.BoardService;


@Controller
public class BoardController {

	@Autowired
	//BoardMapper mapper;
	BoardService service;  //mapper를 service가 받고, service를 controller에서 받음
	
	@Autowired
	//여기에 이름 있기에 content에서 필요
	MemberMapper memMapper;
	
	@Autowired
	BoardAnswerService aservice;
	
	@GetMapping("/board/list")
	public ModelAndView boardlist(
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		int totalCount=service.getTotalCount();
		
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

		//각페이지에서 필요한 게시글 가져오기...dao에서 만들었음
		List<BoardDto> list=service.getList(start, perPage);		
		
		//이름
		for(BoardDto d:list) {
			String name=memMapper.getName(d.getMyid());
			d.setName(name);
			d.setAcount(aservice.getAllAnswers(d.getNum()).size());
		}
		
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
		
		model.setViewName("/board/boardlist");
		return model;
	}
	
	@GetMapping("/board/form")
	public String form() {
		return "/board/writeform";
	}
	
	@PostMapping("/board/insert")
	public String insert(@ModelAttribute BoardDto dto,
			HttpSession session  //로그인
			) {
		//만료됐을 수도 있으므로 다시한번 loginok 얻기
		String loginok=(String)session.getAttribute("loginok");
		if(loginok==null) {
			return "/board/loginmsg";
		}
		
		//업로드할 폴더 지정
		String path=session.getServletContext().getRealPath("/photo");
		
		//업로드할 파일명
		if(dto.getUpload().getOriginalFilename().equals(""))
			dto.setUploadfile("no");  //업로드 안하면 db에 no라고 저장
		else {
			//업로드한 경우
			String uploadfile=dto.getUpload().getOriginalFilename();
			dto.setUploadfile(uploadfile);
			
			//실제업로드
			try {
				dto.getUpload().transferTo(new File(path+"\\"+uploadfile));
			} catch (IllegalStateException | IOException e) {
			}
		}
		//세션에서 아이디를 얻어서 dto에 저장
		String myid=(String)session.getAttribute("myid");
		dto.setMyid(myid);
		
		//insert
		service.insertBoard(dto);
		
		//maxnum..return시 content로 갈때 필요
		int num=service.getMaxNum();
		
		return "redirect:content?num="+num;
	}
	
	@GetMapping("/board/content")
	public ModelAndView content(@RequestParam String num,
			@RequestParam(value = "currentPage",defaultValue = "1") int currentPage
			) {
		ModelAndView model=new ModelAndView();
		
		//readcount 호출
		service.updateReadCount(num);
		
		BoardDto dto=service.getData(num);
		
		//dto의 name에 작성자 이름넣기
		String name=memMapper.getName(dto.getMyid());
		dto.setName(name);
		
		//업로드 파일의 확장자 얻기
		int dotLoc=dto.getUploadfile().lastIndexOf('.');  //마지막 .의 위치..가끔 war파일은 .이 여러개임
		String ext=dto.getUploadfile().substring(dotLoc+1);  //.다음 글자부터 끝까지 추출
		System.out.println(dotLoc+","+ext);  //확인용
		
		//이미지일 경우에만 bupload
		//소대문자 구분없이 같은 걸 의미할 땐 equalsIgnoreCase, 소대문자까지 정확히 맞는 건 equals
		if(ext.equalsIgnoreCase("jpg")||ext.equalsIgnoreCase("png")||ext.equalsIgnoreCase("gif")||ext.equalsIgnoreCase("jpeg"))
			model.addObject("bupload", true);
		else 
			model.addObject("bupload", false);
		
		
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("/board/content");
		return model;
	}
	
	@GetMapping("/board/updateform")
	public ModelAndView updateform(String num,String currentPage) {
		ModelAndView model=new ModelAndView();
		
		BoardDto dto=service.getData(num);
		
		model.addObject("dto", dto);
		model.addObject("currentPage", currentPage);
		
		model.setViewName("/board/updateform");
		return model;
	}
	
	@PostMapping("/board/update")
	public String update(@ModelAttribute BoardDto dto,
			HttpSession session,  //로그인
			String currentPage
			) {
		//만료됐을 수도 있으므로 다시한번 loginok 얻기
		String loginok=(String)session.getAttribute("loginok");
		if(loginok==null) {
			return "/board/loginmsg";
		}
		
		//업로드할 폴더 지정
		String path=session.getServletContext().getRealPath("/photo");
		
		//업로드할 파일명
		if(dto.getUpload().getOriginalFilename().equals(""))
			dto.setUploadfile("null");  //업로드 안하면 db에 null라고 저장(boardsql 참고)
		else {
			//업로드한 경우
			String uploadfile=dto.getUpload().getOriginalFilename();
			dto.setUploadfile(uploadfile);
			
			//실제업로드
			try {
				dto.getUpload().transferTo(new File(path+"\\"+uploadfile));
			} catch (IllegalStateException | IOException e) {
			}
		}		
		//update
		service.updateBoard(dto);		
		
		return "redirect:content?num="+dto.getNum()+"&currentPage="+currentPage;
	}
	
	@GetMapping("/board/delete")
	public String delete(String num,String currentPage,
			HttpSession session
			) {
		//폴더에 있는 이미지 삭제
		String path=session.getServletContext().getRealPath("/photo"); //실제 업로드 폴더 경로
		
		String uploadfile=service.getData(num).getUploadfile();
		
		File file=new File(path+"\\"+uploadfile);
		file.delete();  //파일 삭제
		
		//db삭제
		service.deleteBoard(num);
		return "redirect:list?currentPage="+currentPage;
	}
	
	
}
