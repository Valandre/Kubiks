package game;
import flash.display.Bitmap;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;

/**
 * ...
 * @author bstouls
 */

class Game extends Sprite
{
	private var m_kube:Kube;
	private var m_interactArea:InteractiveArea;
	private var m_interface:Interface;
	private var m_menuButton:Sprite;
	
	private var m_disableClick:Bool;
	
	public static var m_combo:Int;
	private var m_waitEndGame:Int;
	private var m_bonusCoeff:Float;
	
	public static var difficultyCoeff:Array<Float>;
	
	public function new() 
	{
		super();
		
		init();
		addEventListener(Event.ADDED_TO_STAGE, activate);
		addEventListener(Event.REMOVED_FROM_STAGE, deactivate);
	}
	
	
	/**
	 * activate
	 */
	private function activate(_event:Event):Void 
	{
		//listeners
		stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		stage.addEventListener(MouseEvent.MOUSE_OVER, mouseMove);
		removeEventListener(Event.ADDED_TO_STAGE, activate);
		
		stage.focus = this;
	}
	
	/**
	 * deactive
	 */
	private function deactivate(_event:Event):Void 
	{
		//listeners
		stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		stage.removeEventListener(MouseEvent.MOUSE_OVER, mouseMove);
		stage.removeEventListener(MouseEvent.CLICK, mouseClick);
		removeEventListener(Event.ADDED_TO_STAGE, deactivate);
	}
	
	/**
	 * init game
	 */
	private function init():Void 
	{
		//%chance to have harder block [hard1, hard2] 
		difficultyCoeff = [0, 0];
		
		//add puzzle zone
		m_kube = new Kube();
		m_kube.x = Settings.STAGE_WIDTH / 2  - m_kube.xCenter - 10;
		m_kube.y = Settings.STAGE_HEIGHT / 2;
		addChild(m_kube);
		
		//add interactive zone
		m_interactArea = new InteractiveArea();
		m_interactArea.x = m_kube.x;
		m_interactArea.y = m_kube.y - Settings.BLOCK_LENGTH * (Settings.CUBE_SIZE);
		m_interactArea.mouseEnabled = false;
		addChild(m_interactArea);
		
		//add interface
		m_interface = new Interface();
		m_interface.mouseEnabled = false;
		addChild(m_interface);
		
		//menu button
		m_menuButton = new Sprite();
		m_menuButton.name = "menu";
		m_menuButton.x = -160;
		m_menuButton.y = 10;
		m_menuButton.buttonMode = true;
		addChild(m_menuButton);
		
		var _img:Bitmap = SkinLibrary.getImage(SkinLibrary.BUTTON_MENU);
		m_menuButton.addChild(_img);
		
		//
		m_menuButton.addEventListener(MouseEvent.CLICK, clickButton);
		m_menuButton.addEventListener(MouseEvent.MOUSE_OVER, overButton);
		m_menuButton.addEventListener(MouseEvent.MOUSE_OUT, leaveButton);
		
		//init game
		reset();
	}
	
	/**
	 * reset game 
	 */
	private function reset():Void 
	{
		//reser game zone
		m_kube.reset();
		m_interactArea.reset();
		m_interface.reset();
		
		//
		m_kube.highLightColumn(0, 0);
		m_disableClick = false;
		m_combo = 0;
		m_bonusCoeff = 0;
		
		//init game
		if (m_kube.setNewFloors() > 0)
			addEventListener(Event.ENTER_FRAME, updateKubeMaxFloor);	
	}
	
	/**
	 * start sliding columns
	 */
	private function slideColumns():Void
	{
		addEventListener(Event.ENTER_FRAME, updateSlideColumns);
	}
	
	/**
	 * update sliding columns
	 */
	private function updateSlideColumns(_event:Event = null):Void
	{
		addEventListener(Event.ENTER_FRAME, updateKubeMaxFloor);
		
		m_disableClick = false;
		removeEventListener(Event.ENTER_FRAME, updateSlideColumns);
	}
	
	
	/**
	 * step 1: release playing block
	 */
	private function updateFallingBlock(_event:Event = null):Void
	{
		//test if blocks end to fall
		if (m_kube.updateFallingBlocks())
		{
			var _nbBreak:Int = m_kube.breakingBlocks();
			if (_nbBreak > 0)
			{
				//break block
				m_combo++;
				if (m_combo > Main.m_comboMax)
					Main.m_comboMax = m_combo;
				Main.m_blockDestroyed += _nbBreak;
					
				m_interface.setScore(_nbBreak, m_combo);
				
				m_kube.resetHighLightColumns();
				m_kube.resetKubeFaces();
				addEventListener(Event.ENTER_FRAME, updateBreakingBlocks);
			}
			else 
			{
				//update next turn
				var _offset:Int = m_kube.setNewFloors();
				if (_offset > 0)
				{
					updateDifficulty(_offset);
					addEventListener(Event.ENTER_FRAME, updateKubeMaxFloor);
				}
				else endTurn();
			}
			removeEventListener(Event.ENTER_FRAME, updateFallingBlock);
		}
	}
	
	/**
	 * step 2: break blocks 
	 */
	private function updateBreakingBlocks(_event:Event = null):Void
	{
		//test if blocks are broken
		if (m_kube.updateBreakingBlocks())
		{
			var _maxFloor:Int = m_kube.highestFloor();
			if (Settings.CUBE_SIZE - _maxFloor  > 0)
				m_interface.setCursor(Settings.CUBE_SIZE - _maxFloor);
					
			//test if there is new blocks falling
			if (m_kube.searchBlocksToFall())
				addEventListener(Event.ENTER_FRAME, updateFallingBlock);
			else
			{
				//update next turn
				var _offset:Int = m_kube.setNewFloors();
				if (_offset > 0)
				{
					updateDifficulty(_offset);
					addEventListener(Event.ENTER_FRAME, updateKubeMaxFloor);
				}
				else endTurn();
			}
			removeEventListener(Event.ENTER_FRAME, updateBreakingBlocks);
		}
	}
	
	/**
	 * step 3: restore kube max floor
	 */
	private function updateKubeMaxFloor(_event:Event = null):Void
	{
		if (m_kube.updateKubeMaxFloor())
		{
			endTurn();
			removeEventListener(Event.ENTER_FRAME, updateKubeMaxFloor);
		}
	}
	
	/**
	 * step 3: end turn
	 */
	private function endTurn():Void
	{
		m_kube.updateKubeFaces();
		m_kube.highLightColumn(m_interactArea.m_cellX, m_interactArea.m_cellY);	
		
		//first test nbKubes
		if (m_interface.nbKubes == 0)
		{
			m_waitEndGame = 0;
			addEventListener(Event.ENTER_FRAME, waitEndGame);
		}
		else if (!stage.hasEventListener(MouseEvent.CLICK))
			stage.addEventListener(MouseEvent.CLICK, mouseClick);
	}
	
	/**
	 * wait end game
	 */
	private function waitEndGame(_event:Event = null):Void
	{
		//waiting for cursor update
		if (m_waitEndGame++ > 80)
		{
			//second test nbKubes (always = 0)
			if (m_interface.nbKubes == 0)
			{
				stage.removeEventListener(MouseEvent.CLICK, mouseClick);
				stage.removeEventListener(MouseEvent.MOUSE_OVER, mouseMove);
				stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
				removeEventListener(Event.ENTER_FRAME, updateRotateView);
				
				var _params:Hash<String> = new Hash();
				_params.set("score", Std.string(m_interface.score));
				_params.set("depth", Std.string(m_interface.meters));
				
				dispatchEvent(new MainEvent("end_game", _params));
			}
			else if (!stage.hasEventListener(MouseEvent.CLICK))
				stage.addEventListener(MouseEvent.CLICK, mouseClick);
				
			removeEventListener(Event.ENTER_FRAME, waitEndGame);
		}
	}
	
	/**
	 * rorate view 
	 */
	private function updateRotateView(_event:Event = null):Void
	{
		m_kube.resetHighLightColumns();
		m_interactArea.hide();
		
		if (m_kube.updateRotateView())
		{
			m_kube.highLightColumn(m_interactArea.m_cellX, m_interactArea.m_cellY);
			m_interactArea.show();
		
			m_kube.resetHighLightKubes();
			if (m_interactArea.currentBlockIsBonus())
				m_kube.highLightKubes(m_interactArea.currentBlockType(), m_interactArea.m_cellX, m_interactArea.m_cellY);
			
			stage.addEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
			stage.addEventListener(MouseEvent.MOUSE_OVER, mouseMove);
			removeEventListener(Event.ENTER_FRAME, updateRotateView);
		}
	}
	
	/**
	 * update interact area blocks pos
	 */
	private function updateBlockPos(_event:Event = null):Void
	{
		if (m_interactArea.updateBlockPos())
			removeEventListener(Event.ENTER_FRAME, updateBlockPos);
	}
	
	/**
	 * update difficulty
	 */
	private function updateDifficulty(_value:Int):Void
	{
		difficultyCoeff[0] = Math.min(Settings.MAX_UPGRADE, difficultyCoeff[0] + (Settings.COEFF_UPGRADE * _value));
		
		if (difficultyCoeff[0] > 0.2)
			difficultyCoeff[1] = Math.min(Settings.MAX_UPGRADE, difficultyCoeff[1] + (Settings.COEFF_UPGRADE * _value) / 2);
	}
	
	/**
	 * update bonus
	 */
	private function updateBonus():Void
	{
		m_bonusCoeff += Settings.BONUS_UPGRADE;
		
		if (Math.random() < 0.01)	//random exploit bonus
			m_bonusCoeff += 0.1;
	}
	
	/**
	 * get bonus
	 */
	private function getBonus():Bool
	{
		if (Math.random() < m_bonusCoeff)
		{
			m_bonusCoeff = Math.max(0, m_bonusCoeff - 0.1);
			return true;
		}
		
		return false;
	}
	
	
	/**
	 * mouse move 
	 */
	private function mouseMove(_event:MouseEvent = null):Void
	{
		//update grid cell
		if (Std.is(_event.target, Block))
		{
			//update playing block position
			m_interactArea.updateAreaPos(_event.target.xPos, _event.target.yPos);
			
			//update highlight column size and position
			m_kube.highLightColumn(m_interactArea.m_cellX, m_interactArea.m_cellY);
			
			m_kube.resetHighLightKubes();
			if (m_interactArea.currentBlockIsBonus())
				m_kube.highLightKubes(m_interactArea.currentBlockType(), m_interactArea.m_cellX, m_interactArea.m_cellY);
				
			var _block:Block = m_kube.highestBlock(m_interactArea.m_cellX, m_interactArea.m_cellY);
		
			if (_block != null && _block.zPos == Settings.CUBE_SIZE)
				m_disableClick = true;
			else m_disableClick = false;
		}
	}
	
	/**
	 * mouse click 
	 */
	private function mouseClick(_event:MouseEvent = null):Void
	{
		if (!m_disableClick && m_interface.nbKubes > 0)
		{
			m_combo = 0;
			Main.m_blockDropped++;

			m_kube.resetHighLightKubes();
			
			//release playing block
			var _block:Block = m_kube.highestBlock(m_interactArea.m_cellX, m_interactArea.m_cellY);
			
			if (_block != null)
				m_kube.newFallingBlock(m_interactArea.currentBlockType(), m_interactArea.currentBlockHealth(), _block.xPos, _block.yPos, _block.zPos + 1);
			else m_kube.newFallingBlock(m_interactArea.currentBlockType(), m_interactArea.currentBlockHealth(), m_interactArea.m_cellX, m_interactArea.m_cellY, 0);
			
			//update cubes to play
			m_interface.setKubes(-1);
			
			//update bonus
			updateBonus();
			
			//get next block
			m_interactArea.nextBlock(getBonus());
			
			addEventListener(Event.ENTER_FRAME, updateBlockPos);
			addEventListener(Event.ENTER_FRAME, updateFallingBlock);
			stage.removeEventListener(MouseEvent.CLICK, mouseClick);
		}
	}
	
	/**
	 * mouse wheel 
	 */
	private function mouseWheel(_event:MouseEvent = null):Void
	{
		m_kube.rotateView(_event.delta);
		addEventListener(Event.ENTER_FRAME, updateRotateView);
		
		stage.removeEventListener(MouseEvent.MOUSE_OVER, mouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
	}
	
	
	/**
	 * click menu button
	 */
	private function clickButton(_event:MouseEvent = null):Void
	{
		stage.removeEventListener(MouseEvent.CLICK, mouseClick);
		stage.removeEventListener(MouseEvent.MOUSE_OVER, mouseMove);
		stage.removeEventListener(MouseEvent.MOUSE_WHEEL, mouseWheel);
		removeEventListener(Event.ENTER_FRAME, updateRotateView);
		dispatchEvent(new Event("back_menu"));
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
		_event.target.x += (-120 - _event.target.x) * 0.3;
		
		if (Math.abs(-120 - _event.target.x) < 1)
			_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonRight);
	}
	
	/**
	 * move button to left
	 */
	private function moveButtonLeft(_event:Event = null):Void 
	{
		_event.target.x += (-160 - _event.target.x) * 0.3;
		
		if (Math.abs(-160 - _event.target.x) < 1)
			_event.target.removeEventListener(Event.ENTER_FRAME, moveButtonLeft);
	}
}