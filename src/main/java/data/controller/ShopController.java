package data.controller;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.http.HttpSession;
import javax.websocket.Session;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import data.dto.ShopDto;
import data.mapper.MysqlShopMapper;

@Controller
public class ShopController {

	@Autowired
	MysqlShopMapper mapper;
	
	@GetMapping("/")
	public String home() {
		return "/layout/main";  //tiles경로..tiles/xml에서 put-attribut를 main으로 줬기에
	}
	
	@GetMapping("/shop/list")
	public ModelAndView list() {
		ModelAndView model=new ModelAndView();
		
		int totalCount=mapper.getTotalCount();
		model.addObject("totalCount", totalCount);
		
		List<ShopDto> list=mapper.getAllSangpums();
		model.addObject("list", list);
		
		//model.setViewName("shoplist");  //jsp
		model.setViewName("/shop/shoplist");  //tiles경로
		return model;
	}
	
	@GetMapping("/shop/form")
	public String form() {
		return "/shop/shopform";  //tiles경로
	}
	
	@PostMapping("/shop/insert")
	public String insert(
			@ModelAttribute ShopDto dto,
			@RequestParam MultipartFile upload,
			HttpSession session
			) {
		//업로드 경로
		String path=session.getServletContext().getRealPath("/photo");
		System.out.println(path);
		
		String photoName=upload.getOriginalFilename();
		
		dto.setPhotoname(photoName);
		
		//실제업로드
		try {
			upload.transferTo(new File(path+"\\"+photoName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		mapper.insertShop(dto);
		
		return "redirect:list";
	}
	
	@GetMapping("/shop/updateform")
	public String updateform(
			@RequestParam String num,
			Model model
			) {
		//db에서 num에 해당하는 dto 얻기
		ShopDto dto=mapper.getSangpum(num);
		
		model.addAttribute("dto", dto);
		
		return "/shop/updateform";  //tiles경로
	}
	
	@PostMapping("/shop/update")
	public String update(
			@ModelAttribute ShopDto dto,
			@RequestParam MultipartFile upload,
			HttpSession session
			) {
		if(upload.getOriginalFilename().equals("")) {
			dto.setPhotoname(null);
		} else {
		
		//업로드 경로
		String path=session.getServletContext().getRealPath("/photo");
		System.out.println(path);
		
		String photoName=upload.getOriginalFilename();
		
		dto.setPhotoname(photoName);
		
		//실제업로드
		try {
			upload.transferTo(new File(path+"\\"+photoName));
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		}
		
		mapper.updateShop(dto);
		
		return "redirect:list";
	}
	
	@GetMapping("/shop/delete")
	public String delete(
			@RequestParam String num,
			HttpSession session
			) {
		String path=session.getServletContext().getRealPath("/photo");
		
		//업로드된 파일명
		String uploadfile=mapper.getSangpum(num).getPhotoname();
		
		//file객체 생성
		File file=new File(path+"\\"+uploadfile);
		
		//파일 삭제
		file.delete();
		
		mapper.deleteSangpum(num);
		return "redirect:list";
	}
}
