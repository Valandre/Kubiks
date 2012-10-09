package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.filters.DropShadowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.AntiAliasType;
import flash.text.TextFieldAutoSize;
import flash.events.Event;

/**
 * ...
 * @author bstouls
 */

class Rules extends Sprite
{
	private var m_title1:TextField;
	private var m_title2:TextField;
	
	private var m_text1:TextField;
	private var m_text2:TextField;
	
	private var m_image:Sprite;
	
	public function new() 
	{
		super();
		init();
		
		addEventListener(Event.ADDED_TO_STAGE, display);
	}
	
	/**
	 * init
	 */
	private function init():Void 
	{
		var _titleFormat:TextFormat = new TextFormat();
		_titleFormat.align = TextFormatAlign.LEFT;
		_titleFormat.font = "Impact";
		_titleFormat.size = 14;
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.LEFT;
		_textFormat.font = "Arial";
		_textFormat.size = 12;
		
		//
		graphics.beginFill(0x62BA0A);
		graphics.drawRect(190, 120, 4, 270);
		
		//
		m_title1 = new TextField();
		m_title1.defaultTextFormat = _titleFormat;
		m_title1.embedFonts = true;
		m_title1.antiAliasType = AntiAliasType.ADVANCED;
		m_title1.autoSize = TextFieldAutoSize.LEFT;
		m_title1.text = "BUT DU JEU";
		m_title1.textColor = 0x62BA0A;
		m_title1.x = 200;
		m_title1.y = 110;
		m_title1.mouseEnabled = false;
		addChild(m_title1);
		
		m_text1 = new TextField();
		m_text1.defaultTextFormat = _textFormat;
		m_text1.embedFonts = true;
		m_text1.antiAliasType = AntiAliasType.ADVANCED;
		m_text1.autoSize = TextFieldAutoSize.LEFT;
		m_text1.text = "Associez les blocs par couleur et atteignez la plus grande profondeur possible en un nombre de coups limité.";
		m_text1.wordWrap = true;
		m_text1.multiline = true;
		m_text1.width = 200;
		m_text1.textColor = 0xcccccc;
		m_text1.x = m_title1.x;
		m_text1.y = m_title1.y + 25;
		m_text1.mouseEnabled = false;
		addChild(m_text1);
		
		//
		m_title2 = new TextField();
		m_title2.defaultTextFormat = _titleFormat;
		m_title2.embedFonts = true;
		m_title2.antiAliasType = AntiAliasType.ADVANCED;
		m_title2.autoSize = TextFieldAutoSize.LEFT;
		m_title2.text = "ASTUCES";
		m_title2.textColor = 0x62BA0A;
		m_title2.x = m_title1.x;
		m_title2.y = m_title1.y + 90;
		m_title2.mouseEnabled = false;
		addChild(m_title2);
		
		m_text2 = new TextField();
		m_text2.defaultTextFormat = _textFormat;
		m_text2.embedFonts = true;
		m_text2.antiAliasType = AntiAliasType.ADVANCED;
		m_text2.autoSize = TextFieldAutoSize.LEFT;
		m_text2.text = "- Détruisez plusieurs étages en même temps pour gagnez des coups supplémentaires.\n- Enchainez les combos pour faire le maximum de points.\n- Certains cubes doivent être touchés plusieurs fois avant de disparaître.";
		m_text2.wordWrap = true;
		m_text2.multiline = true;
		m_text2.width = 200;
		m_text2.textColor = 0xcccccc;
		m_text2.x = m_title1.x;
		m_text2.y = m_title2.y + 25;
		m_text2.mouseEnabled = false;
		addChild(m_text2);
		
		
		
		//
		m_image = new Sprite();
		m_image.x = m_title1.x;
		m_image.y = 340;
		addChild(m_image);
		
		var _shadow:DropShadowFilter = new DropShadowFilter(3, 45, 0, 0.8);
		
		var _cube1:Bitmap = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_3_1);
		_cube1.x = 5;
		_cube1.filters = [_shadow];
		
		var _cube2:Bitmap = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_2_1);
		_cube2.x = _cube1.x + 70;
		_cube2.filters = [_shadow];
		
		var _cube3:Bitmap = SkinLibrary.getImage(SkinLibrary.CUBE_BLUE_1_1);
		_cube3.x = _cube2.x + 70;
		_cube3.filters = [_shadow];
		
		var _arrow1:Bitmap = SkinLibrary.getImage(SkinLibrary.ARROW_BG);
		_arrow1.scaleX = _arrow1.scaleY = 0.8;
		_arrow1.smoothing = true;
		_arrow1.x = _cube1.x + 15;
		_arrow1.y = 17;
		_arrow1.filters = [_shadow];
		
		var _arrow2:Bitmap = SkinLibrary.getImage(SkinLibrary.ARROW_BG);
		_arrow2.scaleX = _arrow2.scaleY = 0.8;
		_arrow2.smoothing = true;
		_arrow2.x = _cube2.x + 15;
		_arrow2.y = 17;
		_arrow2.filters = [_shadow];
		
		m_image.addChild(_cube3);
		m_image.addChild(_arrow2);
		m_image.addChild(_cube2);
		m_image.addChild(_arrow1);
		m_image.addChild(_cube1);
		
	}
	
	/**
	 * display
	 */
	private function display(_event:Event = null):Void 
	{
		m_title1.x = Settings.STAGE_WIDTH;
		m_title2.x = Settings.STAGE_WIDTH;
		
		m_text1.x = Settings.STAGE_WIDTH;
		m_text2.x = Settings.STAGE_WIDTH;
		
		m_image.x = Settings.STAGE_WIDTH;
		
		addEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	/**
	 * update display
	 */
	private function updateDisplay(_event:Event = null):Void 
	{
		m_title1.x += (200 - m_title1.x) * 0.3;
		m_title2.x = m_title1.x;
		
		m_text1.x = m_title1.x;
		m_text2.x = m_title1.x;
		
		m_image.x = m_title1.x;
		
		if (Math.abs(200 - m_title1.x) < 1)
			removeEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	
}