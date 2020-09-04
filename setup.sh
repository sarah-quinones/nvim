#!/bin/sh
[ -z $LOCAL_HOME ] && LOCAL_HOME="$HOME"
VENV_DIR="$LOCAL_HOME/.local/share/nvim"

[ -d "$VENV_DIR/venv" ] || python3 -m venv --prompt='neovim' "$VENV_DIR/venv"
$VENV_DIR/venv/bin/pip install -U wheel
$VENV_DIR/venv/bin/pip install -U \
  scikit-build\
  pyyaml\
  appdirs\
  astroid\
  attrs\
  autopep8\
  black\
  Click\
  entrypoints\
  flake8\
  greenlet\
  isort\
  lazy-object-proxy\
  mccabe\
  msgpack\
  neovim\
  pycodestyle\
  pyflakes\
  pylint\
  pynvim\
  six\
  toml\
  typed-ast\
  Unidecode\
  wrapt==1.11\
  rope\
  jedi\
  cmake-format\
  pyyaml\
