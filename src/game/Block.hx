package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;

/**
 * ...
 * @author bstouls
 */

class Block extends Sprite
{
	public var m_type:String;		//type of block
	public var solid:Bool;			//is solid or not
	public var bonus:Bool;			//is bonus or not
	public var m_color:UInt;		//color of block
	
	private var m_image:Sprite;		
	private var m_maskImage:Sprite;		
	private var m_flashing:Sprite;		
	private var m_explode:Sprite;		
	
	public var m_cptBlink:Int;		
	public var health:Int;		
	
	public var xPos:Int;
	public var yPos:Int;
	public var zPos:Int;
	
	public function new(_type:String = "", _health:Int = -1) 
	{
		super();
		
		xPos = Std.int(0);
		yPos = Std.int(0);
		zPos = Std.int(0);
								
		solid = true;
		bonus = false;
		
		//
		if (_type == "")
		{
			var _rnd:Int = Math.floor(Math.random() * 4);
			switch (_rnd) 
			{
				case 0:	m_type = "red";						
				case 1: m_type = "blue";						
				case 2:	m_type = "yellow";						
				case 3:	m_type = "green";					
				default:
			}
		}
		else m_type = _type;
		
		//
		if (_health != -1)
			health = _health;
		else
		{
			var _rnd:Float = Math.random();
			if (_rnd < Game.difficultyCoeff[1])
				health = 3;
			else if (_rnd < Game.difficultyCoeff[0])
				health = 2;
			else health = 1;
		}
		
		//
		m_image = new Sprite();
		addChild(m_image);
		drawBlock();
		
		//
		m_maskImage = new Sprite();
		m_maskImage.graphics.clear();
		m_maskImage.graphics.beginFill(0xffffff);
		
		m_maskImage.graphics.moveTo(Settings.BLOCK_WIDTH + 2, 0 - Settings.BLOCK_ROTATE + 2);									//E
		m_maskImage.graphics.lineTo(0 + Settings.BLOCK_ROTATE, Settings.BLOCK_HEIGHT * 2 / 3 + 2);								//F
		m_maskImage.graphics.lineTo( -Settings.BLOCK_WIDTH, 0 + Settings.BLOCK_ROTATE + 1);										//G
		m_maskImage.graphics.lineTo( -Settings.BLOCK_WIDTH, -Settings.BLOCK_LENGTH + Settings.BLOCK_ROTATE);					//C
		m_maskImage.graphics.lineTo(0 - Settings.BLOCK_ROTATE, -Settings.BLOCK_HEIGHT * 2 / 3 - Settings.BLOCK_LENGTH);			//D
		m_maskImage.graphics.lineTo(Settings.BLOCK_WIDTH + 2, -Settings.BLOCK_LENGTH - Settings.BLOCK_ROTATE);					//A
		m_maskImage.graphics.lineTo(Settings.BLOCK_WIDTH + 2, 0 - Settings.BLOCK_ROTATE + 2);									//E
		addChild(m_maskImage);
		
		m_image.mask = m_maskImage;
		
		mouseChildren = false;
		init();
	}

	/**
	 * draw block
	 */
	private function drawBlock():Void 
	{
		var _img:Bitmap = new Bitmap();
		var _rnd:Int = Math.floor(Math.random() * 4);
			
		switch (m_type) 
		{
			case "red":			m_color = Settings.RED_BLOCK;
								switch (_rnd) 
								{
									case 0:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_1_1);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_2_1);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_3_1);
									case 1:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_1_2);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_2_2);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_3_2);
									case 2:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_1_3);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_2_3);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_3_3);
									case 3:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_1_4);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_2_4);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_RED_3_4);
									default:
								}	
			case "blue":		m_color = Settings.BLUE_BLOCK;
								switch (_rnd) 
								{
									case 0:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_1_1);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_2_1);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_3_1);
									case 1:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_1_2);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_2_2);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_3_2);
									case 2:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_1_3);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_2_3);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_3_3);
									case 3:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_1_4);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_2_4);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_3_4);
									default:
								}
			case "yellow":		m_color = Settings.YELLOW_BLOCK;
								switch (_rnd) 
								{
									case 0:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_1_1);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_2_1);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_3_1);
									case 1:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_1_2);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_2_2);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_3_2);
									case 2:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_1_3);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_2_3);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_3_3);
									case 3:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_1_4);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_2_4);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_YELLOW_3_4);
									default:
								}
			case "green":		m_color = Settings.GREEN_BLOCK;
								switch (_rnd) 
								{
									case 0:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_1_1);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_2_1);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_3_1);
									case 1:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_1_2);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_2_2);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_3_2);
									case 2:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_1_3);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_2_3);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_3_3);
									case 3:	if (health == 1)		_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_1_4);
											else if (health == 2)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_2_4);
											else if (health == 3)	_img = SkinLibrary.getImage(SkinLibrary.CUBE_GREEN_3_4);
									default:
								}
			case "grey":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_LIFE);
								
			
			case "option1":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BONUS_1);
								health = 1;
								bonus = true;
			case "option2":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BONUS_2);
								health = 1;
								bonus = true;
			case "option3":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BONUS_3);
								health = 1;
								bonus = true;
			case "option4":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_BONUS_4);
								health = 1;
								bonus = true;
			
			case "left_void":	m_color = 0xffffff;
								solid = false;
								
			case "right_void":	m_color = 0xffffff;
								solid = false;
								
			case "bottom_void":	m_color = 0xffffff;
								solid = false;
								
			case "light":		_img = SkinLibrary.getImage(SkinLibrary.CUBE_WHITE);
								alpha = 0.7;
								solid = false;
								mouseEnabled = false;
							
			default:
		}
		
		_img.x = -_img.width / 2;
		_img.y = -Settings.BLOCK_HEIGHT * 2 / 3 - Settings.BLOCK_LENGTH;
		_img.smoothing = true;
		
		while (m_image.numChildren > 0)
			m_image.removeChildAt(0);
		
		m_image.addChild(_img);
	}
	
	/**
	 * init block
	 */
	public function init():Void 
	{
		m_flashing = new Sprite();
		m_flashing.mouseEnabled = false;
		
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.CUBE_WHITE);
		_img.x = -_img.width / 2;
		_img.y = -Settings.BLOCK_HEIGHT * 2 / 3 - Settings.BLOCK_LENGTH;
		_img.smoothing = true;
		m_flashing.addChild(_img);
		
		
		//
		m_explode = new Sprite();
		m_explode.mouseEnabled = false;
		
		_img = SkinLibrary.getImage(SkinLibrary.CUBE_WHITE);
		_img.x = -_img.width / 2;
		_img.y = -Settings.BLOCK_HEIGHT * 2 / 3 - Settings.BLOCK_LENGTH;
		_img.smoothing = true;
		m_explode.addChild(_img);
		
		
		graphics.clear();
		
		if (m_type == "left_void")
		{
			graphics.beginFill(m_color, 0);
			graphics.lineStyle(2, m_color, 0);
			
			graphics.moveTo( -Settings.BLOCK_WIDTH, 0 + Settings.BLOCK_ROTATE);										//G
			graphics.lineTo(0 - Settings.BLOCK_ROTATE , -Settings.BLOCK_HEIGHT * 2 / 3);							//H
			graphics.lineTo(0 - Settings.BLOCK_ROTATE, (-Settings.BLOCK_HEIGHT * 2 / 3) - Settings.BLOCK_LENGTH);	//D
			graphics.lineTo( -Settings.BLOCK_WIDTH, -Settings.BLOCK_LENGTH + Settings.BLOCK_ROTATE);				//C
			graphics.lineTo( -Settings.BLOCK_WIDTH, 0 + Settings.BLOCK_ROTATE);										//G
		}
		else if (m_type == "right_void")
		{
			graphics.beginFill(m_color, 0);
			graphics.lineStyle(2, m_color, 0);
			
			graphics.moveTo(Settings.BLOCK_WIDTH, 0 - Settings.BLOCK_ROTATE);										//E
			graphics.lineTo(0 - Settings.BLOCK_ROTATE , -Settings.BLOCK_HEIGHT * 2 / 3);							//H
			graphics.lineTo(0 - Settings.BLOCK_ROTATE, (-Settings.BLOCK_HEIGHT * 2 / 3) - Settings.BLOCK_LENGTH);	//D
			graphics.lineTo(Settings.BLOCK_WIDTH, -Settings.BLOCK_LENGTH - Settings.BLOCK_ROTATE);					//A
			graphics.lineTo(Settings.BLOCK_WIDTH, 0 - Settings.BLOCK_ROTATE);										//E
		}
		else if (m_type == "bottom_void")
		{
			graphics.beginFill(m_color, 0);
			graphics.lineStyle(2, m_color, 0
			);
			
			graphics.moveTo(Settings.BLOCK_WIDTH, 0 - Settings.BLOCK_ROTATE);										//E
			graphics.lineTo(0 + Settings.BLOCK_ROTATE, Settings.BLOCK_HEIGHT * 2 / 3);								//F
			graphics.lineTo( -Settings.BLOCK_WIDTH, 0 + Settings.BLOCK_ROTATE);										//G
			graphics.lineTo(0 - Settings.BLOCK_ROTATE , -Settings.BLOCK_HEIGHT * 2 / 3);							//H
			graphics.lineTo(Settings.BLOCK_WIDTH, 0 - Settings.BLOCK_ROTATE);										//E
		}
	}
	
	/**
	 * blink block
	 */
	public function blink():Void 
	{
		if (contains(m_flashing))
			removeChild(m_flashing);
			
		m_flashing.alpha = 0;
		addChild(m_flashing);
		
		m_cptBlink = 0;
			
		addEventListener(Event.ENTER_FRAME, updateBlink);
	}
	
	/**
	 * blink block
	 */
	private function updateBlink(_event:Event = null):Void 
	{
		m_cptBlink += 5;
		if (m_cptBlink == 180)
			m_cptBlink = 0;
			
		m_flashing.alpha = 0.5 * Math.sin(m_cptBlink * Math.PI / 180);
	}
	
	/**
	 * blink block
	 */
	public function removeBlink():Void 
	{
		if (contains(m_flashing))
		{
			removeChild(m_flashing);
			removeEventListener(Event.ENTER_FRAME, updateBlink);
		}
	}
	
	
	/**
	 * destroy bloc init
	 */
	public function explode():Void 
	{
		if (!contains(m_explode))
			addChild(m_explode);
		
		m_explode.alpha = 1.6;
		
		//
		if (health > 0)
			drawBlock();
		else removeChild(m_image);
	}
	
	/**
	 * update destroy bloc init
	 */
	public function updateExplode():Bool 
	{
		m_explode.alpha -= 0.075;
		
		if (m_explode.alpha <= 0)
		{
			if (contains(m_explode))
				removeChild(m_explode);
			return true;
		}
		
		return false;
	}
}