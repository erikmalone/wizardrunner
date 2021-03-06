package ;

import flash.events.Event;
import flash.text.TextField;
import flash.text.TextFormat;
import haxe.Timer;

class CustomFPS extends TextField
{
    
    public var fs: Int;
    private var ms: Float;
    
    public function new()
    {
       super();
        
        var format: TextFormat = new TextFormat();
    
        format.color = 0xff0000;
        format.size = 14;
        format.bold = true;
        format.font = 'Verdana';
        backgroundColor = 0;
		background = true;
        textColor = 0xff0000;
        autoSize = flash.text.TextFieldAutoSize.LEFT;
        defaultTextFormat = format;
        
        ms = Timer.stamp();
        fs = 0;
    }
    
    public function nextFrame(): Void
    {
        if( Timer.stamp() - 1. > ms )
        {
            ms = Timer.stamp();
            text = "FPS:" + Std.string( fs );
            fs = 0;
        }
        else
        {
            ++fs;
        }
		
    }
    
}