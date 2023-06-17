" Get the defaults that most users want.
source $VIMRUNTIME/defaults.vim
if has("vms")
  set nobackup		" do not keep a backup file, use versions instead
else
  set backup		" keep a backup file (restore to previous version)
  if has('persistent_undo')
    set undofile	" keep an undo file (undo changes after closing)
  endif
endif

if &t_Co > 2 || has("gui_running")
  " Switch on highlighting the last used search pattern.
  set hlsearch
endif

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
  au!

  " For all text files set 'textwidth' to 78 characters.
  " autocmd FileType text setlocal textwidth=78
augroup END

" Personal changes ========================================================
" Bindings 

	" Fix stupid Y command default to follow logic of others (D, C, ...)
noremap Y y$	

	" Leader key mapping
let g:mapleader = "!"
let g:maplocalleader = "!"
noremap <Leader><Leader> :w <CR>

	" remaps movements to be graphicwise rather than linewise
" noremap j gj
" noremap k gk

"Makes it easy to deal with search highlighting : I decide when I want it with
"esc esc but searching automatically activates it.
"TODO: Have it so that when abandonning a search deactivates it.
nnoremap <Esc><Esc> :set hlsearch!<CR>
nnoremap / :set hlsearch<CR>/
nnoremap ? :set hlsearch<CR>?

	" Bindings for easier use of tpope's fugitive plugin
" kills default mapping I don't want to mess up my cursor if
" 	I'm too slow.
noremap G <Nop>
" abbreviations to save time
	" Opens a commit window and resize it
noremap Gc :botright Git commit <CR>
noremap Gw :Gwrite <CR>
map Gf GwGc 
noremap Gp :Git push <CR>
" this is the old behavior of G solo remapped to GG
noremap GG 100%
" Latex Bindings
if has("autocmd")
	autocmd FileType tex set makeprg=latexmk
	autocmd FileType tex inoremap <buffer> ùù \
	autocmd FileType tex imap <buffer> ù' {
	autocmd FileType tex imap <buffer> ùr {
	autocmd FileType tex imap <buffer> <' {
	autocmd FileType tex inoremap <buffer> ù= }
	autocmd FileType tex inoremap <buffer> ùt }
	autocmd FileType tex inoremap <buffer> <= }
	autocmd FileType tex imap <buffer> ù( [
	autocmd FileType tex imap <buffer> <( [
	autocmd FileType tex inoremap <buffer> ù) ]
	autocmd FileType tex inoremap <buffer> ù- ]
	autocmd FileType tex inoremap <buffer> <) ]
	autocmd FileType tex setlocal spell spelllang=en_us
endif
function FugitiveStatusWrapper() 
   	
endfunction

" Closing of brackets and stuff
" inoremap ' ''<Left>
" inoremap " ""<Left>
" inoremap ( ()<Left>
" inoremap { {}<Left>
" inoremap [ []<Left>

" General Options
set encoding=utf-8
set number			" Show line numbers 
set relativenumber	" together with number shows true number on active line
set hlsearch		" Activates the hilighting in searches
set path+=**		" Searches a file throught sub-directories
set showcmd			" Show the command in normal mode
set smartindent		" Indentation auto
set wildmenu		" Affiche une liste d'autocompletion
set linebreak		" Ne wrap pas au milieu d'un mot
set autowrite		" Automatically writes a buffer if opening something else
set ignorecase 		" Ignores case on a search pattern unless
set smartcase		" Upper case is used
set cursorline 		" Highlights current cursor line
" Sets the folders for the backup files (*~) as being in .vim
set backupdir=~/.vim/temp//,.
set directory=~/.vim/temp//,.
set foldmethod=marker

	"Windows
set noequalalways	" windows are not automatically resized
set splitright 		" when splitting the newly opened window goes on the right

	" Tab preferences
set shiftwidth=4	" defini la taille du shift auto (e.g << ou >>)
set tabstop=4		" defini la taille du caractere <Tab> à l'ecran

	" StatusLine

hi User1 ctermbg=grey ctermfg=black guibg=grey guifg=black

set laststatus=2	" montre statusline si plus d'une fenêtre, 2 si tout le temps
set stl= 					" mise à zero
set stl+=%([%{winnr()}]%)	" window nbr 
set stl+=\ %<%f				" emplacement relatif du fichier
set stl+=\ %h%r%m			" si le buffer est aide,ReadOnly ou modifie
set stl+=\ %{FugitiveStatusline()} " Git current branch with fugitive
set stl+=%=%14.(%l,%c%V%)	" ligne,col-colVisuelle 
set stl+=\ %y				" type de ficher
set stl+=\ %P				" pourcentage dans le fichier

" File tree : Netwr configs
let g:netrw_banner = 0		" Hides the directory banner. Show it with `I`
let g:netrw_liststyle = 3	" makes the tree listing style the default
let g:netrw_list_hide ='^\..*' " Hides dotfiles by default
let g:netrw_list_hide .=',^__.*' " Hides files starting with __ by default (usually python stuff)

" C++ specific definitions
if has("autocmd")
	filetype on
	autocmd FileType cpp setlocal foldmethod=indent
endif

" jump from file to file easily with jump file
" function! JumpToNextBufferInJumplist(dir) " 1=forward, -1=backward
"     let jl = getjumplist() | let jumplist = jl[0] | let curjump = jl[1]
"     let jumpcmdstr = a:dir > 0 ? '<C-O>' : '<C-I>'
"     let jumpcmdchr = a:dir > 0 ? '^O' : '^I'    " <C-I> or <C-O>
"     let searchrange = a:dir > 0 ? range(curjump+1,len(jumplist))
"                               \ : range(curjump-1,0,-1)
"     for i in searchrange
"         if jumplist[i]["bufnr"] != bufnr('%')
"             let n = (i - curjump) * a:dir
"             echo "Executing ".jumpcmdstr." ".n." times."
"             execute "silent normal! ".n.jumpcmdchr
"             break
"         endif
"     endfor
" endfunction
" nnoremap <leader><C-O> :call JumpToNextBufferInJumplist(-1)<CR>
" nnoremap <leader><C-I> :call JumpToNextBufferInJumplist( 1)<CR>
" Add optional packages.


" The matchit plugin makes the % command work better, but it is not backwards
" compatible.
" The ! means the package won't be loaded right away but when plugins are
" loaded during initialization.
if has('syntax') && has('eval')
  packadd! matchit
endif

if (has("termguicolors"))
	set termguicolors
endif

" **Vim-Plug** plugin manager
" Add any vim plugin github repo here.
" Then source and run `PlugInstall`.
call plug#begin('~/.vim/plugged')

Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'cdelledonne/vim-cmake'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'lervag/vimtex'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
Plug 'goerz/jupytext.vim'
Plug 'puremourning/vimspector'
Plug 'tpope/vim-abolish'

call plug#end()
"********************************************************************
" plugin config
"********************************************************************

let g:ycm_autoclose_preview_window_after_insertion = 1

""""""""""""""""""""""""""""""""""""""""""""""
" Gruvbox config
""""""""""""""""""""""""""""""""""""""""""""""

" tells vim not to use background color erase, for kitty
let &t_ut='' 
let g:gruvbox_contrast_dark = 1
let g:gruvbox_transparent_bg = 1
let g:gruvbox_italic = 1
colorscheme gruvbox
set background=dark

"""""""""""""""""""""""""""""""""""""""""""""
" vimtex
"""""""""""""""""""""""""""""""""""""""""""""
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_latexmk = {'build_dir': {-> expand("%:t:r")}}

	" vimtex config to work with YouCompleteMe
if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

"""""""""""""""""""""""""""""""""""""""""""""
" ultisnip config
"""""""""""""""""""""""""""""""""""""""""""""
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"
let g:ultisnips_python_style="numpy"
