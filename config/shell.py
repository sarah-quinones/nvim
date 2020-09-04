from os import environ
from pathlib import Path
from sys import argv

import neovim


def abs_path(path: Path) -> str:
    return path.absolute().as_posix()


def main(cmd, args):
    nvim = neovim.attach("socket", path=environ["NVIM_LISTEN_ADDRESS"])
    if cmd == "lcd":
        nvim.command("lcd " + abs_path(Path(".")))
    if cmd == "tcd":
        nvim.command("tcd " + abs_path(Path(".")))
    if cmd == "edit" and args != []:
        nvim.command("edit " + abs_path(Path(args[0])))
        for arg in args[1:]:
            nvim.command("badd " + abs_path(Path(arg)))
    if cmd == "reset":
        nvim.command("terminal")
        nvim.command("startinsert")
    if cmd == "command-with-n-args":
        n_args = int(args[0])
        nvim.command(" ".join(args[1:1+n_args]))
    if cmd == "command-with-all-args":
        nvim.command(" ".join(args))


main(argv[1], argv[2:])
