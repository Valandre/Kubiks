package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;
import flash.net.URLRequest;

/**
 * ...
 * @author bstouls
 */

class Menu extends Sprite
{
	private var m_mainContainer:Sprite;
	private var m_maskContainer:Sprite;
	
	private var m_playButton:Sprite;
	private var m_rulesButton:Sprite;
	private var m_keysButton:Sprite;
	private var m_creditsButton:Sprite;
	
	private var m_credits:Credits;
	private var m_keys:Keys;
	private var m_rules:Rules;
	private var m_play:PlayMenu;
	
	public function new() 
	{
		super();
		init();
	}
	
	/**
	 * init menu
	 */
	private function init():Void 
	{
		var _img:Bitmap;
		
		var _title:Sprite = new Sprite();
		_img = SkinLibrary.getImage(SkinLibrary.TITLE_BG);
		_title.addChild(_img);
		_title.x = (Settings.STAGE_WIDTH - _title.width) / 2;
		_title.y = 10;
		addChild(_title);
		
		//
		m_mainContainer = new Sprite();
		addChild(m_mainContainer);
		
		m_maskContainer = new Sprite();
		m_maskContainer.graphics.beginFill(0);
		m_maskContainer.graphics.drawRect(0, 0, Settings.STAGE_WIDTH, Settings.STAGE_HEIGHT);
		addChild(m_maskContainer);
		
		m_mainContainer.mask = m_maskContainer;
		
		//play button
		m_playButton = new Sprite();
		m_playButton.name = "play";
		m_playButton.x = -120;
		m_playButton.y = 160;
		m_playButton.buttonMode = true;
		m_mainContainer.addChild(m_playButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_PLAY);
		m_playButton.addChild(_img);
		
		//rules button
		m_rulesButton = new Sprite();
		m_rulesButton.name = "rules";
		m_rulesButton.x = m_playButton.x;
		m_rulesButton.y = m_playButton.y + 40;
		m_mainContainer.addChild(m_rulesButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_RULES);
		m_rulesButton.addChild(_img);
		
		//keys button
		m_keysButton = new Sprite();
		m_keysButton.name = "keys";
		m_keysButton.x = m_rulesButton.x;
		m_keysButton.y = m_rulesButton.y + 40;
		m_mainContainer.addChild(m_keysButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_KEYS);
		m_keysButton.addChild(_img);
		
		//credits button
		m_creditsButton = new Sprite();
		m_creditsButton.name = "credits";
		m_creditsButton.x = m_keysButton.x;
		m_creditsButton.y = m_keysButton.y + 40;
		m_mainContainer.addChild(m_creditsButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_CREDITS);
		m_creditsButton.addChild(_img);
		
		//
		m_playButton.addEventListener(MouseEvent.CLICK, clickButton);
		
		m_playButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_playButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		m_rulesButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_rulesButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		m_keysButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_keysButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		m_creditsButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_creditsButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		
		
		//
		m_credits = new Credits();
		m_keys = new Keys();
		m_rules = new Rules();
		m_play = new PlayMenu();
	}
	
	
	/**
	 * click play button
	 */
	private function clickButton(_event:MouseEvent = null):Void
	{
		dispatchEvent(new Event("start_game"));
	}
	
	
	/**
	 * over button
	 */
	private function overButton(_event:MouseEvent = null):Void
	{
		switch (_event.target.name) 
		{
			case "play":		m_mainContainer.addChild(m_play);
			case "rules":		m_mainContainer.addChild(m_rules);
			case "keys":		m_mainContainer.addChild(m_keys);

			case "credits":		m_mainContainer.addChild(m_credits);
				
			default:
				
		}
		_event.target.addEventListener(Event.ENTER_FRAME, moveButtonRight);
		_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonLeft);
	}
	
	/**
	 * leave button
	 */
	private function leaveButton(_event:MouseEvent = null):Void
	{
		switch (_event.target.name) 
		{
			case "play":		m_mainContainer.removeChild(m_play);
			case "rules":		m_mainContainer.removeChild(m_rules);
			case "keys":		m_mainContainer.removeChild(m_keys);
			case "credits":		m_mainContainer.removeChild(m_credits);
				
			default:
				
		}
		_event.target.addEventListener(Event.ENTER_FRAME, moveButtonLeft);
		_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonRight);
	}
	
	
	/**
	 * move button to right
	 */
	private function moveButtonRight(_event:Event = null):Void 
	{
		_event.target.x += (-80 - _event.target.x) * 0.3;
		
		if (Math.abs(-80 - _event.target.x) < 1)
			_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonRight);
	}
	
	/**
	 * move button to left
	 */
	private function moveButtonLeft(_event:Event = null):Void 
	{
		_event.target.x += (-120 - _event.target.x) * 0.3;
		
		if (Math.abs(-120 - _event.target.x) < 1)
			_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonLeft);
	}
}