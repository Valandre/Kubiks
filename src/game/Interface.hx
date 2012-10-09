package game;
import flash.display.Bitmap;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.filters.GlowFilter;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.AntiAliasType;
import flash.events.Event;

/**
 * ...
 * @author bstouls
 */

class Interface extends Sprite
{
	private var m_cursor:Sprite;
	private var m_cursorMask:Sprite;
	
	private var m_metersContainer:Sprite;
	private var m_unitsContainer:Sprite;
	private var m_decadesContainer:Sprite;
	private var m_hundredsContainer:Sprite;
	private var m_metersMask:Sprite;
	
	private var m_kubesContainer:Sprite;
	private var m_kubesUnitsContainer:Sprite;
	private var m_kubesDecadesContainer:Sprite;
	private var m_kubesMask:Sprite;
	private var m_multiplier:TextField;
		
	private var m_scoreContainer:Sprite;
	private var m_scoreArray:Array<Sprite>;
	private var m_scoresMask:Sprite;
	
	private var m_combo:MovieClip;
	private var m_comboMask:Sprite;
	private var m_comboText:TextField;
	
	private var m_cursorCpt:Int;
	private var m_goToSegment:Int;
	private var m_price:Array<Int>;
		
	public var nbKubes:Int;
	public var meters:Int;
	public var score:Int;
	
	public function new() 
	{
		super();
	}
	
	/**
	 * init interface
	 */
	private function init():Void 
	{
		meters = 0;
		score = 0;
		setKubes (Settings.NB_KUBES_START);
		
		m_price = new Array();
		m_price.push(1);
		for (i in 1...Settings.CUBE_SIZE)
			m_price.push(m_price[i - 1] + i + 1);
			
		//create cursor
		m_cursor = new Sprite();
		m_cursor.x = Settings.STAGE_WIDTH + 20;
		m_cursor.y = 150;
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.BONUS_KUBE_BG);
		_img.x = 5;
		_img.y = -_img.height / 2;
		m_cursor.addChild(_img);	
		addChild(m_cursor);
		
		var _multiplierFormat:TextFormat = new TextFormat();
		_multiplierFormat.align = TextFormatAlign.RIGHT;
		_multiplierFormat.font = "Impact";
		_multiplierFormat.size = 16;
		
		m_multiplier = new TextField();
		m_multiplier.defaultTextFormat = _multiplierFormat;
		m_multiplier.embedFonts = true;
		m_multiplier.antiAliasType = AntiAliasType.ADVANCED;
		m_multiplier.text = "+ 00";
		m_multiplier.textColor = 0xEDEBE7;
		m_multiplier.width = 50;
		m_multiplier.height = 30;
		m_multiplier.x = 0;
		m_multiplier.y = -11;
		m_multiplier.mouseEnabled = false;
		
		m_cursor.addChild(m_multiplier);
		
		m_cursorMask = new Sprite();
		m_cursorMask.graphics.beginFill(0);
		m_cursorMask.graphics.drawRect(0, 0, Settings.STAGE_WIDTH, Settings.STAGE_HEIGHT);
		addChild(m_cursorMask);
		
		m_cursor.mask = m_cursorMask;
		
		//create combo container
		m_combo = new MovieClip();
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COMBO_BG);
		m_combo.addChild(_img);	
		addChild(m_combo);
		
		var _comboFormat:TextFormat = new TextFormat();
		_comboFormat.align = TextFormatAlign.RIGHT;
		_comboFormat.font = "Impact";
		_comboFormat.size = 16;
		
		m_comboText = new TextField();
		m_comboText.defaultTextFormat = _comboFormat;
		m_comboText.embedFonts = true;
		m_comboText.antiAliasType = AntiAliasType.ADVANCED;
		m_comboText.text = "COMBO X2";
		m_comboText.width = 120;
		m_comboText.height = 40;
		m_comboText.textColor = 0xEDEBE7;
		m_comboText.x = 100;
		m_comboText.y = 4;
		m_comboText.mouseEnabled = false;
		
		m_combo.addChild(m_comboText);
		
		m_comboMask = new Sprite();
		m_comboMask.graphics.beginFill(0);
		m_comboMask.graphics.drawRect(0, 0, Settings.STAGE_WIDTH, Settings.STAGE_HEIGHT);
		addChild(m_comboMask);
		
		m_combo.x =  -20 - m_combo.width;
		m_combo.y = 100;
		m_combo.mask = m_comboMask;
		
		
		
		//create meters container
		m_metersContainer = new Sprite();
		addChild(m_metersContainer);
		
		m_hundredsContainer = new Sprite();
		m_hundredsContainer.x = 5;
		m_metersContainer.addChild(m_hundredsContainer);
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
		_img.y = -_img.height * 0.9 + 5;
		m_hundredsContainer.addChild(_img);	
		
		m_decadesContainer = new Sprite();
		m_decadesContainer.x = m_hundredsContainer.x + m_hundredsContainer.width;
		m_metersContainer.addChild(m_decadesContainer);
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
		_img.y = -_img.height * 0.9 + 5;
		m_decadesContainer.addChild(_img);	
		
		m_unitsContainer = new Sprite();
		m_unitsContainer.x = m_decadesContainer.x + m_decadesContainer.width;
		m_metersContainer.addChild(m_unitsContainer);
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
		_img.y = -_img.height * 0.9 + 5;
		m_unitsContainer.addChild(_img);	
		
		var _metersBg:Bitmap = SkinLibrary.getImage(SkinLibrary.METERS_BG);
		m_metersContainer.addChild(_metersBg);
		
		//correct black line
		m_metersContainer.graphics.beginFill(0xffffff);
		m_metersContainer.graphics.drawRect(5, 27, _metersBg.width, 2);
		
		//
		m_metersContainer.x = Settings.STAGE_WIDTH - m_metersContainer.width - 10;
		m_metersContainer.y = Settings.STAGE_HEIGHT - _metersBg.height - 10;
		
		//add meters mask
		m_metersMask = new Sprite();
		m_metersMask.graphics.beginFill(0x000000);
		m_metersMask.graphics.drawRect(0, 2, _metersBg.width, _metersBg.height - 2);
		m_metersMask.x = m_metersContainer.x;
		m_metersMask.y = m_metersContainer.y;
		addChild(m_metersMask);
		
		m_metersContainer.mask = m_metersMask;
		
		
		//create kubes Stock		
		m_kubesContainer = new Sprite();
		addChild(m_kubesContainer);
		
		m_kubesDecadesContainer = new Sprite();
		m_kubesDecadesContainer.x = 5;
		m_kubesContainer.addChild(m_kubesDecadesContainer);
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
		_img.y = -_img.height * 0.9 + 5;
		m_kubesDecadesContainer.addChild(_img);	
		
		m_kubesUnitsContainer = new Sprite();
		m_kubesUnitsContainer.x = m_kubesDecadesContainer.x + m_kubesDecadesContainer.width;
		m_kubesContainer.addChild(m_kubesUnitsContainer);
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
		_img.y = -_img.height * 0.9 + 5;
		m_kubesUnitsContainer.addChild(_img);	
		
		var _kubesBg:Bitmap = SkinLibrary.getImage(SkinLibrary.NB_KUBES_BG);
		m_kubesContainer.addChild(_kubesBg);
		
		//correct black line
		m_kubesContainer.graphics.beginFill(0xffffff);
		m_kubesContainer.graphics.drawRect(5, 27, _kubesBg.width, 2);
	
		m_kubesContainer.x = Settings.STAGE_WIDTH - m_kubesContainer.width - 10;
		m_kubesContainer.y = 10;
		
		//add meters mask
		m_kubesMask = new Sprite();
		m_kubesMask.graphics.beginFill(0x000000);
		m_kubesMask.graphics.drawRect(0, 2, _kubesBg.width, _kubesBg.height - 2);
		m_kubesMask.x = m_kubesContainer.x;
		m_kubesMask.y = m_kubesContainer.y;
		addChild(m_kubesMask);
		
		m_kubesContainer.mask = m_kubesMask;
		
		var _block:Block;
		_block = new Block("grey");
		_block.scaleX = _block.scaleY = 0.7;
		_block.x = m_kubesContainer.x - 22;
		_block.y = m_kubesContainer.y + 25;
		addChild(_block);
		
		var _glow:GlowFilter = new GlowFilter(0xffffff);
		_block.filters = [_glow];
		
		//add score
		m_scoreArray = new Array();
		
		m_scoreContainer = new Sprite();
		addChild(m_scoreContainer);
		
		for (n in 0...6)
		{
			var _columnNumber:Sprite = new Sprite();
			var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.COLUMN_NUMBER);
			_img.y = -_img.height * 0.9 + 5;
			_columnNumber.addChild(_img);
						
			_columnNumber.x = 5 + (5 - n) * (_columnNumber.width);
			m_scoreContainer.addChild(_columnNumber);
			m_scoreArray.push(_columnNumber);
		}
		
		var _scoreBg:Bitmap = SkinLibrary.getImage(SkinLibrary.SCORE_BG);
		m_scoreContainer.addChild(_scoreBg);
		
		//correct black line
		m_scoreContainer.graphics.beginFill(0xffffff);
		m_scoreContainer.graphics.drawRect(5, 27, _scoreBg.width, 2);
		
		m_scoreContainer.x = 10;
		m_scoreContainer.y = Settings.STAGE_HEIGHT - _scoreBg.height - 10;
		
		//add score mask
		m_scoresMask = new Sprite();
		m_scoresMask.graphics.beginFill(0xff0000);
		m_scoresMask.graphics.drawRect(0, 0, _scoreBg.width, _scoreBg.height - 2);
		m_scoresMask.x = m_scoreContainer.x;
		m_scoresMask.y = m_scoreContainer.y + 2;
		addChild(m_scoresMask);
		
		m_scoreContainer.mask = m_scoresMask;
	}
	
	/**
	 * set meters
	 */
	public function setMeters(_value:Int):Void 
	{
		meters += _value;
	}
	
	/**
	 * set score
	 */
	public function setScore(_nb:Int, _coeff:Int):Void 
	{
		var _points:Int = score;
		
		_points += _nb * _coeff * Settings.BLOCK_POINTS;
		
		if (_coeff > 1)
			displayCombo();
				
		score = _points;
		addEventListener(Event.ENTER_FRAME, updateScore);
	}
	
	/**
	 * set Kubes number
	 */
	public function setKubes(_value:Int):Void 
	{
		nbKubes += _value;
		addEventListener(Event.ENTER_FRAME, updateKubes);
	}
	
	/**
	 * reset interface
	 */
	public function reset():Void 
	{
		//remove all elements
		while (numChildren > 0)
			removeChildAt(0);
		
		//init new zone
		init();
	}
	
	/**
	 * reset cursor 
	 */
	public function resetCursor():Void 
	{
		m_goToSegment = 1;
		
		m_cursor.x = Settings.STAGE_WIDTH + 20;
		m_cursor.y = 150;
	}
	
	/**
	 * set cursor 
	 */
	public function setCursor(_missingFloor:Int):Void 
	{
		var _metersToAdd:Int = _missingFloor - m_goToSegment;
		meters += _metersToAdd;
		
		m_goToSegment = _missingFloor;
		m_multiplier.text = "+ " + m_price[m_goToSegment - 1];
		
		if (m_cursor.x > Settings.STAGE_WIDTH)
			m_cursor.y = 150 + (m_goToSegment - 1) * Settings.BLOCK_LENGTH;
		
		addEventListener(Event.ENTER_FRAME, updateCursor);
	}
	
	/**
	 * update cursor
	 */
	public function updateCursor(_event:Event = null):Void
	{
		m_cursor.y += (( 150 + (m_goToSegment - 1) * Settings.BLOCK_LENGTH) - m_cursor.y) * 0.3;
		m_cursor.x += (Settings.STAGE_WIDTH - 85 - m_cursor.x) * 0.3;
		
		var _metersSplit:Array<String> = Std.string(meters).split("");
		_metersSplit.reverse();
		
		if (_metersSplit.length > 0)
			m_unitsContainer.y += (Std.parseInt(_metersSplit[0]) * (Math.ceil(m_unitsContainer.height / 10)) - m_unitsContainer.y) * 0.3;
		if (_metersSplit.length > 1)
			m_decadesContainer.y += (Std.parseInt(_metersSplit[1]) * (Math.ceil(m_decadesContainer.height / 10)) - m_decadesContainer.y) * 0.3;
		if (_metersSplit.length > 2)
			m_hundredsContainer.y += (Std.parseInt(_metersSplit[2]) * (Math.ceil(m_decadesContainer.height / 10)) - m_decadesContainer.y) * 0.3;
		
		if (Math.abs(( 150 + (m_goToSegment - 1) * Settings.BLOCK_LENGTH) - m_cursor.y) < 0.5
			&& Math.abs(Settings.STAGE_WIDTH - 85 - m_cursor.x) < 0.5
			&& Math.abs(Std.parseInt(_metersSplit[0]) * (Math.ceil(m_unitsContainer.height / 10)) - m_unitsContainer.y) < 0.5
			&& Math.abs(Std.parseInt(_metersSplit[1]) * (Math.ceil(m_decadesContainer.height / 10)) - m_decadesContainer.y) < 0.5
			&& Math.abs(Std.parseInt(_metersSplit[2]) * (Math.ceil(m_hundredsContainer.height / 10)) - m_hundredsContainer.y) < 0.5)
		{
			m_cursorCpt = 0;
			removeEventListener(Event.ENTER_FRAME, updateCursor);
			addEventListener(Event.ENTER_FRAME, temporizeCursor);
		}
	
	}
	
	/**
	 * temporize cursor
	 */
	public function temporizeCursor(_event:Event = null):Void
	{
		m_cursorCpt++;
		if (m_cursorCpt >= 60)
		{
			if (m_cursorCpt == 60)
				setKubes(m_price[m_goToSegment - 1]);
				
			m_cursor.x += (Settings.STAGE_WIDTH + 20 - m_cursor.x) * 0.3;
		
			if (Math.abs(Settings.STAGE_WIDTH + 20 - m_cursor.x) < 0.5)
			{
				resetCursor();
				removeEventListener(Event.ENTER_FRAME, temporizeCursor);
			}
		}
	}
	
	
	/**
	 * display combo
	 */
	public function displayCombo():Void
	{
		m_comboText.text = "COMBO X" + Game.m_combo;
		m_combo.time = 0;
		if (m_combo.x < -160)
		{
			removeEventListener(Event.ENTER_FRAME, updateResetCombo);
			addEventListener(Event.ENTER_FRAME, updateDisplayCombo);
		}
	}
	
	/**
	 * update display combo
	 */
	public function updateDisplayCombo(_event:Event = null):Void
	{
		m_combo.x += (-140 - m_combo.x) * 0.3;
		if (Math.abs( -140 - m_combo.x) < 0.5)
		{
			if (m_combo.time++ >= 80)
			{
				addEventListener(Event.ENTER_FRAME, updateResetCombo);
				removeEventListener(Event.ENTER_FRAME, updateDisplayCombo);
			}
		}
	}
	
	/**
	 * update reset combo
	 */
	public function updateResetCombo(_event:Event = null):Void
	{
		m_combo.x += (-20 - m_combo.width - m_combo.x) * 0.3;
		if (Math.abs( -20 - m_combo.width - m_combo.x) < 0.5)
			removeEventListener(Event.ENTER_FRAME, updateResetCombo);
	}
	
	
	/**
	 * update nb kubes
	 */
	public function updateKubes(_event:Event = null):Void
	{
		var _kubesSplit:Array<String> = Std.string(nbKubes).split("");
		_kubesSplit.reverse();
		
		if (_kubesSplit[1] == null)
			_kubesSplit[1] = "0";
			
		if (_kubesSplit.length > 0)
			m_kubesUnitsContainer.y += (Std.parseInt(_kubesSplit[0]) * (Math.ceil(m_kubesUnitsContainer.height / 10)) - m_kubesUnitsContainer.y) * 0.3;
		if (_kubesSplit.length > 1)
			m_kubesDecadesContainer.y += (Std.parseInt(_kubesSplit[1]) * (Math.ceil(m_kubesDecadesContainer.height / 10)) - m_kubesDecadesContainer.y) * 0.3;
		
		if (Math.abs(Std.parseInt(_kubesSplit[0]) * (Math.ceil(m_kubesUnitsContainer.height / 10)) - m_kubesUnitsContainer.y) < 0.5
		 && Math.abs(Std.parseInt(_kubesSplit[1]) * (Math.ceil(m_kubesDecadesContainer.height / 10)) - m_kubesDecadesContainer.y) < 0.5)
			removeEventListener(Event.ENTER_FRAME, updateKubes);
	}
	
	
	/**
	 * update score
	 */
	public function updateScore(_event:Event = null):Void
	{
		var _finished:Bool = true;
		var _scoreSplit:Array<String> = Std.string(score).split("");
		_scoreSplit.reverse();
		
		for (i in 0..._scoreSplit.length)
		{
			m_scoreArray[i].y += (Std.parseInt(_scoreSplit[i]) * (Math.floor(m_scoreArray[i].height / 10)) - m_scoreArray[i].y) * 0.3;
			if (Math.abs(Std.parseInt(_scoreSplit[i]) * (Math.ceil(m_scoreArray[i].height / 10)) - m_scoreArray[i].y) >= 0.5)
				_finished = false;
		}
			
		if (_finished)
		{
			for (i in 0..._scoreSplit.length)
				m_scoreArray[i].y = Std.parseInt(_scoreSplit[i]) * (Math.floor(m_scoreArray[i].height / 10));
			removeEventListener(Event.ENTER_FRAME, updateScore);
		}
	}
	
}
