package game;
import flash.events.Event;
	
/**
 * ...
 * @author bstouls
 */

class MainEvent extends Event
{
	public var data:Hash<String>;
	
	//
	public static var END_GAME:String 		= "end_game";
		
	
	public function new(type:String, _data:Hash<String> = null, bubbles:Bool = false, cancelable:Bool = false) 
	{
		data = _data;
		super(type, bubbles, cancelable);
	}
	
	public override function clone ():Event
	{
		return new MainEvent(type, data, bubbles, cancelable);
	}
	
	public override function toString ():String
	{
		return formatToString("GameEvent", "type", "data", "bubbles", "cancelable", "eventPhase");
	}
}
