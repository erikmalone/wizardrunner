package hold.en.wiz.mere.uibasics;

import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.text.TextFormat;
import flash.text.TextFormatAlign;
class MereText extends TextField {
	public var format:TextFormat;
	public function new(txt:String,_color:UInt,_size:Int,?_font:Font) {
		super();
		format = new TextFormat();
		format.size = _size;
		format.color = _color;
		format.bold = true;
		format.align = TextFormatAlign.JUSTIFY;
		if (_font != null) {format.font = _font.fontName; embedFonts = true; }
		autoSize = TextFieldAutoSize.LEFT;
		defaultTextFormat = format;
		text = txt;	
	}
}