Video configuration run from the terminal program:

https://www.youtube.com/watch?v=0W0cf8ENmME

the same configuration from the Serial  Monitor Arduino IDE

https://vk.com/club171670176?z=video-171670176_456239018%2Fvideos-171670176%2Fpl_-171670176_-2

List of AT commands:

AT
AT+H - Help
AT+L30..240 - Set Led Number

AT+SS - Save settings config
AT+SP - Save play list config
AT+SC - Save program color config
AT+PP - Printing Playlist programs
AT+PC - Printing color used in the subprogram 0..7
	
AT+D0..127 - Delete the program to play in a loop
AT+DA - Delete all the program to play in a loop
AT+A0..20,0..7,0..240 - Add the program to play in a loop
AT+I0..127,0..29,0..7,0..240 - Insert the program to play in a loop
AT+B0..256 - Set the brightness for dynamic programs
AT+M0..256 - Set the brightness for musical programs
AT+T10..240 - Set tempo
AT+C0[1] - 0 - disable CLAP, 1 - enable CLAP
AT+F0..32 - Flow
AT+W0..7,0..5,0..112 - Write subprogram,color number,new color

