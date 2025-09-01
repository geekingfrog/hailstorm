let SessionLoad = 1
let s:so_save = &g:so | let s:siso_save = &g:siso | setg so=0 siso=0 | setl so=-1 siso=-1
let v:this_session=expand("<sfile>:p")
silent only
silent tabonly
cd ~/extra_data/code/elixir/hailstorm
if expand('%') == '' && !&modified && line('$') <= 1 && getline(1) == ''
  let s:wipebuf = bufnr('%')
endif
let s:shortmess_save = &shortmess
if &shortmess =~ 'A'
  set shortmess=aoOA
else
  set shortmess=aoO
endif
badd +70 lib/hailstorm/scenario/supervisor.ex
badd +39 lib/hailstorm/scenario/reaper.ex
badd +59 config/dev.exs
badd +46 config/config.exs
badd +1 ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex
badd +1 lib/hailstorm/scenario.ex
badd +24 lib/hailstorm/application.ex
argglobal
%argdel
$argadd lib/hailstorm/scenario/supervisor.ex
set stal=2
tabnew +setlocal\ bufhidden=wipe
tabrewind
edit ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 25 + 27) / 55)
exe 'vert 1resize ' . ((&columns * 127 + 127) / 255)
exe '2resize ' . ((&lines * 26 + 27) / 55)
exe 'vert 2resize ' . ((&columns * 127 + 127) / 255)
exe 'vert 3resize ' . ((&columns * 127 + 127) / 255)
argglobal
balt lib/hailstorm/scenario.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 1 - ((0 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 1
normal! 034|
wincmd w
argglobal
if bufexists(fnamemodify("lib/hailstorm/scenario.ex", ":p")) | buffer lib/hailstorm/scenario.ex | else | edit lib/hailstorm/scenario.ex | endif
if &buftype ==# 'terminal'
  silent file lib/hailstorm/scenario.ex
endif
balt ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 15 - ((14 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 15
normal! 07|
wincmd w
argglobal
if bufexists(fnamemodify("lib/hailstorm/scenario/supervisor.ex", ":p")) | buffer lib/hailstorm/scenario/supervisor.ex | else | edit lib/hailstorm/scenario/supervisor.ex | endif
if &buftype ==# 'terminal'
  silent file lib/hailstorm/scenario/supervisor.ex
endif
balt lib/hailstorm/scenario/reaper.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 70 - ((31 * winheight(0) + 25) / 51)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 70
normal! 072|
wincmd w
3wincmd w
exe '1resize ' . ((&lines * 25 + 27) / 55)
exe 'vert 1resize ' . ((&columns * 127 + 127) / 255)
exe '2resize ' . ((&lines * 26 + 27) / 55)
exe 'vert 2resize ' . ((&columns * 127 + 127) / 255)
exe 'vert 3resize ' . ((&columns * 127 + 127) / 255)
tabnext
edit lib/hailstorm/scenario.ex
let s:save_splitbelow = &splitbelow
let s:save_splitright = &splitright
set splitbelow splitright
wincmd _ | wincmd |
vsplit
1wincmd h
wincmd _ | wincmd |
split
1wincmd k
wincmd w
wincmd w
wincmd _ | wincmd |
split
1wincmd k
wincmd w
let &splitbelow = s:save_splitbelow
let &splitright = s:save_splitright
wincmd t
let s:save_winminheight = &winminheight
let s:save_winminwidth = &winminwidth
set winminheight=0
set winheight=1
set winminwidth=0
set winwidth=1
exe '1resize ' . ((&lines * 25 + 27) / 55)
exe 'vert 1resize ' . ((&columns * 127 + 127) / 255)
exe '2resize ' . ((&lines * 26 + 27) / 55)
exe 'vert 2resize ' . ((&columns * 127 + 127) / 255)
exe '3resize ' . ((&lines * 22 + 27) / 55)
exe 'vert 3resize ' . ((&columns * 127 + 127) / 255)
exe '4resize ' . ((&lines * 29 + 27) / 55)
exe 'vert 4resize ' . ((&columns * 127 + 127) / 255)
argglobal
balt lib/hailstorm/application.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 17 - ((16 * winheight(0) + 12) / 24)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 17
normal! 09|
wincmd w
argglobal
if bufexists(fnamemodify("~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex", ":p")) | buffer ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex | else | edit ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex | endif
if &buftype ==# 'terminal'
  silent file ~/extra_data/code/elixir/hailstorm/lib/hailstorm/scenario/system.ex
endif
balt lib/hailstorm/application.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 12 - ((11 * winheight(0) + 12) / 25)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 12
normal! 070|
wincmd w
argglobal
if bufexists(fnamemodify("lib/hailstorm/scenario/reaper.ex", ":p")) | buffer lib/hailstorm/scenario/reaper.ex | else | edit lib/hailstorm/scenario/reaper.ex | endif
if &buftype ==# 'terminal'
  silent file lib/hailstorm/scenario/reaper.ex
endif
balt config/config.exs
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
1
sil! normal! zo
29
sil! normal! zo
let s:l = 39 - ((11 * winheight(0) + 10) / 21)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 39
normal! 028|
wincmd w
argglobal
if bufexists(fnamemodify("lib/hailstorm/scenario/supervisor.ex", ":p")) | buffer lib/hailstorm/scenario/supervisor.ex | else | edit lib/hailstorm/scenario/supervisor.ex | endif
if &buftype ==# 'terminal'
  silent file lib/hailstorm/scenario/supervisor.ex
endif
balt lib/hailstorm/scenario/reaper.ex
setlocal foldmethod=expr
setlocal foldexpr=nvim_treesitter#foldexpr()
setlocal foldmarker={{{,}}}
setlocal foldignore=#
setlocal foldlevel=999
setlocal foldminlines=1
setlocal foldnestmax=20
setlocal nofoldenable
let s:l = 55 - ((22 * winheight(0) + 14) / 28)
if s:l < 1 | let s:l = 1 | endif
keepjumps exe s:l
normal! zt
keepjumps 55
normal! 010|
wincmd w
exe '1resize ' . ((&lines * 25 + 27) / 55)
exe 'vert 1resize ' . ((&columns * 127 + 127) / 255)
exe '2resize ' . ((&lines * 26 + 27) / 55)
exe 'vert 2resize ' . ((&columns * 127 + 127) / 255)
exe '3resize ' . ((&lines * 22 + 27) / 55)
exe 'vert 3resize ' . ((&columns * 127 + 127) / 255)
exe '4resize ' . ((&lines * 29 + 27) / 55)
exe 'vert 4resize ' . ((&columns * 127 + 127) / 255)
tabnext 1
set stal=1
if exists('s:wipebuf') && len(win_findbuf(s:wipebuf)) == 0 && getbufvar(s:wipebuf, '&buftype') isnot# 'terminal'
  silent exe 'bwipe ' . s:wipebuf
endif
unlet! s:wipebuf
set winheight=1 winwidth=20
let &shortmess = s:shortmess_save
let &winminheight = s:save_winminheight
let &winminwidth = s:save_winminwidth
let s:sx = expand("<sfile>:p:r")."x.vim"
if filereadable(s:sx)
  exe "source " . fnameescape(s:sx)
endif
let &g:so = s:so_save | let &g:siso = s:siso_save
set hlsearch
nohlsearch
doautoall SessionLoadPost
unlet SessionLoad
" vim: set ft=vim :
