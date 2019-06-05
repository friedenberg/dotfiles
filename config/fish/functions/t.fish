# Defined in - @ line 1
function t --description 'alias t=tmux -L sessions'
	env TAB_WD=i_was_here tmux -L sessions $argv;
end
