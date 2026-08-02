surface_set_target(text_surf);
draw_clear_alpha(c_black, 0);
draw_set_font(fnt_maplemono_SDF);
draw_set_halign(fa_left);
var px = textview[0];
var py = textview[1];
var _g = 0;
var _scis = gpu_get_scissor();
var _lendata = array_length(data)
repeat _lendata{
	draw_text(4, py + _g*20, _g+1);
	_g++;
}
_g = 0;
gpu_set_scissor(40, 0, 1000, 1000);
var _cwdt = string_width(" ");
var tx = px + 44;
repeat array_length(cursors){
	var _cur = cursors[_g];
	if _cur.selection != -1{
		switch cursor_position_to_anchor(_cur){
			case 1: //cursor is lines below
			draw_rectangle_colour(tx, py + _cur.line*20, tx + _cur.pos*_cwdt, py + _cur.line*20 + 20, c_gray, c_gray, c_gray, c_gray, 0)
			draw_rectangle_colour(tx + _cur.selection[0]*_cwdt, py + _cur.selection[1]*20, tx + string_length(data[_cur.selection[1]])*_cwdt, py + _cur.selection[1]*20 + 20, c_gray, c_gray, c_gray, c_gray, 0)
			var _t = 1;
			repeat max(abs(_cur.line - _cur.selection[1]) - 1, 0){
				draw_rectangle_colour(tx, py + (_cur.selection[1]+_t)*20, tx + string_length(data[_cur.selection[1]+_t])*_cwdt, py + (_cur.selection[1]+_t+1)*20, c_gray, c_gray, c_gray, c_gray, 0)
				_t++;
			}
			break;
			
			case 0: //cursor is on the same line
			draw_rectangle_colour(tx + min(_cur.pos, _cur.selection[0])*_cwdt, py + _cur.line*20, tx + max(_cur.pos, _cur.selection[0])*_cwdt, py + _cur.line*20 + 20, c_gray, c_gray, c_gray, c_gray, 0)
			break;
			
			case -1: //cursor is lines above
			draw_rectangle_colour(tx, py + _cur.selection[1]*20, tx + _cur.selection[0]*_cwdt, py + _cur.selection[1]*20 + 20, c_gray, c_gray, c_gray, c_gray, 0)
			draw_rectangle_colour(tx + _cur.pos*_cwdt, py + _cur.line*20, tx + string_length(data[_cur.line])*_cwdt, py + _cur.line*20 + 20, c_gray, c_gray, c_gray, c_gray, 0)
			_t = 1;
			repeat max(abs(_cur.line - _cur.selection[1]) - 1, 0){
				draw_rectangle_colour(tx, py + (_cur.line+_t)*20, tx + string_length(data[_cur.line+_t])*_cwdt, py + (_cur.line+_t+1)*20, c_gray, c_gray, c_gray, c_gray, 0)
				_t++;
			}
			break;
		}
	}
	if showcursors%60 < 30 draw_text(tx - _cwdt/2 + _cwdt*_cur.pos, py + _cur.line*20, "|");
	_g++;
}
_g = 0;
repeat array_length(data){
	draw_text(tx, py + _g*20, data[_g]);
	_g++;
}
gpu_set_scissor(_scis, 0, 10000, 10000);
surface_reset_target();