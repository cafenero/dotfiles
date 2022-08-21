syntax on
set t_Co=256
noremap <ESC><ESC> :noh<cr>
"colorscheme default
highlight DiffAdd    cterm=bold ctermfg=10 ctermbg=22
highlight DiffDelete cterm=bold ctermfg=10 ctermbg=52
highlight DiffChange cterm=bold ctermfg=10 ctermbg=17
highlight DiffText   cterm=bold ctermfg=10 ctermbg=21

"nmap <F3> :noh<CR>
"nmap <F4> :noh<CR>
nmap <F3> :<Esc>
nmap <F4> :<Esc>
inoremap <F3> <Esc>
inoremap <F4> <Esc>
