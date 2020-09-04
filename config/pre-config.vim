if $ZDOTDIR == '' || $LOCAL_HOME == ''
  let $ZDOTDIR = $HOME . '/.local/share/zsh'
  let $LOCAL_HOME = system("zsh -c 'source $ZDOTDIR/.zshrc && printf $LOCAL_HOME'")
  cd $LOCAL_HOME
endif

let $FZF_DEFAULT_COMMAND = system
      \ ("zsh -c 'source $ZDOTDIR/.zshrc && printf $FZF_DEFAULT_COMMAND'")
let $FZF_CTRL_T_COMMAND = system
      \ ("zsh -c 'source $ZDOTDIR/.zshrc && printf $FZF_CTRL_T_COMMAND'")
