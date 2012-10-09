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

class EndScore extends Sprite
{
	private var m_title1:TextField;
	private var m_title2:TextField;
	private var m_title3:TextField;
	private var m_title4:TextField;
	
	private var m_text1:TextField;
	private var m_text2:TextField;
	private var m_text3:TextField;
	private var m_text4:TextField;
	
	private var m_container:Sprite;
	
	
	public function new(_totalScore:Int, _bonus:Int, _score:Int, _depth:Int, _combo:Int) 
	{
		super();
		init(_totalScore, _bonus, _score, _depth, _combo);
		
		addEventListener(Event.ADDED_TO_STAGE, display);
	}
	
	/**
	 * init
	 */
	private function init(_totalScore:Int, _bonus:Int, _score:Int, _depth:Int, _combo:Int):Void 
	{
		//
		m_container = new Sprite();
		addChild(m_container);
		
		var _titleFormat:TextFormat = new TextFormat();
		_titleFormat.align = TextFormatAlign.LEFT;
		_titleFormat.font = "Impact";
		_titleFormat.size = 16;
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.LEFT;
		_textFormat.font = "Arial";
		_textFormat.bold = true;
		_textFormat.size = 16;
		
		var _gameOverFormat:TextFormat = new TextFormat();
		_gameOverFormat.align = TextFormatAlign.CENTER;
		_gameOverFormat.font = "Impact";
		_gameOverFormat.size = 30;
		
		//
		graphics.beginFill(0x933EA8);
		graphics.drawRect(190, 120, 4, 270);
		
		//
		var _gameOver:TextField = new TextField();
		_gameOver.defaultTextFormat = _gameOverFormat;
		_gameOver.embedFonts = true;
		_gameOver.antiAliasType = AntiAliasType.ADVANCED;
		_gameOver.autoSize = TextFieldAutoSize.LEFT;
		_gameOver.text = "GAME OVER";
		_gameOver.textColor = 0x933EA8;
		_gameOver.x = 300 - _gameOver.width / 2;
		_gameOver.y = 120;
		_gameOver.mouseEnabled = false;
		m_container.addChild(_gameOver);
		
		
		//
		m_title1 = new TextField();
		m_title1.defaultTextFormat = _titleFormat;
		m_title1.embedFonts = true;
		m_title1.antiAliasType = AntiAliasType.ADVANCED;
		m_title1.autoSize = TextFieldAutoSize.LEFT;
		m_title1.text = "POINTS: ";
		m_title1.textColor = 0x933EA8;
		m_title1.x = 200;
		m_title1.y = 180;
		m_title1.mouseEnabled = false;
		m_container.addChild(m_title1);
		
		m_text1 = new TextField();
		m_text1.defaultTextFormat = _textFormat;
		m_text1.embedFonts = true;
		m_text1.antiAliasType = AntiAliasType.ADVANCED;
		m_text1.autoSize = TextFieldAutoSize.RIGHT;
		m_text1.text = Std.string(_score);
		m_text1.textColor = 0xcccccc;
		m_text1.x = Settings.STAGE_WIDTH - m_text1.width - 30;
		m_text1.y = m_title1.y;
		m_text1.mouseEnabled = false;
		m_container.addChild(m_text1);
		
		//
		m_title2 = new TextField();
		m_title2.defaultTextFormat = _titleFormat;
		m_title2.embedFonts = true;
		m_title2.antiAliasType = AntiAliasType.ADVANCED;
		m_title2.autoSize = TextFieldAutoSize.LEFT;
		m_title2.text = "PROFONDEUR:";
		m_title2.textColor = 0x933EA8;
		m_title2.x = m_title1.x;
		m_title2.y = m_title1.y + 30;
		m_title2.mouseEnabled = false;
		m_container.addChild(m_title2);
		
		m_text2 = new TextField();
		m_text2.defaultTextFormat = _textFormat;
		m_text2.embedFonts = true;
		m_text2.antiAliasType = AntiAliasType.ADVANCED;
		m_text2.autoSize = TextFieldAutoSize.RIGHT;
		m_text2.text = Std.string(_depth) + "m";
		m_text2.textColor = 0xcccccc;
		m_text2.x = Settings.STAGE_WIDTH - m_text2.width - 30;
		m_text2.y = m_title2.y;
		m_text2.mouseEnabled = false;
		m_container.addChild(m_text2);
		
		//
		m_title3 = new TextField();
		m_title3.defaultTextFormat = _titleFormat;
		m_title3.embedFonts = true;
		m_title3.antiAliasType = AntiAliasType.ADVANCED;
		m_title3.autoSize = TextFieldAutoSize.LEFT;
		m_title3.text = "BONUS PROFONDEUR: ";
		m_title3.textColor = 0x933EA8;
		m_title3.x = m_title1.x;
		m_title3.y = m_title2.y + 30;
		m_title3.mouseEnabled = false;
		m_container.addChild(m_title3);
		
		m_text3 = new TextField();
		m_text3.embedFonts = true;
		m_text3.defaultTextFormat = _textFormat;
		m_text3.antiAliasType = AntiAliasType.ADVANCED;
		m_text3.autoSize = TextFieldAutoSize.RIGHT;
		m_text3.text = Std.string(_bonus);
		m_text3.textColor = 0xcccccc;
		m_text3.x = Settings.STAGE_WIDTH - m_text3.width - 30;
		m_text3.y = m_title3.y;
		m_text3.mouseEnabled = false;
		m_container.addChild(m_text3);
		
		
		
		
		//
		m_title4 = new TextField();
		m_title4.defaultTextFormat = _titleFormat;
		m_title4.embedFonts = true;
		m_title4.antiAliasType = AntiAliasType.ADVANCED;
		m_title4.autoSize = TextFieldAutoSize.LEFT;
		m_title4.text = "SCORE TOTAL: ";
		m_title4.textColor = 0x933EA8;
		m_title4.x = m_title1.x;
		m_title4.y = m_title3.y + 50;
		m_title4.mouseEnabled = false;
		m_container.addChild(m_title4);
		
		m_text4 = new TextField();
		m_text4.defaultTextFormat = _textFormat;
		m_text4.embedFonts = true;
		m_text4.antiAliasType = AntiAliasType.ADVANCED;
		m_text4.autoSize = TextFieldAutoSize.RIGHT;
		m_text4.textColor = 0xcccccc;
		m_text4.text = Std.string(_totalScore);
		m_text4.x = Settings.STAGE_WIDTH - m_text4.width - 30;
		m_text4.y = m_title4.y;
		m_text4.mouseEnabled = false;
		m_container.addChild(m_text4);
	}
	
	/**
	 * display
	 */
	private function display(_event:Event = null):Void 
	{
		m_container.x = Settings.STAGE_WIDTH;
		addEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	/**
	 * update display
	 */
	private function updateDisplay(_event:Event = null):Void 
	{
		m_container.x += (0 - m_container.x) * 0.3;
		if (Math.abs(0 - m_container.x) < 1)
			removeEventListener(Event.ENTER_FRAME, updateDisplay);
	}
	
	
}