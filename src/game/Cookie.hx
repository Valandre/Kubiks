package game;
import flash.net.SharedObject;
	
/**
 * ...
 * @author bstouls
 */

class Cookie 
{
	private var m_so:SharedObject;
        
	public function new(_name:String) 
	{
		m_so = SharedObject.getLocal(_name);
	}
	
        
	public function read(_field:String):String
	{
		switch (_field) 
		{
			case "lastScore":		if (m_so.data.lastScore) 
										return m_so.data.lastScore;
			case "bestScore":		if (m_so.data.bestScore) 
										return m_so.data.bestScore;
			case "depthMax":		if (m_so.data.depthMax) 
										return m_so.data.depthMax;
			case "comboMax":		if (m_so.data.comboMax) 
										return m_so.data.comboMax;
			case "blockDropped":	if (m_so.data.blockDropped) 
										return m_so.data.blockDropped;
			case "blockDestroyed":	if (m_so.data.blockDestroyed) 
										return m_so.data.blockDestroyed;
			default:
				
		}
		return "";	
	}

	public function write(_field:String , _value:String):Void
	{
		switch (_field) 
		{
			case "lastScore":		m_so.data.lastScore = _value; 
			case "bestScore":		m_so.data.bestScore = _value; 
			case "depthMax":		m_so.data.depthMax = _value; 
			case "comboMax":		m_so.data.comboMax = _value; 
			case "blockDropped":	m_so.data.blockDropped = _value; 
			case "blockDestroyed":	m_so.data.blockDestroyed = _value; 
			default:
				
		}
		m_so.flush();
	}
}
