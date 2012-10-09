package game;
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

class Credits extends Sprite
{
	private var m_title1:TextField;
	private var m_title2:TextField;
	private var m_title3:TextField;
	private var m_title4:TextField;
	private var m_title5:TextField;
	
	private var m_text1:TextField;
	private var m_text2:TextField;
	private var m_text3:TextField;
	private var m_text4:TextField;
	private var m_text5:TextField;
	
	private var m_textDate:TextField;
	
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
		graphics.beginFill(0xB13212);
		graphics.drawRect(190, 120, 4, 270);
		
		//
		m_title1 = new TextField();
		m_title1.defaultTextFormat = _titleFormat;
		m_title1.embedFonts = true;
		m_title1.antiAliasType = AntiAliasType.ADVANCED;
		m_title1.autoSize = TextFieldAutoSize.LEFT;
		m_title1.text = "AUTEUR";
		m_title1.textColor = 0xB13212;
		m_title1.x = 200;
		m_title1.y = 120;
		m_title1.mouseEnabled = false;
		addChild(m_title1);
		
		m_text1 = new TextField();
		m_text1.defaultTextFormat = _textFormat;
		m_text1.embedFonts = true;
		m_text1.antiAliasType = AntiAliasType.ADVANCED;
		m_text1.autoSize = TextFieldAutoSize.LEFT;
		m_text1.text = "Bernard Stouls";
		m_text1.textColor = 0xcccccc;
		m_text1.x = m_title1.x;
		m_text1.y = m_title1.y + 20;
		m_text1.mouseEnabled = false;
		addChild(m_text1);
		
		//
		m_title2 = new TextField();
		m_title2.defaultTextFormat = _titleFormat;
		m_title2.embedFonts = true;
		m_title2.antiAliasType = AntiAliasType.ADVANCED;
		m_title2.autoSize = TextFieldAutoSize.LEFT;
		m_title2.text = "PROGRAMMATION";
		m_title2.textColor = 0xB13212;
		m_title2.x = m_title1.x;
		m_title2.y = m_title1.y + 50;
		m_title2.mouseEnabled = false;
		addChild(m_title2);
		
		m_text2 = new TextField();
		m_text2.defaultTextFormat = _textFormat;
		m_text2.embedFonts = true;
		m_text2.antiAliasType = AntiAliasType.ADVANCED;
		m_text2.autoSize = TextFieldAutoSize.LEFT;
		m_text2.text = "HaXe (FlashDevelop)";
		m_text2.textColor = 0xcccccc;
		m_text2.x = m_title1.x;
		m_text2.y = m_title2.y + 20;
		m_text2.mouseEnabled = false;
		addChild(m_text2);
		
		//
		m_title3 = new TextField();
		m_title3.defaultTextFormat = _titleFormat;
		m_title3.embedFonts = true;
		m_title3.antiAliasType = AntiAliasType.ADVANCED;
		m_title3.autoSize = TextFieldAutoSize.LEFT;
		m_title3.text = "GRAPHISMES";
		m_title3.textColor = 0xB13212;
		m_title3.x = m_title1.x;
		m_title3.y = m_title2.y + 45;
		m_title3.mouseEnabled = false;
		addChild(m_title3);
		
		m_text3 = new TextField();
		m_text3.defaultTextFormat = _textFormat;
		m_text3.embedFonts = true;
		m_text3.antiAliasType = AntiAliasType.ADVANCED;
		m_text3.autoSize = TextFieldAutoSize.LEFT;
		m_text3.text = "PhotoShop, Flash CS4";
		m_text3.textColor = 0xcccccc;
		m_text3.x = m_title1.x;
		m_text3.y = m_title3.y + 20;
		m_text3.mouseEnabled = false;
		addChild(m_text3);
			
		//
		m_title4 = new TextField();
		m_title4.defaultTextFormat = _titleFormat;
		m_title4.embedFonts = true;
		m_title4.antiAliasType = AntiAliasType.ADVANCED;
		m_title4.autoSize = TextFieldAutoSize.LEFT;
		m_title4.text = "SONS";
		m_title4.textColor = 0xB13212;
		m_title4.x = m_title1.x;
		m_title4.y = m_title3.y + 45;
		m_title4.mouseEnabled = false;
		addChild(m_title4);
		
		m_text4 = new TextField();
		m_text4.defaultTextFormat = _textFormat;
		m_text4.embedFonts = true;
		m_text4.antiAliasType = AntiAliasType.ADVANCED;
		m_text4.autoSize = TextFieldAutoSize.LEFT;
		m_text4.text = "SunVox";
		m_text4.textColor = 0xcccccc;
		m_text4.x = m_title1.x;
		m_text4.y = m_title4.y + 20;
		m_text4.mouseEnabled = false;
		addChild(m_text4);
			
		//
		m_title5 = new TextField();
		m_title5.defaultTextFormat = _titleFormat;
		m_title5.embedFonts = true;
		m_title5.antiAliasType = AntiAliasType.ADVANCED;
		m_title5.autoSize = TextFieldAutoSize.LEFT;
		m_title5.text = "Testeurs";
		m_title5.textColor = 0xB13212;
		m_title5.x = m_title1.x;
		m_title5.y = m_title4.y + 50;
		m_title5.mouseEnabled = false;
		addChild(m_title5);
		
		m_text5 = new TextField();
		m_text5.defaultTextFormat = _textFormat;
		m_text5.embedFonts = true;
		m_text5.antiAliasType = AntiAliasType.ADVANCED;
		m_text5.autoSize = TextFieldAutoSize.LEFT;
		m_text5.text = "Tiffany Stouls\nYann Leclabart\nThomas Vasseur\nSylvere Armange";
		m_text5.textColor = 0xcccccc;
		m_text5.x = m_title1.x;
		m_text5.y = m_title5.y + 20;
		m_text5.mouseEnabled = false;
		addChild(m_text5);
		
		//
		var _dateFormat:TextFormat = new TextFormat();
		_dateFormat.align = TextFormatAlign.LEFT;
		_dateFormat.font = "Arial";
		_dateFormat.size = 10;
		
		m_textDate = new TextField();
		m_textDate.defaultTextFormat = _dateFormat;
		m_textDate.antiAliasType = AntiAliasType.ADVANCED;
		m_textDate.autoSize = TextFieldAutoSize.RIGHT;
		m_textDate.text = "Octobre 2012";
		m_textDate.textColor = 0xaaaaaa;
		m_textDate.x = Settings.STAGE_WIDTH - m_textDate.width - 10;
		m_textDate.y = Settings.STAGE_HEIGHT - 20;
		m_textDate.mouseEnabled = false;
		addChild(m_textDate);
		
	}
	
	/**
	 * display
	 */
	private function display(_event:Event = null):Void 
	{
		m_title1.x = Settings.STAGE_WIDTH;
		m_title2.x = Settings.STAGE_WIDTH;
		m_title3.x = Settings.STAGE_WIDTH;
		m_title4.x = Settings.STAGE_WIDTH;
		m_title5.x = Settings.STAGE_WIDTH;
		
		m_text1.x = Settings.STAGE_WIDTH;
		m_text2.x = Settings.STAGE_WIDTH;
		m_text3.x = Settings.STAGE_WIDTH;
		m_text4.x = Settings.STAGE_WIDTH;
		m_text5.x = Settings.STAGE_WIDTH;
		
		addEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	/**
	 * update display
	 */
	private function updateDisplay(_event:Event = null):Void 
	{
		m_title1.x += (200 - m_title1.x) * 0.3;
		m_title2.x = m_title1.x;
		m_title3.x = m_title1.x;
		m_title4.x = m_title1.x;
		m_title5.x = m_title1.x;
		
		m_text1.x = m_title1.x;
		m_text2.x = m_title1.x;
		m_text3.x = m_title1.x;
		m_text4.x = m_title1.x;
		m_text5.x = m_title1.x;
		
		if (Math.abs(200 - m_title1.x) < 1)
			removeEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	
}