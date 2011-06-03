" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
set nocompatible

let mapleader = ","
let g:mapleader = ","

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Hold down the shift key to scroll left and right through the tabs with 'h' and 'l'.
map <S-h> gT
map <S-l> gt

" So that 'a will jump to the line *and* column.
nnoremap ' `
nnoremap ` '

" Speeding up viewport scrolling.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Press Ctrl+h to toggle highlighting on/off.
noremap <C-h> :set hls!<CR>

noremap <Leader>t :CommandT<CR>
noremap <F5> :CommandTFlush<CR>

" Fixes the following *feature*:
"     If you do not type anything on the new line except <BS> or CTRL-D and then
"     type <Esc> or <CR>, the indent is deleted again
inoremap <Enter> <Enter><space><bs>
nnoremap o o<space><bs>
nnoremap O O<space><bs> 

function! Spaces2()
    set expandtab
    set softtabstop=2
    set tabstop=2
    set shiftwidth=2
endfunction

function! Spaces4()
    set expandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
endfunction

function! Tabs4()
    set noexpandtab
    set softtabstop=4
    set tabstop=4
    set shiftwidth=4
endfunction

" Allow to easily change indentation styles.
noremap <F2> :<C-U>call Spaces2()<CR>
noremap <F3> :<C-U>call Spaces4()<CR>
noremap <F4> :<C-U>call Tabs4()<CR>

" Edit {{{
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set nowrap                       " don't wrap lines longer than the screen
set nostartofline                " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]    " move freely between files
set pastetoggle=<F8>             " pasting from outside vim. It turns off auto stuff. You can tell you are in paste mode when the ruler is not visible
set showtabline=2                " Always show tabline
set fdm=marker
" }}}

" Command {{{
set wildmenu                     " see all options when auto completing with <TAB>
set wildmode=list:longest        " to have the completion complete only up to the point of ambiguity
set history=100                  " keep 100 lines of command line history
" }}}

" Visual {{{
set nosm                         " don't change to matching braces
set visualbell                   " instead of emitting an obnoxious noise, the window will flash very briefly
set ruler                        " show the cursor position all the time
set number                       " show line numbers
set ls=2                         " always show status line
set scrolloff=5                  " keep 4 lines below cursor when scrolling
set showcmd                      " display incomplete commands
set title                        " show title in console title bar
set mousehide                    " hide the mouse pointer while typing
set lazyredraw
set ttyfast                      " smoother changes
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif  " Ignore these files when completing names and in Explorer
" }}}

" Search {{{
set incsearch                    " do incremental searching
set nohlsearch                   " highlight searches
" }}}

" Searching {{{
set incsearch                    " do incremental searching
set ignorecase                   " These two options, when set together, will make /-style searches case-sensitive only if there is a capital letter
set smartcase                    " in the search expression. *-style searches continue to be consistently case-sensitive
" }}}

" Backup {{{
set backupdir=~/.backup          " save all backups in one directory
set directory=~/.backup          " put swaps files here too
set nobackup                     " don't make a name~ backup file after saving file
set updatecount=50               " write swap files to disk after 50 keystrokes
set sessionoptions+=resize,blank " remember empty files and window sizes between sessions
" }}}

" Indent {{{
set autoindent                   " always set autoindenting on
set cpo+=I                       " when moving the cursor up or down just after inserting indent for 'autoindent', do not delete the indent
set expandtab                    " tabs are converted to spaces, use only when required
set softtabstop=4                " this makes the backspace key treat the four spaces like a tab (so one backspace goes back a full 4 spaces)
set tabstop=4                    " numbers of spaces of tab character
set shiftwidth=4                 " numbers of spaces to (auto)indent
" }}}

"set autochdir                    " current directory is always matching the content of the active window - useful without command-t plugin
"set list                         " Shows TABs, EOLs
"set lcs+=tab:>-,eol:·            " Which characters to show for tabs and eols

" http://vimcolorschemetest.googlecode.com/svn/colors/anotherdark.vim
" http://vimcolorschemetest.googlecode.com/svn/colors/inkpot.vim
colorscheme anotherdark

syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
" filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	au!
	
	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
	
	" When editing a file, always jump to the last known cursor position.
	" Don't do it when the position is invalid or when inside an event handler
	" (happens when dropping a file on gvim).
	autocmd BufReadPost *
		\ if line("'\"") > 0 && line("'\"") <= line("$") |
		\   exe "normal g`\"" |
		\ endif
augroup END

" TODO {{{

" Creates a new empty function (this keeps you in insert mode and typing!).
" map! ,f function() {<CR>}<ESC>k$a<CR>

" }}}
