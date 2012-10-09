package game;
import flash.display.MovieClip;
import flash.display.Sprite;

/**
 * ...
 * @author bstouls
 */

class InteractiveArea extends Sprite
{
	private var m_posX:Array<Array<Int>>;
	private var m_posY:Array<Array<Int>>;
	 
	private var m_blockContainer:Sprite;
	private var m_currentBlock:Sprite;
	private var m_nextBlock:Sprite;
	
	public var m_cellX:Int;
	public var m_cellY:Int;
	
	public function new() 
	{
		super();
		
		//define default pos (x,y stage values)
		m_posX = new Array();
		for (i in 0...Settings.CUBE_SIZE)
		{
			m_posX[i] = new Array();
			for (j in 0...Settings.CUBE_SIZE)
				m_posX[i][j] = ((Settings.BLOCK_WIDTH + Settings.BLOCK_ROTATE) * (j % Settings.CUBE_SIZE)) - ((Settings.BLOCK_WIDTH - Settings.BLOCK_ROTATE) * i);
		}
		
		m_posY = new Array();
		for (i in 0...Settings.CUBE_SIZE)
		{
			m_posY[i] = new Array();
			for (j in 0...Settings.CUBE_SIZE)
				m_posY[i][j] = Std.int((Math.round((Settings.BLOCK_HEIGHT * 2 / 3) - Settings.BLOCK_ROTATE) * (j % Settings.CUBE_SIZE)) + (Math.round((Settings.BLOCK_HEIGHT * 2 / 3) + Settings.BLOCK_ROTATE) * i));
		}
			
		init();
	}
	
	/**
	 * init zone
	 */
	private function init():Void 
	{
		//add play blocks
		m_blockContainer = new Sprite();
		m_blockContainer.y = - Settings.BLOCK_LENGTH;
		m_blockContainer.mouseEnabled = false;
		m_blockContainer.mouseChildren = false;
		addChild(m_blockContainer);
		
		m_currentBlock = new Sprite();
		m_currentBlock.addChild(new Block());
		m_blockContainer.addChild(m_currentBlock);
		
		m_nextBlock = new Sprite();
		m_nextBlock.addChild(new Block());
		m_nextBlock.y = m_currentBlock.y - Settings.BLOCK_LENGTH;
		m_blockContainer.addChild(m_nextBlock);
	}
	
	/**
	 * reset grid
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
	 * create next block to play
	 */
	public function nextBlock(_bonus:Bool):Void 
	{
		m_currentBlock.removeChildAt(0);
		m_currentBlock.addChild(m_nextBlock.getChildAt(0));
		
		if (_bonus)
		{
			var _type:String = Settings.BONUS_LIST[Math.floor(Math.random() * Settings.BONUS_LIST.length)];
			m_nextBlock.addChild(new Block(_type));
		}
		else m_nextBlock.addChild(new Block());
		
		m_currentBlock.y = - Settings.BLOCK_LENGTH;
		m_nextBlock.y = m_currentBlock.y - Settings.BLOCK_LENGTH;
	}
	
	/**
	 * reverse kubes
	 */
	public function reverseKubes():Void
	{
		var _block:Block = cast(m_currentBlock.getChildAt(0), Block);
		m_currentBlock.addChild(m_nextBlock.getChildAt(0));
		m_nextBlock.addChild(_block);
		
	}
	
	/**
	 * update block position
	 */
	public function updateBlockPos():Bool
	{
		m_currentBlock.y +=  (0 - m_currentBlock.y) * 0.3;
		m_nextBlock.y +=  (-Settings.BLOCK_LENGTH - m_nextBlock.y) * 0.3;
		
		if (Math.abs(m_currentBlock.y) < 1)
			return true;
			
		return false;
	}
	
	/**
	 * update area position
	 */
	public function updateAreaPos(_x:Int, _y:Int):Void
	{
		m_cellX = _x;
		m_cellY = _y;
		
		m_blockContainer.x = m_posX[_x][_y];
		m_blockContainer.y = m_posY[_x][_y] - Settings.BLOCK_LENGTH;
	}
	
	/**
	 * get current block type
	 */
	public function currentBlockType():String
	{
		var _block = cast (m_currentBlock.getChildAt(0), Block);
		
		return _block.m_type;
	}
	
	/**
	 * get current block health
	 */
	public function currentBlockHealth():Int
	{
		var _block = cast (m_currentBlock.getChildAt(0), Block);
		
		return _block.health;
	}
	
	/**
	 * get if current block is bonus
	 */
	public function currentBlockIsBonus():Bool
	{
		var _block = cast (m_currentBlock.getChildAt(0), Block);
		return _block.bonus;
	}
	
	/**
	 * hide playing cubes
	 */
	public function hide():Void 
	{
		m_currentBlock.visible = false;
		m_nextBlock.visible = false;
	}
	
	/**
	 * show playing cubes
	 */
	public function show():Void 
	{
		m_currentBlock.visible = true;
		m_nextBlock.visible = true;
	}
}