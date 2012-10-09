package game;
import flash.display.Sprite;
import flash.events.Event;
import flash.display.MovieClip;
import flash.filters.GlowFilter;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.AntiAliasType;

/**
 * ...
 * @author bstouls
 */

class Kube extends Sprite
{
	private var m_groundPosX:Array<Array<Int>>;
	private var m_groundPosY:Array<Array<Int>>;
	 
	private var m_columns:Array<Array<Sprite>>;
	private var m_lightColumn:Sprite;
	
	private var m_fallingBlocks:Array<Block>;
	private var m_falledBlocks:Array<Block>;
	private var m_blocksToRemove:Array<Block>;
	private var m_pointsList:Array<MovieClip>;
	
	public var xCenter:Int;
	public var yCenter:Int;
	
	public var rightMostX (getRightMostX, null):Int;
	public var rightMostY (getRightMostY, null):Int;
	
	public function new() 
	{
		super();
		
		//define ground default pos (x,y stage values)
		m_groundPosX = new Array();
		for (i in 0...Settings.CUBE_SIZE)
		{
			m_groundPosX[i] = new Array();
			for (j in 0...Settings.CUBE_SIZE)
				m_groundPosX[i][j] = ((Settings.BLOCK_WIDTH + Settings.BLOCK_ROTATE) * (j % Settings.CUBE_SIZE)) - ((Settings.BLOCK_WIDTH - Settings.BLOCK_ROTATE) * i);
		}
		
		m_groundPosY = new Array();
		for (i in 0...Settings.CUBE_SIZE)
		{
			m_groundPosY[i] = new Array();
			for (j in 0...Settings.CUBE_SIZE)
				m_groundPosY[i][j] = Std.int((Math.round((Settings.BLOCK_HEIGHT * 2 / 3) - Settings.BLOCK_ROTATE) * (j % Settings.CUBE_SIZE)) + (Math.round((Settings.BLOCK_HEIGHT * 2 / 3) + Settings.BLOCK_ROTATE) * i));
		}
		
		//define base cube center
		xCenter = Std.int((m_groundPosX[0][0] + m_groundPosX[Settings.CUBE_SIZE - 1][Settings.CUBE_SIZE - 1]) / 2);
		yCenter = Std.int((m_groundPosY[0][0] + m_groundPosY[Settings.CUBE_SIZE - 1][Settings.CUBE_SIZE - 1]) / 2);
	}
	
	/**
	 * get right most x coordinate
	 */
	private function getRightMostX():Int 
	{
		return Std.int(m_groundPosX[0][Settings.CUBE_SIZE - 1] + m_columns[0][Settings.CUBE_SIZE - 1].width / 2);
	}
	
	/**
	 * get right most y coordinate	
	 */
	private function getRightMostY():Int 
	{
		return m_groundPosY[0][Settings.CUBE_SIZE - 1] - Settings.BLOCK_ROTATE;
	}
	
	/**
	 * init puzzle zone
	 */
	private function init():Void 
	{
		//build cube columns containers
		m_columns = new Array();
		for (x in 0...Settings.CUBE_SIZE)
		{
			m_columns[x] = new Array();
			for (y in 0...Settings.CUBE_SIZE)
			{
				var _column = new Sprite();
				_column.x = m_groundPosX[x][y];
				_column.y = m_groundPosY[x][y];
				m_columns[x][y] = _column;
				addChild(_column);
			}
		}
		
		//
		m_lightColumn = new Sprite();
		m_lightColumn.mouseEnabled = false;
		
		//
		addEventListener(Event.ENTER_FRAME, updateDisplayPoints);
	}
	
	/**
	 * reset puzzle zone
	 */
	public function reset():Void
	{
		//remove all elements
		while (numChildren > 0)
			removeChildAt(0);
		
		m_fallingBlocks = new Array();
		m_falledBlocks = new Array();
		m_blocksToRemove = new Array();
		m_pointsList = new Array();
		
		//init new zone
		init();
	}
	
	/**
	 * get highest block in specified column
	 */
	public function highestBlock(_x:Int, _y:Int):Block
	{
		var _index:Int = m_columns[_x][_y].numChildren - 1;
		while (_index >= 0)
		{
			if (Std.is(m_columns[_x][_y].getChildAt(_index), Block))
			{
				var _block:Block = cast (m_columns[_x][_y].getChildAt(_index), Block);
				if (_block.solid)
					return _block;
			}
			_index--;
		}
		
		return null;
	}	
	
	/**
	 * get highest floor
	 */
	public function highestFloor():Int
	{
		var _floor:Int = 0;
		
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				var _length:Int = 0;
				for (k in 0...m_columns[i][j].numChildren)
				{
					if (cast(m_columns[i][j].getChildAt(k), Block).solid)
						_length++;
				}
				
				if (_floor < _length)
					_floor = _length;
			}
		}
		
		return _floor;
	}
	
	/**
	 * reset highLight column
	 */
	public function resetHighLightColumns():Void
	{
		if (contains(m_lightColumn))
		{
			while (m_lightColumn.numChildren > 0)
				m_lightColumn.removeChildAt(0);
			removeChild(m_lightColumn);
		}
	}
	
	/**
	 * highLight column
	 */
	public function highLightColumn(_x:Int, _y:Int):Void
	{
		resetHighLightColumns();
		
		//highlight empty cells
		var _length:Int = 0;
		for (i in 0...m_columns[_x][_y].numChildren)
		{
			if (cast (m_columns[_x][_y].getChildAt(i), Block).m_type != "light"
			&& cast (m_columns[_x][_y].getChildAt(i), Block).m_type != "bottom_void"
			&& cast (m_columns[_x][_y].getChildAt(i), Block).m_type != "left_void"
			&& cast (m_columns[_x][_y].getChildAt(i), Block).m_type != "right_void")
			_length++;
		}
		
		for (i in _length..._length + 1)
		{
			var _block = new Block("light");
			_block.xPos = Std.int(_x);
			_block.yPos = Std.int(_y);
			_block.zPos = Std.int(i);
			_block.x = 0;
			_block.y = - (i * Settings.BLOCK_LENGTH);
			m_lightColumn.addChild(_block);
		}
		
		m_lightColumn.x = m_columns[_x][_y].x;
		m_lightColumn.y = m_columns[_x][_y].y;
		addChildAt(m_lightColumn, getChildIndex(m_columns[_x][_y]) + 1);
	}
	
	/**
	 * highLight block (when playing block is bonus)
	 */
	public function highLightKubes(_type:String, _x:Int, _y:Int):Void
	{
		var _block:Block = highestBlock(_x, _y);
		
		switch (_type) 
		{
			case "option1":		if (_block != null)
									showOption1(_x, _y, _block.zPos + 1);
			
			case "option2":		if (_block != null)
									showOption2(_block.zPos + 1);
								else showOption2(0);
								
			case "option3":		if (_block != null)
									showOption3(_type, _x, _y, _block.zPos + 1);
								else showOption3(_type, _x, _y, 0);
									
			case "option4":		if (_block != null)
									showOption4(_x, _y, _block.zPos + 1);
			
			default:			if (_block != null)
									showDefault(_type, _x, _y, _block.zPos + 1);
		}
	}
	
	/**
	 * reset highLight block
	 */
	public function resetHighLightKubes():Void
	{
		for (x in 0...m_columns.length)
		{
			for (y in 0...m_columns[x].length)
			{
				var z:Int = m_columns[x][y].numChildren - 1;
				while (z >= 0)
				{
					var _block:Block = cast (m_columns[x][y].getChildAt(z), Block);
					if (_block.solid)
						_block.removeBlink();
					z--;
				}
			}
		}
		
	}
	
	/**
	 * highLight blocks for option1
	 */
	private function showOption1(_xPos:Int, _yPos:Int, _zPos:Int):Void
	{
		for (z in 0...m_columns[_xPos][_yPos].numChildren)
		{
			var _block:Block = cast(m_columns[_xPos][_yPos].getChildAt(z), Block);
			if (_block.solid)
				_block.blink();
		}
	}
	
	/**
	 * highLight blocks for option2
	 */
	private function showOption2(_zPos:Int):Void
	{
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				if (_zPos < m_columns[i][j].numChildren)
				{
					var _block:Block = cast(m_columns[i][j].getChildAt(_zPos), Block);
					if (_block.solid)
						_block.blink();
				}
			}
		}
	}
	
	/**
	 * highLight blocks for option3
	 */
	private function showOption3(_type, _xPos:Int, _yPos:Int, _zPos:Int):Void
	{
		var _adjacentBlocks:Array<Block> = new Array();
		var _block:Block;
		
		//BOTTOM block
		if (_zPos > 0)
		{
			var i:Int = m_columns[_xPos][_yPos].numChildren - 1;
			while (i >= 0)
			{
				_block = cast (m_columns[_xPos][_yPos].getChildAt(i), Block);
				if (_block.solid)
				{
					_adjacentBlocks.push(_block);
					break;
				}
				i--;
			}
		}
		//LEFT block
		if (_xPos > 0 && _zPos < m_columns[_xPos - 1][_yPos].numChildren)
		{
			_block = cast (m_columns[_xPos - 1][_yPos].getChildAt(_zPos), Block);
			if (_block.solid)
				_adjacentBlocks.push(_block);
		}
		//RIGHT block
		if (_xPos < Settings.CUBE_SIZE - 1 && _zPos < m_columns[_xPos + 1][_yPos].numChildren)
		{
			_block = cast (m_columns[_xPos + 1][_yPos].getChildAt(_zPos), Block);
			if (_block.solid)
				_adjacentBlocks.push(_block);
		}
		//REAR block
		if (_yPos > 0 && _zPos < m_columns[_xPos][_yPos - 1].numChildren)
		{
			_block = cast (m_columns[_xPos][_yPos - 1].getChildAt(_zPos), Block);
			if (_block.solid)
				_adjacentBlocks.push(_block);
		}
		//FRONT block
		if (_yPos  < Settings.CUBE_SIZE - 1 && _zPos < m_columns[_xPos][_yPos + 1].numChildren)
		{
			_block = cast (m_columns[_xPos][_yPos + 1].getChildAt(_zPos), Block);
			if (_block.solid)
				_adjacentBlocks.push(_block);
		}
		
		var _index:Int = _adjacentBlocks.length - 1;
		while (_index >= 0)
		{
			var _added:Block = _adjacentBlocks[_index];
			showDefault(_added.m_type, _added.xPos, _added.yPos, _added.zPos);
			_added.blink();
			
			_index--;
		}
	}
	
	/**
	 * highLight blocks for option4
	 */
	private function showOption4(_xPos:Int, _yPos:Int, _zPos:Int):Void
	{
		//search BOTTOM block -> define block color to highlight
		var _type:String = "";
		var i:Int = m_columns[_xPos][_yPos].numChildren - 1;
		while (i >= 0)
		{
			var _block:Block = cast (m_columns[_xPos][_yPos].getChildAt(i), Block);
			if (_block.solid)
			{
				_type = cast(m_columns[_xPos][_yPos].getChildAt(_zPos - 1), Block).m_type;
				break;
			}
			i--;
		}
			
		//search similar blocks
		for (x in 0...m_columns.length)
		{
			for (y in 0...m_columns[x].length)
			{
				for (z in 0...m_columns[x][y].numChildren)
				{
					var _tempBlock:Block = cast (m_columns[x][y].getChildAt(z), Block);
					if (_tempBlock.m_type == _type)
					{
						var _block:Block = cast(m_columns[x][y].getChildAt(z), Block);
						if (_block.solid)
							_block.blink();
					}
				}
			}
		}
	}
	
	/**
	 * highLight blocks (neighboor same type)
	 */
	private function showDefault(_type:String, _xPos:Int, _yPos:Int, _zPos:Int):Void
	{
		var _alreadyTest:Bool = false;
		var _posListSimilar:Array<Array<Int>>;
		var _posListToTest:Array<Array<Int>>;
		var _block:Block;
		
		if (!_alreadyTest)
		{
			var _added:Bool = false;
			_posListToTest = new Array();
			
			//search if BOTTOM block is same type -> start highlight
			if (_zPos > 0 && _zPos < m_columns[_xPos][_yPos].numChildren)
			{
				_block = cast (m_columns[_xPos][_yPos].getChildAt(_zPos), Block);
				if (_block.solid && _block.m_type == _type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if LEFT block is same type -> start highlight
			if (!_added && _xPos > 0 && _zPos < m_columns[_xPos - 1][_yPos].numChildren)
			{
				_block = cast (m_columns[_xPos - 1][_yPos].getChildAt(_zPos), Block);
				if (_block.solid && _block.m_type == _type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if RIGHT block is same type -> start highlight
			if (!_added && _xPos < Settings.CUBE_SIZE - 1 && _zPos < m_columns[_xPos + 1][_yPos].numChildren)
			{
				_block = cast (m_columns[_xPos + 1][_yPos].getChildAt(_zPos), Block);
				if (_block.solid && _block.m_type == _type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if REAR block is same type -> start highlight
			if (!_added && _yPos > 0 && _zPos < m_columns[_xPos][_yPos - 1].numChildren)
			{
				_block = cast (m_columns[_xPos][_yPos - 1].getChildAt(_zPos), Block);
				if (_block.solid && _block.m_type == _type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if FRONT block is same type -> start highlight
			if (!_added && _yPos  < Settings.CUBE_SIZE - 1 && _zPos < m_columns[_xPos][_yPos + 1].numChildren)
			{
				_block = cast (m_columns[_xPos][_yPos + 1].getChildAt(_zPos), Block);
				if (_block.solid && _block.m_type == _type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//search similar blocks
			_posListSimilar = new Array();
			for (x in 0...m_columns.length)
			{
				for (y in 0...m_columns[x].length)
				{
					for (z in 0...m_columns[x][y].numChildren)
					{
						var _tempBlock:Block = cast (m_columns[x][y].getChildAt(z), Block);
						if (_tempBlock.m_type == _type)
							_posListSimilar.push([_tempBlock.xPos, _tempBlock.yPos, _tempBlock.zPos]);
					}
				}
			}
			
			//search blocks to destroy
			var i:Int = 0;
			while (i < _posListToTest.length)
			{
				var j:Int = _posListSimilar.length - 1;
				while (j >= 0)
				{
					var _match:Bool = false;
					
					//left
					if (_posListSimilar[j][0] == _posListToTest[i][0] - 1 && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//right
					else if (_posListSimilar[j][0] == _posListToTest[i][0] + 1 && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//up
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] + 1 && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//down
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] - 1 && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//bottom
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2] - 1)
						_match = true;
					//top
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2] + 1)
						_match = true;
						
					if (_match)
					{
						_posListToTest.push([_posListSimilar[j][0], _posListSimilar[j][1], _posListSimilar[j][2]]);	
						_posListSimilar.splice(j, 1);
					}
					
					j--;
				}
				
				cast(m_columns[_posListToTest[i][0]][_posListToTest[i][1]].getChildAt(_posListToTest[i][2]), Block).blink();
				i++;
			}
		}
	}
	
	/**
	 * create new falling block
	 */
	public function newFallingBlock(_type:String, _health:Int, _x:Int, _y:Int, _z:Int):Void
	{
		resetKubeFaces();
		
		var _block:Block = new Block(_type, _health);
		_block.xPos = Std.int(_x);
		_block.yPos = Std.int(_y);
		_block.zPos = Std.int(_z);
		_block.x = 0;
		_block.y = - ((Settings.CUBE_SIZE) * Settings.BLOCK_LENGTH);
		m_fallingBlocks.push(_block);
		m_columns[_x][_y].addChild(_block);
	}
	
	/**
	 * update falling blocks position
	 */
	public function updateFallingBlocks():Bool
	{
		var _finished:Bool = true;
		var i:Int = m_fallingBlocks.length - 1;
		
		while (i >= 0)
		{
			m_fallingBlocks[i].y = Math.min( -m_fallingBlocks[i].zPos * Settings.BLOCK_LENGTH, m_fallingBlocks[i].y + Settings.FALLING_SPEED);
			
			if (m_fallingBlocks[i].y == -m_fallingBlocks[i].zPos * Settings.BLOCK_LENGTH)
			{
				m_falledBlocks.push(m_fallingBlocks[i]);
				m_fallingBlocks.splice(i, 1);	
				
				resetHighLightColumns();
			}
			else _finished = false;
			
			i--;
		}
		return _finished;
	}
	
	/**
	 * break blocks
	 */
	public function breakingBlocks():Int
	{
		resetKubeFaces();
		
		var _index:Int = m_falledBlocks.length - 1;
		m_blocksToRemove = new Array();
		
		while (_index >= 0)
		{
			var _block:Block = m_falledBlocks[_index];
			
			switch (_block.m_type) 
			{
				case "option1":		breakOption1(_block);
				case "option2":		breakOption2(_block);
				case "option3":		breakOption3(_block);
				case "option4":		breakOption4(_block);
				
				default: 			breakDefault(_block);
			}
		
			//
			m_falledBlocks.splice(_index, 1);
			_index--;
		}
		
		if (m_blocksToRemove.length > 0)
		{
			var i:Int = m_blocksToRemove.length - 1;

			while (i >= 0)
			{
				m_blocksToRemove[i].health--;
				m_blocksToRemove[i].init();
				m_blocksToRemove[i].explode();
				i--;
			}
				
			return m_blocksToRemove.length;
		}
				
		return 0;
	}
	
	/**
	 * break blocks (option 1)
	 * destroy a single column
	 */
	public function breakOption1(_block:Block):Void
	{
		var _nbAdd:Int = 0;
		for (z in 0...m_columns[_block.xPos][_block.yPos].numChildren)
		{
			_nbAdd++;
			m_blocksToRemove.push(cast (m_columns[_block.xPos][_block.yPos].getChildAt(z), Block));
		}
		displayPoints(_block, _nbAdd * Settings.BLOCK_POINTS * (Game.m_combo + 1));
	}
	
	/**
	 * break blocks (option 2)
	 * destroy a single floor
	 */
	public function breakOption2(_block:Block):Void
	{
		var _nbAdd:Int = 0;
		
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				if (_block.zPos < m_columns[i][j].numChildren)
				{
					_nbAdd++;
					m_blocksToRemove.push(cast (m_columns[i][j].getChildAt(_block.zPos), Block));
				}
			}
		}
		
		displayPoints(_block, _nbAdd * Settings.BLOCK_POINTS * (Game.m_combo + 1));
	}
	
	/**
	 * break blocks (option 3)
	 * make all adjacent blocks start an explode chain
	 */
	public function breakOption3(_block:Block):Void
	{
		var _adjacentBlocks:Array<Block> = new Array();
		
		//BOTTOM block
		if (_block.zPos > 0 && _block.zPos < m_columns[_block.xPos][_block.yPos].numChildren)
			_adjacentBlocks.push(cast (m_columns[_block.xPos][_block.yPos].getChildAt(_block.zPos - 1), Block));
		//LEFT block
		if (_block.xPos > 0 && _block.zPos < m_columns[_block.xPos - 1][_block.yPos].numChildren)
			_adjacentBlocks.push(cast (m_columns[_block.xPos - 1][_block.yPos].getChildAt(_block.zPos), Block));
		//RIGHT block
		if (_block.xPos < Settings.CUBE_SIZE - 1 && _block.zPos < m_columns[_block.xPos + 1][_block.yPos].numChildren)
			_adjacentBlocks.push(cast (m_columns[_block.xPos + 1][_block.yPos].getChildAt(_block.zPos), Block));
		//REAR block
		if (_block.yPos > 0 && _block.zPos < m_columns[_block.xPos][_block.yPos - 1].numChildren)
			_adjacentBlocks.push(cast (m_columns[_block.xPos][_block.yPos - 1].getChildAt(_block.zPos), Block));
		//FRONT block
		if (_block.yPos  < Settings.CUBE_SIZE - 1 && _block.zPos < m_columns[_block.xPos][_block.yPos + 1].numChildren)
			_adjacentBlocks.push(cast (m_columns[_block.xPos][_block.yPos + 1].getChildAt(_block.zPos), Block));
		
		var _index:Int = _adjacentBlocks.length - 1;
		while (_index >= 0)
		{
			var _addToRemove:Bool = false;
			var _added:Block = _adjacentBlocks[_index];
			breakDefault(_added);
			
			//search if current block to test not already in remove list
			for (i in 0...m_blocksToRemove.length)
			{
				if (_added == m_blocksToRemove[i])
				{
					_addToRemove = true;
					break;
				}
			}
			if (!_addToRemove)
				m_blocksToRemove.push(_added);
			
			//
			_adjacentBlocks.splice(_index, 1);
			_index--;
		}
		
		m_blocksToRemove.push(_block);
	}
	
	/**
	 * break blocks (option 4)
	 * destroy (1 hit) all blocks with same color on Kube 
	 * color defined by block on bottom block option
	 */
	public function breakOption4(_block:Block):Void
	{
		var _type:String = "";
		var _nbAdd:Int = 0;
		
		//search BOTTOM block -> define block color to explode
		if (_block.zPos > 0 && _block.zPos < m_columns[_block.xPos][_block.yPos].numChildren)
		{
			_type = cast(m_columns[_block.xPos][_block.yPos].getChildAt(_block.zPos - 1), Block).m_type;
		}
		
		//search similar blocks
		for (x in 0...m_columns.length)
		{
			for (y in 0...m_columns[x].length)
			{
				for (z in 0...m_columns[x][y].numChildren)
				{
					var _tempBlock:Block = cast (m_columns[x][y].getChildAt(z), Block);
					if (_tempBlock != _block && _tempBlock.m_type == _type)
					{
						_nbAdd++;
						m_blocksToRemove.push(_tempBlock);
					}
				}
			}
		}
		
		displayPoints(_block, _nbAdd * Settings.BLOCK_POINTS * (Game.m_combo + 1));
			
		m_blocksToRemove.push(_block);
	}
	
	/**
	 * break blocks (default)
	 */
	public function breakDefault(_block:Block):Void
	{
		var _alreadyTest:Bool = false;
		var _posListSimilar:Array<Array<Int>>;
		var _posListToTest:Array<Array<Int>>;
		var _nbAdd:Int = 0;
		
		//search if current block to test not already in remove list
		for (i in 0...m_blocksToRemove.length)
		{
			if (_block == m_blocksToRemove[i])
			{
				_alreadyTest = true;
				break;
			}
		}
		
		
		if (!_alreadyTest)
		{
			var _added:Bool = false;
			_posListToTest = new Array();
			
			//search if BOTTOM block is same type -> start explode
			if (_block.zPos > 0 && _block.zPos < m_columns[_block.xPos][_block.yPos].numChildren)
			{
				if (cast (m_columns[_block.xPos][_block.yPos].getChildAt(_block.zPos - 1), Block).m_type == _block.m_type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if LEFT block is same type -> start explode
			if (!_added && _block.xPos > 0 && _block.zPos < m_columns[_block.xPos - 1][_block.yPos].numChildren)
			{
				if (cast (m_columns[_block.xPos - 1][_block.yPos].getChildAt(_block.zPos), Block).m_type == _block.m_type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if RIGHT block is same type -> start explode
			if (!_added && _block.xPos < Settings.CUBE_SIZE - 1 && _block.zPos < m_columns[_block.xPos + 1][_block.yPos].numChildren)
			{
				if (cast (m_columns[_block.xPos + 1][_block.yPos].getChildAt(_block.zPos), Block).m_type == _block.m_type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if REAR block is same type -> start explode
			if (!_added && _block.yPos > 0 && _block.zPos < m_columns[_block.xPos][_block.yPos - 1].numChildren)
			{
				if (cast (m_columns[_block.xPos][_block.yPos - 1].getChildAt(_block.zPos), Block).m_type == _block.m_type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//if not found -> search if FRONT block is same type -> start explode
			if (!_added && _block.yPos  < Settings.CUBE_SIZE - 1 && _block.zPos < m_columns[_block.xPos][_block.yPos + 1].numChildren)
			{
				if (cast (m_columns[_block.xPos][_block.yPos + 1].getChildAt(_block.zPos), Block).m_type == _block.m_type)
				{
					_posListToTest.push([_block.xPos, _block.yPos, _block.zPos]);
					_added = true;
				}
			}
			
			//search similar blocks
			_posListSimilar = new Array();
			for (x in 0...m_columns.length)
			{
				for (y in 0...m_columns[x].length)
				{
					for (z in 0...m_columns[x][y].numChildren)
					{
						var _tempBlock:Block = cast (m_columns[x][y].getChildAt(z), Block);
						if (_tempBlock != _block && _tempBlock.m_type == _block.m_type)
							_posListSimilar.push([_tempBlock.xPos, _tempBlock.yPos, _tempBlock.zPos]);
					}
				}
			}
			
			//search blocks to destroy
			var i:Int = 0;
			while (i < _posListToTest.length)
			{
				var j:Int = _posListSimilar.length - 1;
				while (j >= 0)
				{
					var _match:Bool = false;
					
					//left
					if (_posListSimilar[j][0] == _posListToTest[i][0] - 1 && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//right
					else if (_posListSimilar[j][0] == _posListToTest[i][0] + 1 && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//up
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] + 1 && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//down
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] - 1 && _posListSimilar[j][2] == _posListToTest[i][2])
						_match = true;
					//bottom
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2] - 1)
						_match = true;
					//top
					else if (_posListSimilar[j][0] == _posListToTest[i][0] && _posListSimilar[j][1] == _posListToTest[i][1] && _posListSimilar[j][2] == _posListToTest[i][2] + 1)
						_match = true;
						
					if (_match)
					{
						_posListToTest.push([_posListSimilar[j][0], _posListSimilar[j][1], _posListSimilar[j][2]]);	
						_posListSimilar.splice(j, 1);
					}
					
					j--;
				}
				
				_nbAdd++;
				m_blocksToRemove.push(cast (m_columns[_posListToTest[i][0]][_posListToTest[i][1]].getChildAt(_posListToTest[i][2]), Block));
				i++;
			}
		}
		
		if (_nbAdd > 0)
			displayPoints(_block, _nbAdd * Settings.BLOCK_POINTS * (Game.m_combo + 1));
	}
	
	/**
	 * remove block list
	 */
	private function removeBlocks():Void
	{
		var i:Int = m_blocksToRemove.length - 1;
		
		while (i >= 0)
		{
			if (m_blocksToRemove[i].updateExplode())
			{
				if (m_blocksToRemove[i].health == 0)
					m_columns[m_blocksToRemove[i].xPos][m_blocksToRemove[i].yPos].removeChild(m_blocksToRemove[i]);
				m_blocksToRemove.splice(i, 1);
			}
			i--;
		}
	}
	
	
	/**
	 * search if all blocks to break are destroyed
	 */
	public function updateBreakingBlocks():Bool
	{
		removeBlocks();
			
		if (m_blocksToRemove.length > 0)
			return false;
			
		return true;
	}
	
	/**
	 * search blocks that have to fall
	 */
	public function searchBlocksToFall():Bool
	{
		var _toFall:Bool = false;
		
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				for (k in 0...m_columns[i][j].numChildren)
				{
					var _block:Block = cast (m_columns[i][j].getChildAt(k), Block);
					
					if (_block.zPos > k)
					{
						_block.zPos = k;
						m_fallingBlocks.push(_block);
						_toFall = true;
					}
				}
			}
		}
		
		return _toFall;
	}
	
	/**
	 * generate points
	 */
	private function displayPoints(_block:Block, _value:Int):Void
	{
		var _points:MovieClip = new MovieClip();
		_points.x = m_groundPosX[_block.xPos][_block.yPos] + Math.random() * 40 - 20;
		_points.y = m_groundPosY[_block.xPos][_block.yPos] - _block.zPos * Settings.BLOCK_LENGTH + Math.random() * 40 - 20;
		_points.yToReach = _points.y - 50;
		_points.time = 0;
		_points.mouseEnabled = false;
		
		var _textFormat:TextFormat = new TextFormat();
		_textFormat.align = TextFormatAlign.CENTER;
		_textFormat.font = "Impact";
		_textFormat.size = 16 + Math.floor(_value / 50);
		
		var _score:TextField = new TextField();
		_score.defaultTextFormat = _textFormat;
		_score.embedFonts = true;
		_score.antiAliasType = AntiAliasType.ADVANCED;
		_score.text = Std.string(_value);
		_score.textColor = _block.m_color;
		_score.x = -_score.width / 2;
		_score.mouseEnabled = false;
		
		var _glow:GlowFilter = new GlowFilter(0xffffff, 1, 3, 3, 5, 3);
		_score.filters = [_glow];
		
		_points.addChild(_score);
		_points.cacheAsBitmap = true;
		
		addChild(_points);
		m_pointsList.push(_points);
	}
	
	/**
	 * update points
	 */
	private function updateDisplayPoints(_event:Event = null):Void
	{
		var _index:Int = m_pointsList.length - 1;
		while (_index >= 0)
		{
			m_pointsList[_index].time++;
			
			if (m_pointsList[_index].time <= 30)
				m_pointsList[_index].y += ( m_pointsList[_index].yToReach - m_pointsList[_index].y) * 0.1;
			
			if (m_pointsList[_index].time > 40)
				m_pointsList[_index].alpha -= 0.05;
			
			if (m_pointsList[_index].alpha <= 0)
			{
				removeChild(m_pointsList[_index]);
				m_pointsList.splice(_index, 1);
			}
			
			_index--;
		}
	}
	
	
	/**
	 * rotate wiew
	 */
	public function rotateView(_delta:Int):Void
	{
		var _columnsCopy:Array<Array<Sprite>> = new Array();
	
		//clone array
		for (i in 0...m_columns.length)
		{
			_columnsCopy[i] = new Array();
			for (j in 0...m_columns[i].length)
				_columnsCopy[i][j] = m_columns[i][j];
		}
		
		//update columns pos
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				if (_delta > 0)
					m_columns[i][j] = _columnsCopy[(Settings.CUBE_SIZE - 1) - j][i];
				else m_columns[i][j] = _columnsCopy[j][(Settings.CUBE_SIZE - 1) - i];
				
				addChild(m_columns[i][j]);
				
				for (k in 0...m_columns[i][j].numChildren)
				{
					cast (m_columns[i][j].getChildAt(k), Block).xPos = i;
					cast (m_columns[i][j].getChildAt(k), Block).yPos = j;
					cast (m_columns[i][j].getChildAt(k), Block).zPos = k;
				}
			}
		}
		
		resetKubeFaces();
	}
	
	/**
	 * update rotate wiew
	 */
	public function updateRotateView():Bool
	{
		//update columns pos
			
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				m_columns[i][j].x += (m_groundPosX[i][j] - m_columns[i][j].x) * 0.4;
				m_columns[i][j].y += (m_groundPosY[i][j] - m_columns[i][j].y) * 0.4;
			}
		}
		
		if (Math.abs(m_groundPosX[0][0] - m_columns[0][0].x) < 1 && Math.abs(m_groundPosY[0][0] - m_columns[0][0].y) < 1)
		{
			updateKubeFaces();
			return true;
		}
		
		return false;
	}
	
	/**
	 * reset cubes faces
	 */
	public function resetKubeFaces():Void
	{
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				var k:Int = m_columns[i][j].numChildren - 1;
				while (k >= 0)
				{
					if (cast (m_columns[i][j].getChildAt(k), Block).m_type == "left_void" || cast (m_columns[i][j].getChildAt(k), Block).m_type == "right_void" || cast (m_columns[i][j].getChildAt(k), Block).m_type == "bottom_void")
						m_columns[i][j].removeChildAt(k);
					k--;
				}
			}
		}
	}
	
	/**
	 * update cubes faces (make void columns clickable)
	 */
	public function updateKubeFaces():Void
	{
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				for (k in m_columns[i][j].numChildren...Settings.CUBE_SIZE)
				{
					//bottom side
					if (k == 0 && m_columns[i][j].numChildren == 0)
					{
						var _block = new Block("bottom_void");
						_block.xPos = Std.int(i);
						_block.yPos = Std.int(j);
						_block.zPos = Std.int(k);
						_block.x = 0;
						_block.y = - (k * Settings.BLOCK_LENGTH);
						m_columns[i][j].addChild(_block);
					}
					
					//left side
					if (j == 0 || (m_columns[i][j - 1].numChildren > k && cast(m_columns[i][j - 1].getChildAt(k), Block).solid))
					{
						var _block = new Block("left_void");
						_block.xPos = Std.int(i);
						_block.yPos = Std.int(j);
						_block.zPos = Std.int(k);
						_block.x = 0;
						_block.y = - (k * Settings.BLOCK_LENGTH);
						m_columns[i][j].addChild(_block);
					}
					
					//right side
					if (i == 0 || (m_columns[i - 1][j].numChildren > k && cast(m_columns[i - 1][j].getChildAt(k), Block).solid))
					{
						var _block = new Block("right_void");
						_block.xPos = Std.int(i);
						_block.yPos = Std.int(j);
						_block.zPos = Std.int(k);
						_block.x = 0;
						_block.y = - (k * Settings.BLOCK_LENGTH);
						m_columns[i][j].addChild(_block);
					}
				}
			}
		}
	}
	
	/**
	 * set max floor 
	 */
	public function setNewFloors():Int
	{
		var _maxHeight:Int = highestFloor();
	
		//get number of floors to add
		if (Settings.CUBE_SIZE - _maxHeight > 0)
		{
			//add new floors
			for (i in 0...m_columns.length)
			{
				for (j in 0...m_columns[i].length)
				{
					var _length:Int = Settings.CUBE_SIZE - _maxHeight;
					for (k in 0..._length)
					{
						var _block = new Block();
						_block.xPos = Std.int(i);
						_block.yPos = Std.int(j);
						_block.x = 0;
						_block.y = (k + 1) * Settings.BLOCK_LENGTH;
						m_columns[i][j].addChildAt(_block, 0);
					}
				}
			}
		
			//set new z order
			for (i in 0...m_columns.length)
			{
				for (j in 0...m_columns[i].length)
				{
					for (k in 0...m_columns[i][j].numChildren)
					{
						var _block:Block = cast (m_columns[i][j].getChildAt(k), Block);
						_block.zPos = k;
					}
				}
			}
		}
		
		return (Settings.CUBE_SIZE - _maxHeight);
	}
	
	/**
	 * update max floor 
	 */
	public function updateKubeMaxFloor():Bool
	{
		for (i in 0...m_columns.length)
		{
			for (j in 0...m_columns[i].length)
			{
				for (k in 0...m_columns[i][j].numChildren)
				{
					var _block:Block = cast (m_columns[i][j].getChildAt(k), Block);
					_block.y +=  ((-_block.zPos * Settings.BLOCK_LENGTH) - _block.y) * 0.3;
				}
			}
		}
		
		var _block:Block = cast (m_columns[0][0].getChildAt(0), Block);
		if (Math.abs((-_block.zPos * Settings.BLOCK_LENGTH) - _block.y) < 1)
			return true;
		
		return false;
	}
}