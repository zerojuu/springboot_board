package data.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;

import data.dto.ShopDto;

@Mapper
public interface MysqlShopMapper {

	//추상메서드.. 이 메서드가 sql의 id가 됨
	public int getTotalCount();
	public void insertShop(ShopDto dto);
	public List<ShopDto> getAllSangpums();
	public void updateShop(ShopDto dto);
	public ShopDto getSangpum(String num);
	public void deleteSangpum(String num);
}
