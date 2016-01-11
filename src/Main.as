package
{
	import flash.display.Sprite;
	import flash.events.Event;
	import screens.GameOverScreen;
	import screens.GameScreen;
	import screens.IntroScreen;
	import screens.WinnerScreen;
	import sounds.SoundPlayer;
	
	/**
	 * ...
	 * @author Tommy 
	 * 
	 * 
	 * 
	 * */
	public class Main extends Sprite 
	{
		private var gameScreen:GameScreen
		private var introScreen:IntroScreen;
		private var gameOverScreen:GameOverScreen;
		private var soundPlayer:SoundPlayer;
		private var winnerScreen:WinnerScreen;
		
		public function Main() 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point			
			soundPlayer = new SoundPlayer(this);
			buildIntroSreen();	
		}
		private function buildIntroSreen():void
		{			
			introScreen = new IntroScreen();
			addChild(introScreen);
			introScreen.addEventListener(IntroScreen.START_GAME, startGame);
		}
		private function startGame(e:Event):void 
		{
			removeChild(introScreen);
			gameScreen = new GameScreen();
			addChild(gameScreen);
			gameScreen.addEventListener(GameScreen.GAME_OVER, onGameOver);
			gameScreen.addEventListener(GameScreen.WIN, onGameWin);
			
			
			
		}		
	
		private function onGameOver(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.GAME_OVER, onGameOver);
						
			gameOverScreen = new GameOverScreen();
			addChild(gameOverScreen);
			gameOverScreen.addEventListener(GameOverScreen.RESET, onReset);
			
			
			
		}		
		private function onGameWin(e:Event):void 
		{
			removeChild(gameScreen);
			gameScreen.removeEventListener(GameScreen.WIN, onGameWin);
						
			winnerScreen = new WinnerScreen();
			addChild(winnerScreen);
			winnerScreen.addEventListener(WinnerScreen.RESET, onReset);
			
			
			
		}
		private function onReset(e:Event):void 
		{
			if (gameOverScreen != null)
			{
				removeChild(gameOverScreen);
				gameOverScreen.removeEventListener(GameOverScreen.RESET, onReset);
			}
			else if (winnerScreen != null)
			{
				removeChild(winnerScreen);
				winnerScreen.removeEventListener(WinnerScreen.RESET, onReset);
			}
			buildIntroSreen();
		}
		
	}
	
}