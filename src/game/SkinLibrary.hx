package game;

import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.geom.Point;
import flash.geom.Rectangle;
	
/**
 * ...
 * @author bstouls
 */

class SkinLibrary 
{	
	public static var CUBE_WHITE:String 		= "000";
	public static var CUBE_BONUS_1:String 		= "001";
	public static var CUBE_BONUS_2:String 		= "002";
	public static var CUBE_BONUS_3:String 		= "003";
	public static var CUBE_BONUS_4:String 		= "004";
	public static var CUBE_LIFE:String 			= "005";
	public static var COLUMN_NUMBER:String 		= "006";
	public static var METERS_BG:String 			= "007";
	public static var SCORE_BG:String 			= "008";
	public static var NB_KUBES_BG:String 		= "009";
	public static var BONUS_KUBE_BG:String 		= "010";
	public static var COMBO_BG:String 			= "011";
	public static var TITLE_BG:String 			= "012";
	public static var ARROW_BG:String 			= "013";
	
	public static var BUTTON_PLAY:String 		= "020";
	public static var BUTTON_RULES:String 		= "021";
	public static var BUTTON_KEYS:String 		= "022";
	public static var BUTTON_CREDITS:String 	= "023";
	public static var BUTTON_MENU:String 		= "024";
	public static var BUTTON_REPLAY:String 		= "025";
	
	public static var MOUSE_LEFT_BG:String 		= "030";
	public static var MOUSE_WHEEL_BG:String 	= "031";
	
	
	public static var CUBE_YELLOW_1_1:String 	= "111";
	public static var CUBE_YELLOW_1_2:String 	= "112";
	public static var CUBE_YELLOW_1_3:String 	= "113";
	public static var CUBE_YELLOW_1_4:String 	= "114";
	
	public static var CUBE_YELLOW_2_1:String 	= "121";
	public static var CUBE_YELLOW_2_2:String 	= "122";
	public static var CUBE_YELLOW_2_3:String 	= "123";
	public static var CUBE_YELLOW_2_4:String 	= "124";
	
	public static var CUBE_YELLOW_3_1:String 	= "131";
	public static var CUBE_YELLOW_3_2:String 	= "132";
	public static var CUBE_YELLOW_3_3:String 	= "133";
	public static var CUBE_YELLOW_3_4:String 	= "134";
	
	public static var CUBE_RED_1_1:String 		= "211";
	public static var CUBE_RED_1_2:String 		= "212";
	public static var CUBE_RED_1_3:String 		= "213";
	public static var CUBE_RED_1_4:String 		= "214";
	
	public static var CUBE_RED_2_1:String 		= "221";
	public static var CUBE_RED_2_2:String 		= "222";
	public static var CUBE_RED_2_3:String 		= "223";
	public static var CUBE_RED_2_4:String 		= "224";
	
	public static var CUBE_RED_3_1:String 		= "231";
	public static var CUBE_RED_3_2:String 		= "232";
	public static var CUBE_RED_3_3:String 		= "233";
	public static var CUBE_RED_3_4:String 		= "234";
	
	public static var CUBE_BLUE_1_1:String 		= "311";
	public static var CUBE_BLUE_1_2:String 		= "312";
	public static var CUBE_BLUE_1_3:String 		= "313";
	public static var CUBE_BLUE_1_4:String 		= "314";
	
	public static var CUBE_BLUE_2_1:String 		= "321";
	public static var CUBE_BLUE_2_2:String 		= "322";
	public static var CUBE_BLUE_2_3:String 		= "323";
	public static var CUBE_BLUE_2_4:String 		= "324";
	
	public static var CUBE_BLUE_3_1:String 		= "331";
	public static var CUBE_BLUE_3_2:String 		= "332";
	public static var CUBE_BLUE_3_3:String 		= "333";
	public static var CUBE_BLUE_3_4:String 		= "334";
	
	public static var CUBE_GREEN_1_1:String 	= "411";
	public static var CUBE_GREEN_1_2:String 	= "412";
	public static var CUBE_GREEN_1_3:String 	= "413";
	public static var CUBE_GREEN_1_4:String 	= "414";
	
	public static var CUBE_GREEN_2_1:String 	= "421";
	public static var CUBE_GREEN_2_2:String 	= "422";
	public static var CUBE_GREEN_2_3:String 	= "423";
	public static var CUBE_GREEN_2_4:String 	= "424";
	
	public static var CUBE_GREEN_3_1:String 	= "431";
	public static var CUBE_GREEN_3_2:String 	= "432";
	public static var CUBE_GREEN_3_3:String 	= "433";
	public static var CUBE_GREEN_3_4:String 	= "434";
	
	
	public static var m_assets:Bitmap;
	
	public function new() 
	{
	}
	
	public static function setImage(_image:Bitmap):Void
	{
		m_assets = _image;
	}
	
	
	public static function getImage(_name:String):Bitmap
	{
		var bitmapData:BitmapData = new BitmapData(45, 58);
		var _point:Point = new Point(0, 0);
		
		switch (_name) 
		{
			//CUBES
			case CUBE_GREEN_1_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 0, 45, 58), _point);
			case CUBE_GREEN_1_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(50, 0, 45, 58), _point);
			case CUBE_GREEN_1_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(100, 0, 45, 58), _point);
			case CUBE_GREEN_1_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(150, 0, 45, 58), _point);
			case CUBE_GREEN_2_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(200, 0, 45, 58), _point);
			case CUBE_GREEN_2_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(250, 0, 45, 58), _point);
			case CUBE_GREEN_2_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(300, 0, 45, 58), _point);
			case CUBE_GREEN_2_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(350, 0, 45, 58), _point);
			case CUBE_GREEN_3_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(400, 0, 45, 58), _point);
			case CUBE_GREEN_3_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(450, 0, 45, 58), _point);
			case CUBE_GREEN_3_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(500, 0, 45, 58), _point);
			case CUBE_GREEN_3_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(550, 0, 45, 58), _point);
			
			case CUBE_BLUE_1_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 60, 45, 58), _point);
			case CUBE_BLUE_1_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(50, 60, 45, 58), _point);
			case CUBE_BLUE_1_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(100, 60, 45, 58), _point);
			case CUBE_BLUE_1_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(150, 60, 45, 58), _point);
			case CUBE_BLUE_2_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(200, 60, 45, 58), _point);
			case CUBE_BLUE_2_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(250, 60, 45, 58), _point);
			case CUBE_BLUE_2_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(300, 60, 45, 58), _point);
			case CUBE_BLUE_2_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(350, 60, 45, 58), _point);
			case CUBE_BLUE_3_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(400, 60, 45, 58), _point);
			case CUBE_BLUE_3_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(450, 60, 45, 58), _point);
			case CUBE_BLUE_3_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(500, 60, 45, 58), _point);
			case CUBE_BLUE_3_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(550, 60, 45, 58), _point);
			
			case CUBE_YELLOW_1_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 120, 45, 58), _point);
			case CUBE_YELLOW_1_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(50, 120, 45, 58), _point);
			case CUBE_YELLOW_1_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(100, 120, 45, 58), _point);
			case CUBE_YELLOW_1_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(150, 120, 45, 58), _point);
			case CUBE_YELLOW_2_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(200, 120, 45, 58), _point);
			case CUBE_YELLOW_2_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(250, 120, 45, 58), _point);
			case CUBE_YELLOW_2_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(300, 120, 45, 58), _point);
			case CUBE_YELLOW_2_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(350, 120, 45, 58), _point);
			case CUBE_YELLOW_3_1:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(400, 120, 45, 58), _point);
			case CUBE_YELLOW_3_2:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(450, 120, 45, 58), _point);
			case CUBE_YELLOW_3_3:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(500, 120, 45, 58), _point);
			case CUBE_YELLOW_3_4:	bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(550, 120, 45, 58), _point);
			
			case CUBE_RED_1_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 180, 45, 58), _point);
			case CUBE_RED_1_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(50, 180, 45, 58), _point);
			case CUBE_RED_1_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(100, 180, 45, 58), _point);
			case CUBE_RED_1_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(150, 180, 45, 58), _point);
			case CUBE_RED_2_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(200, 180, 45, 58), _point);
			case CUBE_RED_2_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(250, 180, 45, 58), _point);
			case CUBE_RED_2_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(300, 180, 45, 58), _point);
			case CUBE_RED_2_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(350, 180, 45, 58), _point);
			case CUBE_RED_3_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(400, 180, 45, 58), _point);
			case CUBE_RED_3_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(450, 180, 45, 58), _point);
			case CUBE_RED_3_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(500, 180, 45, 58), _point);
			case CUBE_RED_3_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(550, 180, 45, 58), _point);
			
			case CUBE_WHITE:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 240, 45, 58), _point);
			case CUBE_BONUS_1:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(50, 240, 45, 58), _point);
			case CUBE_BONUS_2:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(100, 240, 45, 58), _point);
			case CUBE_BONUS_3:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(150, 240, 45, 58), _point);
			case CUBE_BONUS_4:		bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(200, 240, 45, 58), _point);
			case CUBE_LIFE:			bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(250, 240, 45, 58), _point);
			
			//GAME NTERFACE
			case COLUMN_NUMBER:		bitmapData = new BitmapData(16, 220);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(0, 310, 16, 220), _point);
			case METERS_BG:			bitmapData = new BitmapData(73, 31);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 310, 73, 31), _point);
			case SCORE_BG:			bitmapData = new BitmapData(105, 31);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(120, 310, 105, 31), _point);
			case NB_KUBES_BG:		bitmapData = new BitmapData(41, 31);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(240, 310, 41, 31), _point);
			case BONUS_KUBE_BG:		bitmapData = new BitmapData(110, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 360, 110, 32), _point);
			case COMBO_BG:			bitmapData = new BitmapData(260, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(160, 360, 260, 32), _point);
			
			//MENU
			case BUTTON_PLAY:		bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 400, 242, 32), _point);
			case BUTTON_RULES:		bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 440, 242, 32), _point);
			case BUTTON_KEYS:		bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 480, 242, 32), _point);
			case BUTTON_CREDITS:	bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 520, 242, 32), _point);
			case BUTTON_MENU:		bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(30, 560, 242, 32), _point);
			case BUTTON_REPLAY:		bitmapData = new BitmapData(242, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(290, 400, 242, 32), _point);
									
			case TITLE_BG:			bitmapData = new BitmapData(265, 65);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(320, 250, 265, 65), _point);
			
			case MOUSE_LEFT_BG:		bitmapData = new BitmapData(32, 45);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(420, 320, 32, 45), _point);
			case MOUSE_WHEEL_BG:	bitmapData = new BitmapData(32, 45);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(460, 320, 32, 45), _point);
			
			case ARROW_BG:			bitmapData = new BitmapData(75, 32);
									bitmapData.copyPixels(m_assets.bitmapData, new Rectangle(330, 320, 75, 32), _point);
			
			
			default:
		}
		
		
		return new Bitmap(bitmapData);
	}
}