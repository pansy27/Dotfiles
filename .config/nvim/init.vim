" Settings
set mouse=a
syntax on
"set relativenumber
"set number
set clipboard=unnamedplus
set encoding=utf-8
set backspace=2
set ignorecase
set smartcase
set nocompatible

" Cursor Location
augroup jump
	autocmd BufReadPost *
		\  if line("'\"") > 1 && line("'\"") <= line("$") && &ft !~# 'commit'
			\| exe 'normal! g`"'
		\| endif
augroup end

" Colorscheme Options
 "let g:enable_italic_font = 1
 "let g:enable_bold_font = 1
 "let g:hybrid_transparent_background = 0
" let g:gruvbox_material_background = 'soft'
 let g:gruvbox_material_enable_italic = 1
 let g:gruvbox_material_disable_italic_comment = 0
 let g:gruvbox_material_enable_bold = 1
 let g:gruvbox_material_transparent_background = 1

" Plugins 

call plug#begin(stdpath('data') . '/plugged')

Plug 'itchyny/lightline.vim'
Plug 'mengelbrecht/lightline-bufferline'
Plug 'https://github.com/sainnhe/gruvbox-material'
Plug 'https://github.com/ap/vim-css-color'
Plug 'https://github.com/elkowar/yuck.vim'
Plug 'sheerun/vim-polyglot'
Plug 'mhinz/vim-startify'
call plug#end()

let s:header = [
      \ '',
           \ ]
function! s:center(lines) abort
  let longest_line   = max(map(copy(a:lines), 'strwidth(v:val)'))
  let centered_lines = map(copy(a:lines),
        \ 'repeat(" ", (&columns / 2) - (longest_line / 2)) . v:val')
  return centered_lines
endfunction

let g:startify_custom_header = s:center(s:header)

" Colorscheme
set background=dark
colorscheme gruvbox-material
" True Color Support
if (has("termguicolors"))
  set termguicolors
endif

" Lightline Config
let g:lightline = {
\ 'colorscheme': 'gruvbox_material',
\ 'separator': {}, 
\ 'subseparator': {}, 
\ 'tabline': {
      \   'left': [ ['buffers'] ],
      \   'right': [ ['close'] ]
      \ },
\ 'component_expand': {
      \   'buffers': 'lightline#bufferline#buffers'
      \ },
\ 'component_type': {
      \   'buffers': 'tabsel'
\ }
\ }

" Always Show Bufferline
set showtabline=2

" Buffer Cycle
nnoremap <C-n> :bnext<CR> 
" Buffer Close
nnoremap <A-w> :bd 
" Clear Highlight
nnoremap <esc> :noh<return><esc>
" \ 'separator': { 
"	\'left': '', 'right': '' },
"	\'left': '', 'right': '' },
"	\'left': '', 'right': '' },


