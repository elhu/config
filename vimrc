" Use Vim settings, rather then Vi settings.
" This must be first, because it changes other options as a side effect.
if &compatible
    set nocompatible
end

" Functions {{{

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

" }}}

" Editor Properties {{{

set encoding=utf-8

syntax on

set nomodeline " Disable reading vim configuration from files
set history=100 " keep 100 lines of command line history

"set autochdir                    " current directory is always matching the content of the active window - useful without command-t plugin
"set list                         " Shows TABs, EOLs
"set lcs+=tab:>-,eol:·            " Which characters to show for tabs and eols
"set colorcolumn=120 " find more subtle color
" Auto reloads the current buffer..especially useful while viewing log files and it almost serves the functionality of tail program in unix from within vim.
" :setlocal autoread
" Read files when they've been changed outside of Vim.
" set autoread 

" # Command line
set wildmenu " see all options when auto completing with <TAB>
set wildmode=list:longest " to have the completion complete only up to the point of ambiguity
set wildmode=longest:full,full
" Ignore these files when completing names, in Explorer and in Command-T
set wildignore+=*~
set wildignore+=.hg,.git,.svn                        " Version control
set wildignore+=*.aux,*.out,*.toc                    " LaTeX intermediate files
set wildignore+=*.jpg,*.bmp,*.gif,*.png,*.jpeg,*.xpm " binary images
set wildignore+=*.o,*.obj,*.exe,*.dll,*.manifest     " compiled object files
set wildignore+=*.class,*.a,*.mo,*.pyc               " mode compiled object files
set wildignore+=*.spl                                " compiled spelling word lists
set wildignore+=*.sw?                                " Vim swap files
set wildignore+=*.DS_Store                           " OSX bullshit
set wildignore+=*.luac                               " Lua byte code
set wildignore+=node_modules/**                      " locally installed NodeJS modules

set gdefault " When on, the ":substitute" flag 'g' is default on.
set nosm " don't change to matching braces
set visualbell " instead of emitting an obnoxious noise, the window will flash very briefly
set number " show line numbers
set showtabline=2 " Always show tabline
set fdm=marker
set scrolloff=5 " keep 5 lines below cursor when scrolling
set sidescrolloff=5 " keep 5 columns when scrolling horizontaly
set showcmd " display incomplete commands
set title " show title in console title bar
set mousehide " hide the mouse pointer while typing
set lazyredraw " Speed up macros
set ttyfast " smoother changes
set laststatus=2 " always show status line
set smarttab " sw at the start of the line, sts everywhere else
set statusline=
set statusline+=%2*%-3.3n%0*\                " buffer number
set statusline+=%f\                          " file name
set statusline+=%h%1*%m%r%w%0*               " flags
set statusline+=\[%{strlen(&ft)?&ft:'none'}, " filetype
set statusline+=%{&encoding},                " encoding
set statusline+=%{&fileformat}]              " file format
set statusline+=%=                           " right align
set statusline+=%2*0x%-8B\                   " current char
set statusline+=%-14.(%l,%c%V%)\ %<%P        " offset
"set statusline+=\ %t\ \|\ len:\ \%L\ \|\ type:\ %Y\ \|\ ascii:\ \%03.3b\ \|\ hex:\ %2.2B\ \|\ line:\ \%2l
"set statusline=%<%f\ (%{&ft})\ %-4(%m%)%=%-19(%3l,%02c%03V%)
set noruler " it won't be shown anyway because of the statusline
set nosmartindent " smartindent automatically inserts one extra level of indentation in some cases, and works for C-like files
set nocindent " is more customizable, but also more strict when it comes to syntax
set autoindent " copy the indentation from the previous line, when starting a new line
set cpo+=I " when moving the cursor up or down just after inserting indent for 'autoindent', do not delete the indent
set backspace=indent,eol,start   " allow backspacing over everything in insert mode
set nowrap                       " don't wrap lines longer than the screen
set nostartofline                " don't jump to first character when paging
set whichwrap=b,s,h,l,<,>,[,]    " move freely between files

set timeoutlen=1200         " A little bit more time for macros
set ttimeoutlen=50          " Make Esc work faster

" # Search
set incsearch                    " do incremental searching
set nohlsearch                   " highlight searches
set ignorecase                   " These two options, when set together, will make /-style searches case-sensitive only if there is a capital letter
set smartcase                    " in the search expression. *-style searches continue to be consistently case-sensitive

" # Backup
set backupdir=~/.backup          " save all backups in one directory
set directory=~/.backup          " put swaps files here too
set nobackup                     " don't make a name~ backup file after saving file
set updatecount=50               " write swap files to disk after 50 keystrokes
set sessionoptions+=resize,blank " remember empty files and window sizes between sessions

" }}}

" Mappings {{{

let mapleader=","
let g:mapleader=","

" Reformatting a paragraph.
map Q gq

" So that 'a will jump to the line *and* column.
nnoremap ' `
nnoremap ` '

" Fast write, write and quit and quit without save.
nmap ,x :x<CR>
nmap ,w :w<CR>
nmap ,q :q!<CR>

" Use <,,> when in normal mode to write the current buffer.
nnoremap <leader><leader> <c-^>

" %% will be the folder of the currently opened buffer.
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%

" sudo write and quit
cmap x!! w !sudo tee %<CR><CR>:q!<CR>

" Command-T
noremap <Leader>t :CommandT<CR>
noremap <F5> :CommandTFlush<CR>

map <leader>gf :CommandT %%<cr>

" # Rails shortcuts
map <leader>gv :CommandT app/views<cr>
map <leader>gc :CommandT app/controllers<cr>
map <leader>gm :CommandT app/models<cr>
map <leader>gh :CommandT app/helpers<cr>
map <leader>gl :CommandT lib<cr>
map <leader>gp :CommandT public<cr>
map <leader>gs :CommandT public/stylesheets<cr>
map <leader>gj :CommandT public/javascripts<cr>
map <leader>gR :call ShowRoutes()<cr>

" Navigation

" Speeding up viewport scrolling.
nnoremap <C-e> 5<C-e>
nnoremap <C-y> 5<C-y>

" Hold down the shift key to scroll left and right through the tabs with 'h' and 'l'.
map <S-h> gT
map <S-l> gt

" Insert < => > with Ctrl+l.
imap <c-l> <space>=><space>

" ## PASTE

" filter non-printable characters from the paste buffer
" useful when pasting from some gui application
nmap <leader>p :let @* = substitute(@*,'[^[:print:]]','','g')<cr>"*p

" Make shift-insert work like in Xterm.
map <S-Insert> <MiddleMouse>
map! <S-Insert> <MiddleMouse>

set pastetoggle=<F8> " When pasting from outside vim it turns off auto indentation. You can tell you are in paste mode when the ruler is not visible.

" # Indentation

" Fixes the following *feature*:
"     If you do not type anything on the new line except <BS> or CTRL-D and then
"     type <Esc> or <CR>, the indent is deleted again
inoremap <Enter> <Enter><space><bs>
nnoremap o o<space><bs>
nnoremap O O<space><bs> 
" Allow to easily change indentation styles.
noremap <F2> :<C-U>call Spaces2()<CR>
noremap <F3> :<C-U>call Spaces4()<CR>
noremap <F4> :<C-U>call Tabs4()<CR>

" Press Ctrl+h to toggle highlighting on/off.
noremap <C-h> :set hls!<CR>

iabbrev Lipsum Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum

" }}}

" File types {{{

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

"augroup settings
"  autocmd!
"
"  " Restore cursor position
"  autocmd BufReadPost *.rb if line("'\"") > 1 && line("'\"") <= line("$") |
"      \   exe "normal! g`\"" | endif
"
"  autocmd CursorHold,BufWritePost,BufReadPost,BufLeave *
"        \ if isdirectory(expand("<amatch>:h")) | let &swapfile = &modified | endif
"
"  autocmd BufNewFile,BufRead *.scss             set ft=scss.css
"  autocmd BufNewFile,BufRead *.md               set ft=markdown
"  autocmd BufNewFile,BufRead *.haml,*.jst       set ft=haml
"  autocmd BufNewFile,BufRead *.feature,*.story  set ft=cucumber
"  autocmd BufRead * if ! did_filetype() && getline(1)." ".getline(2).
"        \ " ".getline(3) =~? '<\%(!DOCTYPE \)\=html\>' | setf html | endif
"
"  autocmd FileType javascript,coffee            setlocal et sw=2 sts=2 isk+=$
"  autocmd FileType html,xhtml,css,scss.css      setlocal et sw=2 sts=2
"  autocmd FileType eruby,yaml,ruby              setlocal et sw=2 sts=2
"  autocmd FileType cucumber                     setlocal et sw=2 sts=2
"  "autocmd FileType cucumber                     inoremap <silent> <Bar>   <Bar><Esc>:call <SID>align()<CR>a
"  autocmd FileType gitcommit                    setlocal spell
"  autocmd FileType ruby                         setlocal comments=:#\  tw=79
"  autocmd FileType vim                          setlocal et sw=2 sts=2 keywordprg=:help
"  autocmd FileType python                       setlocal softtabstop=4 tabstop=4 shiftwidth=4 textwidth=79
"
"  autocmd Syntax   css  syn sync minlines=50
"
"  "autocmd User Rails nnoremap <buffer> <D-r> :<C-U>Rake<CR>
"  "autocmd User Rails nnoremap <buffer> <D-R> :<C-U>.Rake<CR>
"  autocmd User Rails Rnavcommand uploader app/uploaders -suffix=_uploader.rb -default=model()
"  autocmd User Rails Rnavcommand steps features/step_definitions -suffix=_steps.rb -default=web
"  autocmd User Rails Rnavcommand blueprint spec/blueprints -suffix=_blueprint.rb -default=model()
"  autocmd User Rails Rnavcommand factory spec/factories -suffix=_factory.rb -default=model()
"  autocmd User Rails Rnavcommand fabricator spec/fabricators -suffix=_fabricator.rb -default=model()
"  autocmd User Rails Rnavcommand support spec/support features/support -default=env
"  autocmd User Rails Rnavcommand sass app/sass -suffix=.scss -default=model()
"  autocmd User Fugitive command! -bang -bar -buffer -nargs=* Gpr :Git<bang> pull --rebase <args>
"
"  autocmd FileType ruby imap <C-l> <Space>=><Space>
"augroup END

" }}}

" Hints & Tips {{{

" Creates a new empty function (this keeps you in insert mode and typing!).
" map! ,f function() {<CR>}<ESC>k$a<CR>

" Commands I should use more:
" == correct indentation of current line; gg=G corrects indentation for entire file
" =a{ correct indentation of current block (also =% if u'r on the {)
" gi - goes back to last insert
" '. - goes to the last modification
" CTRL+E & Y (ins mod) - inserts chars from above and below line
" CTRL+T & D - indent and dedent in ins mod
" ; to repeat fX or FX
" :!sort, :!grep, :!
" :.! - execute system command and add output on the current line

" In order to copy a text from Vim to your clipboard for other application to
" use, select the text you want to copy in visual mode, and then press "+y. This
" way, you can easily paste your text to other applications.

" rails.vim
" gist.vim
" space.vim
" https://github.com/tpope/vim-fugitive
" example use of pathogen
" http://vimcasts.org/
" sessions
" "*p will paste from the different register
" :r!cat
" :map <C-F> /\V
" :help text-objects 
" http://www.vimgolf.com/
" Diff opt
" set diffopt=vertical
" http://vimcolorschemetest.googlecode.com/svn/colors/anotherdark.vim
" http://vimcolorschemetest.googlecode.com/svn/colors/inkpot.vim
" colorscheme evening
" colorscheme inkpot

" }}}

call Spaces4()

