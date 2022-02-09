package data.dto;

import java.sql.Timestamp;


import org.apache.ibatis.type.Alias;


@Alias("sdto")
public class ShopDto {

	private String num;
	private String sangpum;
	private int price;
	private String photoname;
	private Timestamp ipgoday;
	
	public String getNum() {
		return num;
	}
	public void setNum(String num) {
		this.num = num;
	}
	public String getSangpum() {
		return sangpum;
	}
	public void setSangpum(String sangpum) {
		this.sangpum = sangpum;
	}
	public int getPrice() {
		return price;
	}
	public void setPrice(int price) {
		this.price = price;
	}
	public String getPhotoname() {
		return photoname;
	}
	public void setPhotoname(String photoname) {
		this.photoname = photoname;
	}
	public Timestamp getIpgoday() {
		return ipgoday;
	}
	public void setIpgoday(Timestamp ipgoday) {
		this.ipgoday = ipgoday;
	}
}
