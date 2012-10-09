package ;

import flash.display.Loader;
import flash.display.MovieClip;
import flash.display.Sprite;
import flash.display.StageAlign;
import flash.display.StageScaleMode;
import flash.net.URLRequest;
import flash.Lib;
import flash.events.IOErrorEvent;
import flash.events.HTTPStatusEvent;
import flash.events.Event;
import flash.display.Bitmap;
import flash.events.ProgressEvent;

import game.Cookie;
import game.EndGame;
import game.MainEvent;
import game.Menu;
import game.Settings;

import game.Game;
import game.SkinLibrary;

/**
 * ...
 * @author bstouls
 */

class Main 
{
	static private var m_imagesLoader:Loader;
	static private var m_game:Game;
	static private var m_menu:Menu;
	static private var m_end:EndGame;
	
	static private var m_loadBar:Sprite;
	
	static public var m_lastScore:Array<Int>;
	static public var m_bestScore:Array<Int>;
	static public var m_depthMax:Int;
	static public var m_comboMax:Int;
	static public var m_blockDropped:Int;
	static public var m_blockDestroyed:Int;
	static public var m_cookie:Cookie;
	
	static public var m_wait:Int;
	
	static function main() 
	{
		var stage = Lib.current.stage;
		stage.scaleMode = StageScaleMode.NO_SCALE;
		stage.align = StageAlign.TOP_LEFT;
		
		//cookie access
		m_cookie = new Cookie("kubix");
		
		//init stats data
		m_lastScore = new Array();
		m_bestScore = new Array();
		
		var _lastScore:String = m_cookie.read("lastScore");
		if (_lastScore != "")
		{
			var _scoreValues:Array<String> = _lastScore.split("-");
			m_lastScore[0] = Std.parseInt(_scoreValues[0]);
			m_lastScore[1] = Std.parseInt(_scoreValues[1]);
		}
		
		var _bestScore:String = m_cookie.read("bestScore");
		if (_bestScore != "")
		{
			var _scoreValues:Array<String> = _bestScore.split("-");
			m_bestScore[0] = Std.parseInt(_scoreValues[0]);
			m_bestScore[1] = Std.parseInt(_scoreValues[1]);
		}
		
		var _maxDepth:String = m_cookie.read("depthMax");
		if (_maxDepth != "")
			m_depthMax = Std.parseInt(_maxDepth);
		
		var _maxCombo:String = m_cookie.read("comboMax");
		if (_maxCombo != "")
			m_comboMax = Std.parseInt(_maxCombo);
		
		var _totalBlock:String = m_cookie.read("blockDropped");
		if (_totalBlock != "")
			m_blockDropped = Std.parseInt(_totalBlock);
		
		var _totalDestroyed:String = m_cookie.read("blockDestroyed");
		if (_totalDestroyed != "")
			m_blockDestroyed = Std.parseInt(_totalDestroyed);
		
		
		//add progress bar
		m_loadBar = new Sprite();
		m_loadBar.graphics.clear();
		m_loadBar.graphics.lineStyle(1, 0xeeeeee);
		m_loadBar.graphics.drawRect(Settings.STAGE_WIDTH / 4 - 2, Settings.STAGE_HEIGHT / 2 - 2, (Settings.STAGE_WIDTH / 2) + 4, 6 + 4);
		Lib.current.addChild(m_loadBar);
		
		//load assets
		loadAssets();
	}
	
	static private function mainStart(_event:Event = null):Void
	{
		//init
		if (m_end != null)
		{
			if (Lib.current.contains(m_end))
				Lib.current.removeChild(m_end);
			m_end.removeEventListener("start_game", startGame);
			m_end.removeEventListener("back_menu", mainStart);
		}
		
		if (m_game != null)
		{
			if (Lib.current.contains(m_game))
				Lib.current.removeChild(m_game);
			m_game.removeEventListener("end_game", endGame);
			m_game.removeEventListener("back_menu", mainStart);
		}
		
		//start application
		m_menu = new Menu();
		Lib.current.addChild(m_menu);
		m_menu.addEventListener("start_game", startGame);
	}
	
	static private function startGame(_event:Event = null):Void
	{
		//init
		if (Lib.current.contains(m_menu))
			Lib.current.removeChild(m_menu);
		
		if (m_end != null)
		{
			if (Lib.current.contains(m_end))
				Lib.current.removeChild(m_end);
			m_end.removeEventListener("start_game", startGame);
			m_end.removeEventListener("back_menu", mainStart);
		}
		
		if (m_menu != null)
			m_menu.removeEventListener("start_game", startGame);
		
		//start game
		m_game = new Game();
		Lib.current.addChild(m_game);
		m_game.addEventListener("end_game", endGame);
		m_game.addEventListener("back_menu", mainStart);
	}
	
	static private function endGame(_event:MainEvent = null):Void
	{
		//init
		if (m_game != null)
		{
			if (Lib.current.contains(m_game))
				Lib.current.removeChild(m_game);
			m_game.removeEventListener("end_game", startGame);
			m_game.removeEventListener("back_menu", mainStart);
		}
		
		//update stats data
		var _totalScore:Array<Int> = calculateScore(_event.data.get("score"), _event.data.get("depth"));
		
		m_lastScore[0] = _totalScore[0];
		m_lastScore[1] = Std.parseInt(_event.data.get("depth"));
		m_cookie.write("lastScore", m_lastScore[0] + "-" + m_lastScore[1]);

		if (m_lastScore[0] > m_bestScore[0])
		{
			m_bestScore[0] = m_lastScore[0];
			m_bestScore[1] = m_lastScore[1];
			m_cookie.write("bestScore", m_bestScore[0] + "-" + m_bestScore[1]);
		}
		
		if (Std.parseInt(_event.data.get("depth")) > m_depthMax)
		{
			m_depthMax = Std.parseInt(_event.data.get("depth"));
			m_cookie.write("depthMax", _event.data.get("depth"));
		}
		
		if (m_comboMax >  Std.parseInt(m_cookie.read("comboMax")))
			m_cookie.write("comboMax", Std.string(m_comboMax));
		if (m_blockDropped >  Std.parseInt(m_cookie.read("blockDropped")))
			m_cookie.write("blockDropped", Std.string(m_blockDropped));
		if (m_blockDestroyed >  Std.parseInt(m_cookie.read("blockDestroyed")))
			m_cookie.write("blockDestroyed", Std.string(m_blockDestroyed));
		
		
		//end game
		m_end = new EndGame(_totalScore[0], _totalScore[1], Std.parseInt(_event.data.get("score")), Std.parseInt(_event.data.get("depth")), Game.m_combo);
		Lib.current.addChild(m_end);
		m_end.addEventListener("start_game", startGame);
		m_end.addEventListener("back_menu", mainStart);
	}
	
	static private function calculateScore(_score:String, _depth:String):Array<Int>
	{
		//calculte depth bonus
		var _meters:Int = Std.parseInt(_depth);
		var _bonus:Int = 0;
		
		for (i in 0..._meters)
			_bonus += Settings.METERS_BONUS_COEFF * (i + 1);
			
		var _total:Int = _bonus;
		_total += Std.parseInt(_score);
		
		return [_total, _bonus];
	}

	
	static private function loadAssets():Void
	{
		var _request:URLRequest = new URLRequest(); 
		_request.url = "img/assets.png?nocache=" + Date.now();
		
		m_imagesLoader = new Loader();
		m_imagesLoader.load(_request);
		
		m_imagesLoader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadingImageComplete);
		m_imagesLoader.contentLoaderInfo.addEventListener(HTTPStatusEvent.HTTP_STATUS, codeHTTP);
		m_imagesLoader.contentLoaderInfo.addEventListener(IOErrorEvent.IO_ERROR, IOErrorHandler);
		m_imagesLoader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressEvent);
	}

	static private function loadingImageComplete(_event:Event):Void
	{
		SkinLibrary.setImage(cast(m_imagesLoader.content, Bitmap));
		
		//update progress bar
		m_loadBar.graphics.clear();
		m_loadBar.graphics.lineStyle(1, 0xeeeeee);
		m_loadBar.graphics.drawRect(Settings.STAGE_WIDTH / 4 - 2, Settings.STAGE_HEIGHT / 2 - 2, (Settings.STAGE_WIDTH / 2) + 4, 6 + 4);
		m_loadBar.graphics.beginFill(0xeeeeee);
		m_loadBar.graphics.drawRect(Settings.STAGE_WIDTH / 4, Settings.STAGE_HEIGHT / 2, Settings.STAGE_WIDTH / 2, 6);
		
		//add delay before display main menu
		m_wait = 0;
		Lib.current.addEventListener(Event.ENTER_FRAME, delay);
	} 	
		
	static private function delay(_event:Event):Void
	{
		if (m_wait++ == 10)
		{		
			Lib.current.removeChild(m_loadBar);
			mainStart();
			Lib.current.removeEventListener(Event.ENTER_FRAME, delay);
		}
	} 	
		
	static private function progressEvent (_event:ProgressEvent):Void
	{
		//update progress bar
		m_loadBar.graphics.clear();
		m_loadBar.graphics.lineStyle(1, 0xeeeeee);
		m_loadBar.graphics.drawRect(Settings.STAGE_WIDTH / 4 - 2, Settings.STAGE_HEIGHT / 2 - 2, (Settings.STAGE_WIDTH / 2) + 4, 6 + 4);
		m_loadBar.graphics.beginFill(0xeeeeee);
		m_loadBar.graphics.drawRect(Settings.STAGE_WIDTH / 4, Settings.STAGE_HEIGHT / 2, (Settings.STAGE_WIDTH / 2) * _event.bytesLoaded / _event.bytesTotal, 6);
	}
		
	static private function IOErrorHandler (_event:IOErrorEvent):Void
	{
		//trace(_event.text);
	}
	
	static private function codeHTTP(_event:HTTPStatusEvent):Void
	{
		//trace("code HTTP: " + _event.status);
	}
}