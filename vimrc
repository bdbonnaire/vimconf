" An example for a vimrc file.
"
" Maintainer:	Bram Moolenaar <Bram@vim.org>
" Last change:	2019 Jan 26
"
" To use it, copy it to
"     for Unix and OS/2:  ~/.vimrc
"	      for Amiga:  s:.vimrc
"  for MS-DOS and Win32:  $VIM\_vimrc
"	    for OpenVMS:  sys$login:.vimrc

" When started as "evim", evim.vim will already have done these settings, bail
" out.
if v:progname =~? "evim"
  finish
endif

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

	" General
set encoding=utf-8
set number			"show line numbers 
set hlsearch		" activates the hilighting in searches
set path+=**		" searches a file throught sub-directories
set showcmd			" show the command in normal mode
set smartindent		" indentation auto
set wildmenu		" affiche une liste d'autocompletion
set linebreak		" ne wrap pas au milieu d'un mot
set autowrite		" automatically writes a buffer if opening something else
set ignorecase 		" ignores case on a search pattern unless
set smartcase		" Upper case is used

	"Windows
set noequalalways	" windows are not automatically resized
set splitright 		" when splitting the newly opened window goes on the right

	" Questionable
set cursorline 		" Highlights current cursor line

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

" Bindings 

	" remaps movements to be graphicwise rather than linewise
noremap j gj
noremap k gk

" Add optional packages.
"
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

Plug 'mattn/emmet-vim' 
Plug 'vim-scripts/c.vim'
Plug 'ycm-core/YouCompleteMe'
Plug 'morhetz/gruvbox'
Plug 'cdelledonne/vim-cmake'
Plug 'tpope/vim-fugitive'

call plug#end()

" plugin config

let g:ycm_autoclose_preview_window_after_insertion = 1

" Gruvbox config
" tells vim not to use background color erase, for kitty
let &t_ut='' 
let g:gruvbox_contrast_dark = 1
let g:gruvbox_transparent_bg = 1
let g:gruvbox_italic = 1
colorscheme gruvbox
set background=dark

