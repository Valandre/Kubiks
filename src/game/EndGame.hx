package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.MouseEvent;
import flash.events.Event;

/**
 * ...
 * @author bstouls
 */

class EndGame extends Sprite
{
	private var m_mainContainer:Sprite;
	private var m_maskContainer:Sprite;
	
	private var m_replayButton:Sprite;
	private var m_menuButton:Sprite;
	
	private var m_score:EndScore;
	
	public function new(_totalScore:Int, _bonus:Int, _score:Int, _depth:Int, _combo:Int) 
	{
		super();
		init(_totalScore, _bonus, _score, _depth, _combo);
	}
	
	/**
	 * init menu
	 */
	private function init(_totalScore:Int, _bonus:Int, _score:Int, _depth:Int, _combo:Int):Void 
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
		m_replayButton = new Sprite();
		m_replayButton.name = "replay";
		m_replayButton.x = -120;
		m_replayButton.y = 160;
		m_replayButton.buttonMode = true;
		m_mainContainer.addChild(m_replayButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_REPLAY);
		m_replayButton.addChild(_img);
		
		//menu button
		m_menuButton = new Sprite();
		m_menuButton.name = "menu";
		m_menuButton.x = m_replayButton.x;
		m_menuButton.y = m_replayButton.y + 40;
		m_menuButton.buttonMode = true;
		m_mainContainer.addChild(m_menuButton);
		
		_img = SkinLibrary.getImage(SkinLibrary.BUTTON_MENU);
		m_menuButton.addChild(_img);
		
		//
		m_replayButton.addEventListener(MouseEvent.CLICK, clickButton);
		m_menuButton.addEventListener(MouseEvent.CLICK, clickButton);
		
		m_replayButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_replayButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		m_menuButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_menuButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		
		
		//
		m_score = new EndScore(_totalScore, _bonus, _score, _depth, _combo);
		addChild(m_score);
	}
	
	
	/**
	 * click play button
	 */
	private function clickButton(_event:MouseEvent = null):Void
	{
		switch (_event.target.name) 
		{
			case "replay":		dispatchEvent(new Event("start_game"));
			case "menu":		dispatchEvent(new Event("back_menu"));
				
			default:
				
		}
		
	}
	
	
	/**
	 * over button
	 */
	private function overButton(_event:MouseEvent = null):Void
	{
		_event.target.addEventListener(Event.ENTER_FRAME, moveButtonRight);
		_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonLeft);
	}
	
	/**
	 * leave button
	 */
	private function leaveButton(_event:MouseEvent = null):Void
	{
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