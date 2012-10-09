package game;

/**
 * ...
 * @author bstouls
 */

class Settings 
{
	static public var STAGE_WIDTH:Int = 420;
	static public var STAGE_HEIGHT:Int = 420;
	
	static public var BLOCK_WIDTH:Int = 22;
	static public var BLOCK_HEIGHT:Int = 26;
	static public var BLOCK_LENGTH:Int = 24;
	static public var BLOCK_ROTATE:Int = Std.int(Settings.BLOCK_WIDTH / 5);
		
	static public var CUBE_SIZE:Int = 6;		//cube size (width, height, length)
	
	static public var FALLING_SPEED:Int = 16;
	
	static public var NB_KUBES_START:Int = 10;
	
	static public var BONUS_UPGRADE:Float = 0.01;
	static public var COEFF_UPGRADE:Float = 0.01;
	static public var MAX_UPGRADE:Float = 1;
	
	static public var BLOCK_POINTS:Int = 10;
	static public var METERS_BONUS_COEFF:Int = 50;
	
	static public var RED_BLOCK:UInt = 0xff0000;
	static public var BLUE_BLOCK:UInt = 0x0066ff;
	static public var YELLOW_BLOCK:UInt = 0xffaa00;
	static public var GREEN_BLOCK:UInt = 0x44aa00;
	static public var GREY_BLOCK:UInt = 0xaaaaaa;
	static public var LIGHT_BLOCK:UInt = 0xffffff;
	
	static public var BLOCK_OPTION_1:UInt = 0xeeeeee;
	static public var BLOCK_OPTION_2:UInt = 0xaaaaaa;
	static public var BLOCK_OPTION_3:UInt = 0x666666;
	static public var BLOCK_OPTION_4:UInt = 0x222222;
	
	static public var BONUS_LIST:Array<String> = ["option1", "option2", "option3", "option4"] ;
	
	
	public function new() 
	{
		
	}
	
}