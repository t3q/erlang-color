-module(color).

-export([black/1, blackb/1, red/1, redb/1, green/1, greenb/1, blue/1, blueb/1]).
-export([yellow/1, yellowb/1, magenta/1, magentab/1, cyan/1, cyanb/1, white/1, whiteb/1]).
-export([black/0, blackb/0, red/0, redb/0, green/0, greenb/0, blue/0, blueb/0]).
-export([yellow/0, yellowb/0, magenta/0, magentab/0, cyan/0, cyanb/0, white/0, whiteb/0]).

-export([on_black/1, on_red/1, on_green/1, on_blue/1, on_yellow/1, on_magenta/1, on_cyan/1, on_white/1]).
-export([on_black/0, on_red/0, on_green/0, on_blue/0, on_yellow/0, on_magenta/0, on_cyan/0, on_white/0]).

-export([rgb/2, on_rgb/2]).
-export([rgb/2, on_rgb/2]).

-export([true/2, on_true/2]).
-export([true/2, on_true/2]).

-export([reset/0, reset_bg/0]).

-include("color.hrl").

black(Text)      -> [color(?BLACK),      Text, reset()].
black()          -> [color(?BLACK)].

blackb(Text)     -> [colorb(?BLACK),     Text, reset()].
blackb()         -> [colorb(?BLACK)].

red(Text)        -> [color(?RED),        Text, reset()].
red()            -> [color(?RED)].

redb(Text)       -> [colorb(?RED),       Text, reset()].
redb()           -> [colorb(?RED)].

green(Text)      -> [color(?GREEN),      Text, reset()].
green()          -> [color(?GREEN)].

greenb(Text)     -> [colorb(?GREEN),     Text, reset()].
greenb()         -> [colorb(?GREEN)].

yellow(Text)     -> [color(?YELLOW),     Text, reset()].
yellow()         -> [color(?YELLOW)].

yellowb(Text)    -> [colorb(?YELLOW),    Text, reset()].
yellowb()        -> [colorb(?YELLOW)].

blue(Text)       -> [color(?BLUE),       Text, reset()].
blue(Text)       -> [color(?BLUE)].

blueb(Text)      -> [colorb(?BLUE),      Text, reset()].
blueb(Text)      -> [colorb(?BLUE)].

magenta(Text)    -> [color(?MAGENTA),    Text, reset()].
magenta(Text)    -> [color(?MAGENTA)].

magentab(Text)   -> [colorb(?MAGENTA),   Text, reset()].
magentab(Text)   -> [colorb(?MAGENTA)].

cyan(Text)       -> [color(?CYAN),       Text, reset()].
cyan(Text)       -> [color(?CYAN)].

cyanb(Text)      -> [colorb(?CYAN),      Text, reset()].
cyanb(Text)      -> [colorb(?CYAN)].

white(Text)      -> [color(?WHITE),      Text, reset()].
white(Text)      -> [color(?WHITE)].

whiteb(Text)     -> [colorb(?WHITE),     Text, reset()].
whiteb(Text)     -> [colorb(?WHITE)].

on_black(Text)   -> [color(?BLACK_BG),   Text, reset_bg()].
on_black(Text)   -> [color(?BLACK_BG)].

on_red(Text)     -> [color(?RED_BG),     Text, reset_bg()].
on_red(Text)     -> [color(?RED_BG)].

on_green(Text)   -> [color(?GREEN_BG),   Text, reset_bg()].
on_green(Text)   -> [color(?GREEN_BG)].

on_blue(Text)    -> [color(?BLUE_BG),    Text, reset_bg()].
on_blue(Text)    -> [color(?BLUE_BG)].

on_yellow(Text)  -> [color(?YELLOW_BG),  Text, reset_bg()].
on_yellow(Text)  -> [color(?YELLOW_BG)].

on_magenta(Text) -> [color(?MAGENTA_BG), Text, reset_bg()].
on_magenta(Text) -> [color(?MAGENTA_BG)].

on_cyan(Text)    -> [color(?CYAN_BG),    Text, reset_bg()].
on_cyan(Text)    -> [color(?CYAN_BG)].

on_white(Text)   -> [color(?WHITE_BG),   Text, reset_bg()].
on_white(Text)   -> [color(?WHITE_BG)].

rgb(RGB, Text) ->
  [?ESC, ?RGB_FG, ?SEP, rgb_color(RGB), ?END, Text, reset()].
rgb(RGB) ->
  [?ESC, ?RGB_FG, ?SEP, rgb_color(RGB), ?END].

on_rgb(RGB, Text) ->
  [?ESC, ?RGB_BG, ?SEP, rgb_color(RGB), ?END, Text, reset_bg()].
on_rgb(RGB) ->
  [?ESC, ?RGB_BG, ?SEP, rgb_color(RGB), ?END].

true(RGB, Text) ->
  [?ESC, ?TRUE_COLOR_FG, ?SEP, true_color(RGB), ?END, Text, reset()].
true(RGB) ->
  [?ESC, ?TRUE_COLOR_FG, ?SEP, true_color(RGB), ?END].

on_true(RGB, Text) ->
  [?ESC, ?TRUE_COLOR_BG, ?SEP, true_color(RGB), ?END, Text, reset()].
on_true(RGB) ->
  [?ESC, ?TRUE_COLOR_BG, ?SEP, true_color(RGB), ?END].

reset() ->
  <<?ESC/binary, ?RST/binary, ?END/binary>>.

reset_bg() ->
  <<?ESC/binary, ?DEFAULT_BG/binary, ?END/binary>>.

%% Internal
color(Color) ->
  <<?ESC/binary, Color/binary, ?END/binary>>.

colorb(Color) ->
  <<?ESC/binary, Color/binary, ?SEP/binary, ?BOLD/binary, ?END/binary>>.

rgb_color([R, G, B]) when R >= 0, R =< 5, G >= 0, G =< 5, B >= 0, B =< 5 ->
  integer_to_list(16 + (R * 36) + (G * 6) + B).

true_color([R1, R2, G1, G2, B1, B2]) ->
  R = erlang:list_to_integer([R1, R2], 16),
  G = erlang:list_to_integer([G1, G2], 16),
  B = erlang:list_to_integer([B1, B2], 16),
  true_color([R, G, B]);

true_color([R, G, B]) when R >= 0, R =< 255, G >= 0, G =< 255, B >= 0, B =< 255 ->
  [integer_to_list(R), ?SEP, integer_to_list(G), ?SEP, integer_to_list(B)].
