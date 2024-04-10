" ----------------------------------------------------------
" ---------------------- Header ----------------------------
" ----------------------------------------------------------
" Settings file for vim.
" Compiled from various sources by Adam Larios.
" File should be named ".vimrc" and located in $HOME directory.
" Last change 2010-08-07.
" ----------------------------------------------------------
" -------------------- End Header --------------------------
" ----------------------------------------------------------

" ----------------------------------------------------------
" ----------------------- Notes ----------------------------
" ----------------------------------------------------------
" For quick reference, some commands are included below.
" For a great tutorial, just type vimtutor into a terminal window. 
"
" ----------------
" Misc. Commands
" ----------------
" Esc        exit current mode
" u          undo
" CTRL+R     redo
" .          repeat last command at current location
" ~          Toggle between lowercase and uppercase.
" :!<CMD>    execute the shell command <CMD>  
" :1,$!<CMD> pass lines 1 up to end of file ($) to <CMD>, e.g. :1,$!sort
" 4!!<CMD>   Use <CMD> on the next 4 lines, e.g. 4!!awk '{print "New text",$0}'
" :set all   see a list of all available options to set
" >>         indent
" <<         unindent
" 5>>        indent the next 5 lines
"
" ----------------
" Search Commands
" ----------------
" /my_str              search text for the string "my_str"
" /my_str1/;/mystr2/   compound search for "my_str1" followed by "my_str2"

" ----------------
" Basic Commands
" ----------------
" i  insert text before the cursor
" I  insert text at the beginning of the line
" a  insert (append) text after the cursor
" A  insert (append) text at the end of the line
" s  erases the current letter and place you in insert mode. 
" S  erases the whole line and place you in insert mode.
" o  creates a newline below the line and put you insert mode
" O  creates a newline above the line and put you in insert mode.
" x  delete character under cursor
" X  delete character before cursor
" r  replace character under cursor
" R  Enter replace mode (overwrite everything starting from cursor)
" y  yank (copy) [use with a movement command]
" yy yanks an entire line
" c  change [use with a movement command], delete and enter insert mode 
" cc delete the current line and enter insert mode
" d  delete [use with a movement command], store in buffer for pasting
" dd delete entire line, store in buffer for pasting
" p  paste contents of buffer
" *  highlights the current word
" n  will search forward for highlighted word
" N  will search backward for highlighted word
"
"
" ----------------
" movement commands
" ----------------
" h  move cursor left
" j  move cursor down
" k  move cursor up
" l  move cursor right
" ^  Start of line
" $  End of line
" w  start of next word
" W  start of next word, skip funny characters
" e  end of current word
" E  end of current word, skip funny characters
" b  back one word
" B  back one word, skip funny characters
" H  top of screen (Header)
" M  middle of screen
" L  bottom of screen (Lower)
" gg begininng of the file
" G  end of the file
"
" ----------------
" Visual Mode
" ----------------
" v enter visual mode (used to select text with cursor)
" V enter visual line mode (same as visual, but for entire lines)
" y yank the selected text into the buffer, while in visual mode
" c cut the selected text into the buffer, while in visual mode
" p paste buffer after cursor
" P paste buffer before cursor
"
" ----------------
" vimdiff Commands
" ----------------
" At the command line, enter: 
"     vimdiff file1 file2
" to compare the differences between to files.
" For multiple files, see type "man vimdiff" into a terminal.
"
" ]c :        - next difference
" [c :        - previous difference
" Ctrl+ww     - switch windows
" do          - diff obtain
" dp          - diff put
" zo          - open folded text
" zc          - close folded text
" :diffupdate - re-scan the files for differences
" :qa   quit all open vim windows
"
" -----------------------
" "sed" commands
" -----------------------
" :s/xxx/yyy/        Replace xxx with yyy at the first occurence
" :s/xxx/yyy/g       Replace xxx with yyy first occurrence, whole sentence
" :s/xxx/yyy/gc      Replace xxx with yyy global with confirm
" :%s/xxx/yyy/g      Replace xxx with yyy global in the whole file
" :3,4s/xxx/yyy/g    Replace 'spam' with 'eggs' between lines 3&4
" :g/^#/d            Delete all lines that begins with #
" :g/^$/d            Delete all lines that are empty
" :%s/^\(x\)/y\1z/g  Replace x with xyz
"
" -----------------------
" "awk" commands
" -----------------------
" :5,15!awk '{print $1}' | CMD    execute "CMD" on lines 5 through 15
"
" -----------------------
" Check Spelling
" -----------------------
" set spell
"
" -----------------------
" Syntax Highlighting
" -----------------------
" filetype plugin on
" syntax on
"
" -----------------------
" File Commands
" -----------------------
" :w    write (save) current file
" :q    quit vim if no changes were made
" :q!   quit vim without saving changes
" :wq   write changes and quit
" :x    write changes and quit (same as wq)
" :qa   quit all open vim windows
" :6,9w write only lines 6 through 9

"
" -----------------------
" Window commands
" -----------------------
" :sp      split the current window horizontally
" CTRL-ws  split the current window horizontally
" :vsp     split the current window vertically
" CTRL-wv  split the current window vertically
" CTRL-ww  change to next window
" 
" -----------------------
" Bookmarks
" -----------------------
" M<letter>   Place a bookmark, referenced by <letter>.
"             Here, <letter> is a lowercase letter.  
" `<letter>   Return to a bookmark marked <letter>.
" .

" ----------------------------------------------------------
" --------------------- End Notes --------------------------
" ----------------------------------------------------------

" ----------------------------------------------------------
" --------------------- Settings ---------------------------
" ----------------------------------------------------------

" When started as "evim", evim.vim will already have done these settings.
if v:progname =~? "evim"
  finish
endif

set nocompatible   " Use Vim settings, rather then Vi settings.
                   " This must be first, because it changes
                   " other options as a side effect.

set softtabstop=2

set tabstop=2       " Use 4 spaces instead of tabs.

set shiftwidth=2    " Number of spaces to use for each step of (auto)indent.
 
set expandtab       " Use the appropriate number of spaces to insert a <Tab>.
                    " Spaces are used in indents with the '>' and '<' commands
                    " and when 'autoindent' is on. To insert a real tab when
                    " 'expandtab' is on, use CTRL-V <Tab>.
 
set smarttab        " When on, a <Tab> in front of a line inserts blanks
                    " according to 'shiftwidth'. 'tabstop' is used in other
                    " places. A <BS> will delete a 'shiftwidth' worth of space
                    " at the start of the line.

" set guifont=monospace\ 13

set title

set novisualbell    " turns off visual bell

set backspace=indent,eol,start " allow backspacing over everything in insert mode

set history=1000    " keep 500 lines of command line history

set ruler	    " show the cursor position all the time

set showcmd	    " display incomplete commands

set incsearch	    " do incremental searching

set wrapscan        " When search reaches end of file, go to the beginning.
 
set showcmd         " Show (partial) command in status line.

set number          " Show line numbers.

" set rnu           " Show line numbers relative to current (vim 7.3 or higher).

set showmatch       " When a bracket is inserted, briefly jump to the matching
                    " one. The jump is only done if the match can be seen on the
                    " screen. The time to show the match can be set with
                    " 'matchtime'.
 
set hlsearch        " When there is a previous search pattern, highlight all
                    " its matches.
 
set incsearch       " While typing a search command, show immediately where the
                    " so far typed pattern matches.
 
set ignorecase      " Ignore case in search patterns.  
                    " For shorthand, use :set ic and :set noic
 
set smartcase       " Override the 'ignorecase' option if the search pattern
                    " contains upper case characters.
 
set backspace=2     " Influences the working of <BS>, <Del>, CTRL-W
                    " and CTRL-U in Insert mode. This is a list of items,
                    " separated by commas. Each item allows a way to backspace
                    " over something.
 

 
set textwidth=0    " Maximum width of text that is being inserted. A longer
                    " line will be broken after white space to get this width.
                    " 0 means no maximum is enforced
 
set wrapmargin=0    " Number of characters from the right window border where 
                    " wrapping starts.  When typing text beyond this limit, 
                    " an <EOL> will be inserted and inserting continues 
                    " on the next line.
                    " 0 means no maximum is enforced

set formatoptions=c,q,r,t " This is a sequence of letters which describes how
                    " automatic formatting is to be done.
                    "
                    " letter    meaning when present in 'formatoptions'
                    " ------    ---------------------------------------
                    " c         Auto-wrap comments using textwidth, inserting
                    "           the current comment leader automatically.
                    " q         Allow formatting of comments with "gq".
                    " r         Automatically insert the current comment leader
                    "           after hitting <Enter> in Insert mode. 
                    " t         Auto-wrap text using textwidth (does not apply
                    "           to comments)
 
set ruler           " Show the line and column number of the cursor position,
                    " separated by a comma.
 
set background=dark " When set to "dark", Vim will try to use colors that look
                    " good on a dark background. When set to "light", Vim will
                    " try to use colors that look good on a light background.
                    " Any other value is illegal.
 
"set mouse=a         " Enable the use of the mouse.
"set mouse=r         " Allow for middle-click paste. 

set backupdir=~/tmp " To prevent clutter, tell vim to use a back directory.

set autoread        " Set to auto-read when a file is changed from outside

set paste           " Fix auto-indenting when pasting

"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" => Files, backups and undo
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Turn backup off, since most stuff is in SVN, git anyway...
" set nobackup
" set nowb
" set noswapfile

" "Persistent undo
" set undodir=~/.vim_runtime/undodir
" set undofile
 
filetype plugin indent on
syntax on

" To save your sessions, uncomment the following three lines.
" set sessionoptions=blank,buffers,curdir,folds,help,resize,tabpages,winsize
" map <Leader>ss :mksession! ~/.vim/Session.vim <cr>
" map <Leader>so :source ~/.vim/Session.vim <cr>


" -----------------------
" Colors and Highlighting
" -----------------------
set t_Co=256
" Various color schemes, only use one at a time:
" Colorschemes are stored as ~/.vim/color/*.vim
" Use a different colorscheme for vimdiff:
colorscheme dusk
if &diff
 colorscheme evening
colorscheme desertEx
endif

 "     map <silent><F3> :NEXTCOLOR<cr>
 "    map <silent><F2> :PREVCOLOR<cr> 

" Fix the difficult-to-read default setting for diff text highlighting.  The
" bang (!) is required since we are overwriting the DiffText setting. The highlighting
" for "Todo" also looks nice (yellow) if you don't like the "MatchParen" colors.
"highlight! link DiffText MatchParen


" set t_AB=^[[48;5;%dm
" set t_AF=^[[38;5;%dm

" Switch syntax highlighting on, when the terminal has colors
" Also switch on highlighting the last used search pattern.
if &t_Co > 2 || has("gui_running")
  syntax on
  set hlsearch
endif

"" Make vim automatically set the title of screen windows to vim:<file>
" if $TERM=='screen'
"       exe "set title titlestring=vim:%f"
"       exe "set title t_ts=\<ESC>k t_fs=\<ESC>\\"
" endif

"if has("vms")
"  set nobackup		" do not keep a backup file, use versions instead
"else
"  set backup		" keep a backup file
"endif
set backup

" Only do this part when compiled with support for autocommands.
if has("autocmd")

  " automatically do :set wrap when using vimdiff
  au VimEnter * if &diff | execute 'windo set wrap' | endif

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

  " When editing a file, always jump to the last known cursor position.
  " Don't do it when the position is invalid or when inside an event handler
  " (happens when dropping a file on gvim).
  autocmd BufReadPost *
    \ if line("'\"") > 0 && line("'\"") <= line("$") |
    \   exe "normal g`\"" |
    \ endif

  augroup END

else

  set autoindent    " Copy indent from current line when starting a new line
                    " (typing <CR> in Insert mode or when using the "o" or "O"
                    " command).

endif " has("autocmd")

" -----------------------------
" syntax enable "Enable syntax hl

" " Set font
"   set gfn=Monospace\ 10
"   set shell=/bin/bash
" 
" if has("gui_running")
"   set guioptions-=T
"   set t_Co=256
"   set background=dark
"   colorscheme peaksea
" else
"   colorscheme zellner
"   set background=dark
" 
" endif
" 
" set encoding=utf8
" try
"     lang en_US
" catch
" endtry
" 
" set ffs=unix,dos,mac "Default file types



" -----------------
" Advanced Settings
" -----------------

"" Uncomment below to remap keys for splitting windows
"" Anywhere you see '<leader>', just type the comma
"" For example:
""   <leader>sh       - split and open a new window below current one
""   <leader>swh      - split and open a new window below all windows
""   CTRL+w {h,l,k,j} - move left, right, up, down
""   CTRL+w {H,L,K,J} - move windows left, right, up, down
"" Note: the standard h,j,k,l directions are used. 
" let mapleader = "," 
"" mappings to split window
"nmap <leader>swh :topleft  vnew<CR>
"nmap <leader>swl :botright vnew<CR>
"nmap <leader>swk :topleft  new<CR>
"nmap <leader>swj :botright new<CR>
"
"" mappings to split window and buffer
"nmap <leader>sh :leftabove  vnew<CR>
"nmap <leader>sl :rightbelow vnew<CR>
"nmap <leader>sk :leftabove  new<CR>
"nmap <leader>sj :rightbelow new<CR>




" ----------------------------------------------------------
" ------------------- End Settings -------------------------
" ----------------------------------------------------------
