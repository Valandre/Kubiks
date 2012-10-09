package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.display.Sprite;
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

class Keys extends Sprite
{
	private var m_title1:TextField;
	private var m_title2:TextField;
	
	private var m_text1:TextField;
	private var m_text2:TextField;

	private var m_img1:Bitmap;
	private var m_img2:Bitmap;

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
		graphics.beginFill(0xE7A307);
		graphics.drawRect(190, 120, 4, 270);
		
		//
		m_img1 = SkinLibrary.getImage(SkinLibrary.MOUSE_LEFT_BG);
		m_img1.x = 200;
		m_img1.y = 120;
		addChild(m_img1);
		
		m_img2 = SkinLibrary.getImage(SkinLibrary.MOUSE_WHEEL_BG);
		m_img2.x = 200;
		m_img2.y = 180;
		addChild(m_img2);
		
		//
		m_title1 = new TextField();
		m_title1.defaultTextFormat = _titleFormat;
		m_title1.embedFonts = true;
		m_title1.antiAliasType = AntiAliasType.ADVANCED;
		m_title1.autoSize = TextFieldAutoSize.LEFT;
		m_title1.text = "BOUTON GAUCHE SOURIS";
		m_title1.textColor = 0xE7A307;
		m_title1.x = 240;
		m_title1.y = 120;
		m_title1.mouseEnabled = false;
		addChild(m_title1);
		
		m_text1 = new TextField();
		m_text1.defaultTextFormat = _textFormat;
		m_text1.embedFonts = true;
		m_text1.antiAliasType = AntiAliasType.ADVANCED;
		m_text1.autoSize = TextFieldAutoSize.LEFT;
		m_text1.text = "Relâche le cube suivant.";
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
		m_title2.text = "MOLETTE SOURIS";
		m_title2.textColor = 0xE7A307;
		m_title2.x = m_title1.x;
		m_title2.y = m_title1.y + 60;
		m_title2.mouseEnabled = false;
		addChild(m_title2);
		
		m_text2 = new TextField();
		m_text2.defaultTextFormat = _textFormat;
		m_text2.embedFonts = true;
		m_text2.antiAliasType = AntiAliasType.ADVANCED;
		m_text2.autoSize = TextFieldAutoSize.LEFT;
		m_text2.text = "Fait pivoter le cube de 90°.";
		m_text2.textColor = 0xcccccc;
		m_text2.x = m_title1.x;
		m_text2.y = m_title2.y + 25;
		m_text2.mouseEnabled = false;
		addChild(m_text2);
	}
	
	/**
	 * display
	 */
	private function display(_event:Event = null):Void 
	{
		m_img1.x = Settings.STAGE_WIDTH;
		m_img2.x = Settings.STAGE_WIDTH;
		
		m_title1.x = m_img1.x + 40;
		m_title2.x = m_img1.x + 40;
		
		m_text1.x = m_img1.x + 40;
		m_text2.x = m_img1.x + 40;
		
		addEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	/**
	 * update display
	 */
	private function updateDisplay(_event:Event = null):Void 
	{
		m_img1.x += (200 - m_img1.x) * 0.3;
		m_img2.x = m_img1.x;
		
		m_title1.x = m_img1.x + 40;
		m_title2.x = m_img1.x + 40;
		
		m_text1.x = m_title1.x;
		m_text2.x = m_title1.x;
		
		
		if (Math.abs(240 - m_title1.x) < 1)
			removeEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	
}