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
let g:mapleader = "²"
noremap <Leader><Leader> :w <CR>
noremap <Leader>p "+p

	" remaps movements to be graphicwise rather than linewise
" noremap j gj
" noremap k gk

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
	autocmd FileType tex inoremap <buffer> ùù \
	autocmd FileType tex imap <buffer> ù' {
	autocmd FileType tex imap <buffer> <' {
	autocmd FileType tex inoremap <buffer> ù= }
	autocmd FileType tex inoremap <buffer> <= }
	autocmd FileType tex imap <buffer> ù( [
	autocmd FileType tex imap <buffer> <( [
	autocmd FileType tex inoremap <buffer> ù) ]
	autocmd FileType tex inoremap <buffer> <) ]
endif
function FugitiveStatusWrapper() 
   	
endfunction

" Closing of brackets and stuff
inoremap '' ''<Esc>i
inoremap " ""<Esc>i
inoremap ( ()<Esc>i
inoremap { {}<Esc>i
inoremap [ []<Esc>i

" General Options
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
set cursorline 		" Highlights current cursor line
set backupdir=~/.vim/temp//,.
set directory=~/.vim/temp//,.

	"Windows
set noequalalways	" windows are not automatically resized
set splitright 		" when splitting the newly opened window goes on the right

	" Tab preferences
set shiftwidth=4	" defini la taille du shift auto (e.g << ou >>)
set tabstop=4		" defini la taille du caractere <Tab> à l'ecran

	" general fold preference
set foldmethod=marker
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

" Completer engine
Plug 'ycm-core/YouCompleteMe'
" Good looking theme
Plug 'morhetz/gruvbox'

"Plug 'cdelledonne/vim-cmake'
" Git wrapper for vim
Plug 'tpope/vim-fugitive'
" Easy surround
Plug 'tpope/vim-surround'
" Easy way to toggle comments
Plug 'tpope/vim-commentary'
" Allows editing python notebook
Plug 'goerz/jupytext.vim'
" Makes TeX nicer to write in vim
Plug 'lervag/vimtex'
" Automatic ctag management
Plug 'ludovicchabant/vim-gutentags'
" Snippet engine and snippets
Plug 'sirver/ultisnips'
Plug 'honza/vim-snippets'
" Debugger
Plug 'puremourning/vimspector'
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

" vimtex config to work with YouCompleteMe

if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
au VimEnter * let g:ycm_semantic_triggers.tex=g:vimtex#re#youcompleteme

" ultisnip config
let g:UltiSnipsEditSplit="context"
let g:UltiSnipsExpandTrigger="<Enter>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<S-NL>"
let g:ultisnips_python_style= 'google'

" Use the numbered registers for text smaller than one line
" if exists("##TextYankPost")
"   function! SmallDeleteRing(event) abort
"     if a:event['operator'] == 'y'
"       " Don't care about actual yanks
"       return
"     endif
"     if a:event['regtype'] ==# 'V'
"       " Vim already handles linewise deletions
"       return
"     endif
    
"     let regcontents = a:event['regcontents']
"     if len(regcontents) > 1
"       " Vim already handles deletions spanning multiple lines
"       return
"     endif

"     let deleted = regcontents[0]

"     if len(deleted) == 1
"       " Don't want to catch single-character deletions (in particular, x)
"       return
"     endif

"     " Grab registers 1-8
"     let one_through_eight = mapnew(range(1, 8), {k, v -> getreg(v)})

"     " Set register "1
"     call setreg(1, deleted)

"     " Set registers 2-9
"     for i in range(1, 8)
"       call setreg(i + 1, one_through_eight[i - 1])
"     endfor
"   endfunction

"   augroup small_delete_ring
"     autocmd!
"     autocmd TextYankPost * call SmallDeleteRing(v:event)
"   augroup END
" endif
