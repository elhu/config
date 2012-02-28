" Use Vim settings, rather then Vi settings (much better!).
" This must be first, because it changes other options as a side effect.
if &compatible
    set nocompatible
end

set encoding=utf-8

let mapleader=","
let g:mapleader=","

" Reformatting a paragraph.
map Q gq

" Insert < => > with Ctrl+l.
imap <c-l> <space>=><space>

" Use <,,> when in normal mode to write the current buffer.
nnoremap <leader><leader> <c-^>

" %% will be the folder of the currently opened buffer.
cnoremap %% <C-R>=expand('%:h').'/'<cr>

map <leader>e :edit %%
map <leader>gf :CommandT %%<cr>

" Rails shortcuts. {{{
map <leader>gv :CommandT app/views<cr>
map <leader>gc :CommandT app/controllers<cr>
map <leader>gm :CommandT app/models<cr>
map <leader>gh :CommandT app/helpers<cr>
map <leader>gl :CommandT lib<cr>
map <leader>gp :CommandT public<cr>
map <leader>gs :CommandT public/stylesheets<cr>
map <leader>gj :CommandT public/javascripts<cr>

function! ShowRoutes()
  " Requires 'scratch' plugin
  :topleft 100 :split __Routes__
  " Make sure Vim doesn't write __Routes__ as a file
  :set buftype=nofile
  " Delete everything
  :normal 1GdG
  " Put routes output in buffer
  :0r! rake -s routes
  " Size window to number of lines (1 plus rake output length)
  :exec ":normal " . line("$") . _ "
  " Move cursor to bottom
  :normal 1GG
  " Delete empty trailing line
  :normal dd
endfunction
map <leader>gR :call ShowRoutes()<cr>
" }}}

" filter non-printable characters from the paste buffer
" useful when pasting from some gui application
nmap <leader>p :let @* = substitute(@*,'[^[:print:]]','','g')<cr>"*p

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

" Hold down the shift key to scroll left and right through the tabs with 'h' and 'l'.
map <S-h> gT
map <S-l> gt

nmap ,w :x<CR>
nmap ,q :q!<CR>

" sudo write and quit
cmap x!! w !sudo tee %<CR><CR>:q!<CR>

" set colorcolumn "- find more subtle color

" :.! - execute system command and add output on the current line
" Auto reloads the current buffer..especially useful while viewing log files and it almost serves the functionality of tail program in unix from within vim.
" :setlocal autoread
" set autoread " Read files when they've been changed outside of Vim.
" == correct indentation of current line; gg=G corrects indentation for entire file
" =a{ correct indentation of current block (also =% if u'r on the {)

" In order to copy a text from Vim to your clipboard for other application to
" use, select the text you want to copy in visual mode, and then press "+y. This
" way, you can easily paste your text to other applications.

" --- Maybe I can use this to run tests in background
" When working on a project where the build process is slow I always build in the background
" and pipe the output to a file called errors.err (something like make debug 2>&1 | tee errors.err).
" This makes it possible for me to continue editing or reviewing the source code during the build process.
" When it is ready (using pynotify on GTK to inform me that it is complete) I can look at the result in vim
" using quickfix. Start by issuing :cf[ile] which reads the error file and jumps to the first error.
" I personally like to use cwindow to get the build result in a separate window.

" USE gi - goes back to last insert
" '. - goes to the last modification
" CTRL+E & Y (ins mod) - inserts chars from above and below line
" CTRL+T & D - indent and dedent in ins mod
" :!sort, :!grep, :!
" http://www.vim.org/scripts/script.php?script_id=90
" http://choorucode.wordpress.com/2010/11/28/vim-ruler-and-default-ruler-format/
" rails.vim
" gist.vim
" space.vim
" https://github.com/tpope/vim-fugitive
" example use of pathogen
" http://vimcasts.org/
" ; to repeat fX or FX
" sessions
" "*p will paste from the different register
" :r!cat
" :map <C-F> /\V
" :help text-objects 
" http://www.vimgolf.com/
" Diff opt
" set diffopt=vertical
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
"set statusline+=\ %t\ \|\ len:\ \%L\ \|\ type:\ %Y\ \|\ ascii:\ \%03.3b\ \|\ hex:\ %2.2B\ \|\ line:\ \%2l
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set scrolloff=5                  " keep 4 lines below cursor when scrolling
set showcmd                      " display incomplete commands
set title                        " show title in console title bar
set mousehide                    " hide the mouse pointer while typing
set lazyredraw
set ttyfast                      " smoother changes
set wildignore=.svn,CVS,.git,*.o,*.a,*.class,*.mo,*.la,*.so,*.obj,*.swp,*.jpg,*.png,*.xpm,*.gif,node_modules/**  " Ignore these files when completing names and in Explorer
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
set nosmartindent                " smartindent automatically inserts one extra level of indentation in some cases, and works for C-like files
set nocindent                    " is more customizable, but also more strict when it comes to syntax
set autoindent                   " copy the indentation from the previous line, when starting a new line
set cpo+=I                       " when moving the cursor up or down just after inserting indent for 'autoindent', do not delete the indent
set expandtab                    " tabs are converted to spaces, use only when required
set softtabstop=4                " this makes the backspace key treat the four spaces like a tab (so one backspace goes back a full 4 spaces)
set tabstop=4                    " numbers of spaces of tab character
set shiftwidth=4                 " numbers of spaces to (auto)indent
" }}}

" Specky
let g:speckyBannerKey        = "gcb"
let g:speckyQuoteSwitcherKey = "gc'"
let g:speckyRunRdocKey       = "gcr"
let g:speckySpecSwitcherKey  = "gcx"
let g:speckyRunSpecKey       = "gcs"
let g:speckyRunRdocCmd       = "fri -L -f plain"
let g:speckyWindowType       = 2
let g:speckyRunSpecCmd       = 'bin/rspec --format nested'

"set autochdir                    " current directory is always matching the content of the active window - useful without command-t plugin
"set list                         " Shows TABs, EOLs
"set lcs+=tab:>-,eol:·            " Which characters to show for tabs and eols

" http://vimcolorschemetest.googlecode.com/svn/colors/anotherdark.vim
" http://vimcolorschemetest.googlecode.com/svn/colors/inkpot.vim
" colorscheme evening
" colorscheme inkpot

syntax on

" Enable file type detection.
" Use the default filetype settings, so that mail gets 'tw' set to 72,
" 'cindent' is on in C files, etc.
" Also load indent files, to automatically do language-dependent indenting.
filetype plugin indent on

" Put these in an autocmd group, so that we can delete them easily.
augroup vimrcEx
	au!
	
	" For all text files set 'textwidth' to 78 characters.
	autocmd FileType text setlocal textwidth=78
    autocmd FileType ruby setlocal expandtab shiftwidth=2 tabstop=2 softtabstop=2
    "autocmd FileType html setlocal shiftwidth=2 tabstop=2 OR put any settings in ~/.vim/after/ftplugin
	
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
