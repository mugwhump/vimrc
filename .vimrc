" This line should not be removed as it ensures that various options are
" properly set to work with the Vim-related packages available in Debian.
runtime! debian.vim

" Uncomment the next line to make Vim more Vi-compatible
" NOTE: debian.vim sets 'nocompatible'.  Setting 'compatible' changes numerous
" options, so any other options should be set AFTER setting 'compatible'.
"set compatible


if has("syntax")
  syntax on
endif

" If using a dark background within the editing area and syntax highlighting
" turn on this option as well
"set background=dark

" Uncomment the following to have Vim jump to the last position when
" reopening a file
"if has("autocmd")
"  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
"endif

" Uncomment the following to have Vim load indentation rules and plugins
" according to the detected filetype.
if has("autocmd")
  filetype plugin indent on
endif

" The following are commented out as they cause vim to behave a lot
" differently from regular Vi. They are highly recommended though.
"set showcmd		" Show (partial) command in status line.
set showmatch		" Show matching brackets.
set ignorecase		" Do case insensitive matching
set smartcase		" Do smart case matching
set incsearch		" Incremental search
set autowrite		" Automatically save before commands like :next and :make
"set hidden             " Hide buffers when they are abandoned
set mouse=a		" Enable mouse usage (all modes)

" Source a global configuration file if available
if filereadable("/etc/vim/vimrc.local")
  source /etc/vim/vimrc.local
endif

" Use GHC compiler plugin
" See :help haskellmode for commands. They won't work until shit compiles.
au BufEnter *.hs compiler ghc

" Set preferred browser for viewing haddock documentation
let g:haddock_browser="/usr/lib/firefox/firefox"

" Stuff for Go
" Clear filetype flags before changing runtimepath to force Vim to reload
" them.
filetype off
filetype plugin indent off
set runtimepath+=/usr/lib/go/misc/vim
filetype plugin indent on
syntax on

" Find keycodes with :echo char2nr("c")
" For surround plugin. For some reason makes me specify the filetype or else I
" have to reload my vimrc manually...
" Type ? in php files to surround with <?php ?>
autocmd FileType php let b:surround_63 = "<?php \r ?>"
" Type - in haskell files to surround with {- -}
autocmd FileType haskell let b:surround_45 = "{-\r-}"

" Automatically indent"
set smartindent

"----------------------------------------------"
" Author:       timsateroy@gmail.com           "
" Source:       http://vim.thevoid.no (github) "
" Date:         06.05.13 (rougly)              "
"----------------------------------------------"

" vimconf is not vi-compatible
set nocompatible

""" Automatically make needed files and folders on first run
""" If you don't run *nix you're on your own (as in remove this) {{{
    call system("mkdir -p $HOME/.vim/{backup,plugin,undo}")
    if !filereadable($HOME . "/.vimrc.bundles") | call system("touch $HOME/.vimrc.bundles") | endif
    if !filereadable($HOME . "/.vimrc.first") | call system("touch $HOME/.vimrc.first") | endif
    if !filereadable($HOME . "/.vimrc.last") | call system("touch $HOME/.vimrc.last") | endif
""" }}}
""" Vundle plugin manager {{{
    """ Automatically setting up Vundle, taken from
    """ http://www.erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/ {{{
        let has_vundle=1
        if !filereadable($HOME."/.vim/bundle/vundle/README.md")
            echo "Installing Vundle..."
            echo ""
            silent !mkdir -p $HOME/.vim/bundle
            silent !git clone https://github.com/gmarik/vundle $HOME/.vim/bundle/vundle
            let has_vundle=0
        endif
    """ }}}
    """ Initialize Vundle {{{
        filetype off                                " required to init
        set rtp+=$HOME/.vim/bundle/vundle/          " include vundle
        call vundle#rc()                            " init vundle
    """ }}}
    """ Github repos, uncomment to disable a plugin {{{
    " Recursive vundle, omg!
    Bundle 'gmarik/vundle'

    """ Local bundles (and only bundles in this file!) {{{{
        if filereadable($HOME."/.vimrc.bundles")
            source $HOME/.vimrc.bundles
        endif
    """ }}}

    " New session manager since Vim's default breaks with one of these
    " plugins...
    " REQUIREMENTS: xolox/vim-misc
    Bundle 'xolox/vim-session'
    Bundle 'xolox/vim-misc'

    Bundle 'lambdatoast/elm.vim'

    "Jsx/JS highlighting and indenting. Press bracket keys to jump to func
    "braces (can be disabled)
    Bundle 'chemzqm/vim-jsx-improve'

    " Edit files using sudo/su
    Bundle 'chrisbra/SudoEdit.vim'

    " <Tab> everything!
    Bundle 'ervandew/supertab'

    " Fuzzy finder (files, mru, etc)
    Bundle 'kien/ctrlp.vim'

    " A much better statusline
    Bundle 'Lokaltog/vim-powerline'

    " Easy... motions... yeah.
    " Begin motions with ,,
    Bundle 'Lokaltog/vim-easymotion'

    " Glorious colorscheme
    "DOES DIS BREAK MUH TABS?? Yes it does. OR DOES IT.
    Bundle 'nanotech/jellybeans.vim'

    " Super easy commenting, toggle comments etc
    " ,c<space> to easily toggle all line comments! Check the help.
    Bundle 'scrooloose/nerdcommenter'

    " A file tree explorer
    Bundle 'scrooloose/nerdtree'

    " Color text based on RGB, hex, colornames
    " When airliner stops working, this stops too...a
    Bundle 'ap/vim-css-color'

    " Autoclose (, " etc. See :h autoclosepairs
    Bundle 'Townk/vim-autoclose'

    " Git wrapper inside Vim
    Bundle 'tpope/vim-fugitive'

    " Handle surround chars like ''
    Bundle 'tpope/vim-surround'

    " Align your = etc.
    " HOW THE FUCK DO I USE THIS
    Bundle 'vim-scripts/Align'

    " Simple compile/run binds. For single-file programs only (?)
    "Bundle 'xuhdev/SingleCompile'

    " Snippets like textmate
    " REQUIREMENTS: vim-addon-mw-utils, tlib_vim, vim-snippets
    Bundle 'MarcWeber/vim-addon-mw-utils'
    Bundle 'tomtom/tlib_vim'
    Bundle 'honza/vim-snippets'
    Bundle 'garbas/vim-snipmate'

    " Awesome syntax checker.
    " REQUIREMENTS: See :h Syntastic
    Bundle 'scrooloose/syntastic'

    " Functions, class data etc.
    " REQUIREMENTS: ctags
    Bundle 'majutsushi/tagbar'

    " http://pastie.org
    " REQUIREMENTS: ruby in $PATH (not vim compiled with +ruby)
    "Bundle 'simmel/vim-pastie'

    " C/C++ autocomplete
    " REUIREMENTS: clang compiler
    Bundle 'Rip-Rip/clang_complete'

    " Python autocomplete
    " REQUIREMENTS: python package 'jedi', also in virtenvs
    Bundle 'davidhalter/jedi-vim'

    " Slime for vim
    " REQUIREMENTS: GNU screen or tmux
    "Bundle 'jpalardy/vim-slime' "GODDAMMIT THIS SHIT DON'T WERK ;_; fucking
    "screen, fucking tmux ;_;

    " localrc
    Bundle 'thinca/vim-localrc'

    " FanfingTastic - multiline f's and t's
    Bundle 'dahu/vim-fanfingtastic'

    " Tablineset - muck with the tab line. Doesn't work with vim-gtk...
    "Bundle 'vim-scripts/TabLineSet.vim'

    " Twig files (Drupal templates)
    Bundle 'nelsyeung/twig.vim'

    " Typescript files "
    Bundle 'leafgarland/typescript-vim'

    " vim-latex
    "Bundle 'jcf/vim-latex'
    """ }}}

    """ Installing plguins the first time {{{
        if has_vundle == 0
            echo "Installing Bundles, please ignore key map error messages"
            echo ""
            :BundleInstall
        endif
    """ }}}
""" }}}
" ---------------- MAPPINGS -----------------"
let mapleader=","
" Map 'jk' to Esc in insert mode. 2 Escapes to close suggestion window
imap jk <Esc><Esc>`^

" Switch tabs with SHIFT+h/l"
nmap <S-h> gT
nmap <S-l> gt

" Switch ctrl-r (redo) with ctrl-y (scroll up)
nnoremap <C-r> <C-y>
nnoremap <C-y> <C-r>

" Quit all tabs with QQ
nmap QQ :qa<CR>

nnoremap <leader>s :w<CR>
inoremap <leader>s <Esc>:w<CR>
nnoremap <C-s> :w<CR>
inoremap <C-s> <Esc>:w<CR>

nnoremap <C-c> :bd<CR>

" Press Ctrl-mk to make. 
nmap <C-m><C-k> :make<CR>
" Useful to map running program, like so
" :nmap <leader><CR> :!./program args

" User Ctrl-h/j/k/l to navigate in insert mode"
imap <C-h> <Left>
inoremap <C-j> <Down>
imap <C-k> <Up>
imap <C-l> <Right>

" Use Ctrl-j/k (in normal mode) to jump to the END of the next/previous line,
" like the opposite of -/+
nmap <C-j> j$
nmap <C-k> k$

" Press F2 to explore directory of current file
map <F2> :tabe %:p:h<CR>

" Press Enter in normal mode to insert linebreak
nmap <CR> i<CR><Esc>^

" TODO: Make command to automate this. Prints path of header if found on comp
" !echo '#include <header.h>' | cpp -H -o /dev/null 2>&1 | head -n1

" ---------------- DEBUGGING -----------------"
"  Debug down with Clewn plugin. Start it with :Pyclewn, close w/ :nbclose
"  Feed your executable to gdb with :Cfile executable
"  Run it with Crun <arg1> <arg2>, to give args to program
"  Can map keys to Clewn with :Cmapkeys, but it overwrites mine...
"  change back with Cunmapkeys.
"  Change mappings in /usr/local/share/vim/vimfiles/macros/.pyclewn_keys.gdb
"  Or not.
"nnoremap <leader>dp :Pyclewn<CR>
nnoremap <leader>db :exe "Cbreak " . expand("%:p") . ":" . line(".")<CR>
nnoremap <leader>dd :Cdelete<CR>
nnoremap <leader>dr :Crun<CR>
nnoremap <leader>dn :Cnext<CR>
nnoremap <leader>ds :Cstep<CR>
nnoremap <leader>df :Cfinish<CR>
nnoremap <leader>dc :Ccontinue<CR>
nnoremap <leader>dl :Cinfo locals<CR>
nnoremap <leader>da :Cinfo args<CR>
nnoremap <leader>dj :Cdown<CR>
nnoremap <leader>dk :Cup<CR>
nnoremap <leader>dp :Cprint
nnoremap <leader>di :Cinfo

" ------------------- TAB STUFF ---------------------"

"TabSetLine plugin has lots of options I can set..." 

"Open new buffers in new tabs, and look for already open tabs first.
set switchbuf=usetab,newtab

"Command to close all hidden buffers (those not open in tabs or windows)
"from https://gist.github.com/skanev/1068214
command! BC call s:BC()
function! s:BC()
    let open_buffers = []
     
    for i in range(tabpagenr('$'))
        call extend(open_buffers, tabpagebuflist(i + 1))
    endfor
     
    for num in range(1, bufnr("$") + 1)
        if buflisted(num) && index(open_buffers, num) == -1
            exec "bdelete ".num
        endif
    endfor
endfunction

"t-ctrl-] will jump to tags in a new tab
nnoremap t<C-]> :tabnew %<CR>g<C-]>
vnoremap t<C-]> <Esc>:tabnew %<CR>gvg<C-]>


" ------------------- DIRECTORY STUFF ---------------------"
" Creates a command-line abbreviation of %% for the current file.
" This lets you write shit like ':e %%/butts.txt' to open butts.txt without
" having to change the current directory.
cabbr <expr> %% expand('%:p:h')

" Set path to the working directory and all subfolders (useful for finding files)"
set path=$PWD/**

" ------------------- MAKE STUFF ---------------------"

" Automatically open, but do not go to (if there are errors) the quickfix /
" location list window, or close it when is has become empty.

" Note: Must allow nesting of autocmds to enable any customizations for quickfix
" buffers.
" Note: Normally, :cwindow jumps to the quickfix window if the command opens
" it (but not if it's already open). However, as part of the autocmd, this
" doesn't seem to happen.
" COMMANDS:
" :cc see current error
" :cn next error
" :cp previous error
" :clist list all errors
" :ccl[ose] close error window (use :cope[n] to open it again)
autocmd QuickFixCmdPost [^l]* nested cwindow
autocmd QuickFixCmdPost    l* nested lwindow

" Automatically watch for changes in vimrc and reload vim when detected"
"augroup myvimrc " {
    "au!
    "au BufWritePost $MYVIMRC so $MYVIMRC
"augroup END " }



" ------------------------DUDE'S VIMRC ----------------------------------
""" Local beginning config, only use for prerequisites as it will be
""" overwritten by anything below {{{{
    if filereadable($HOME."/.vimrc.first")
        source $HOME/.vimrc.first
    endif
""" }}}
""" User interface {{{
    """ Syntax highlighting {{{
        filetype plugin indent on                   " detect file plugin+indent
        syntax on                                   " syntax highlighting
        set t_Co=256                                " 256-colors
        set background=dark                         " we're using a dark bg
        "colors jellybeans                           " select colorscheme
        highlight Normal ctermbg=NONE               " use terminal background
        highlight nonText ctermbg=NONE              " use terminal background
"        au BufRead,BufNewFile *.txt set ft=sh       " opens .txt w/highlight
        """ Tab colors {{{
            hi TabLineFill ctermfg=NONE ctermbg=233
            hi TabLine ctermfg=241 ctermbg=233
            hi TabLineSel ctermfg=250 ctermbg=233
        """ }}}
    """ }}}
    """ Interface general {{{
        set cursorline                              " hilight cursor line
        set more                                    " ---more--- like less
"        set number                                  " line numbers
        set scrolloff=3                             " lines above/below cursor
        set showcmd                                 " show cmds being typed
        set title                                   " window title
        set vb t_vb=                                " disable beep and flashing
        set wildignore=.bak,.pyc,.o,.ojb,.,a,       " ignore said files
                       \.pdf,.jpg,.gif,.png,
                       \.avi,.mkv,.so
        set wildmenu                                " better auto complete
        set wildmode=longest,list                   " bash-like auto complete
        """ Encoding {{{
            " If you're having problems with Powerline glyphs you can force
            " UTF-8 if your locale is something else.
            " WARNING: this will affect encoding used when editing files!
            "
            " set encoding=utf-8                    " for Powerline glyphs
        """ }}}
        """ session {{{
            let g:session_autoload='yes'          " when opening vim on its own, load last nameless session (made with :SaveSession) "
            let g:session_autosave='yes'          " If you're in a session, save it automatically on quitting. "
        """ Gvim {{{
            set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 8
            set guioptions-=m                       " remove menubar
            set guioptions-=T                       " remove toolbar
            set guioptions-=r                       " remove right scrollbar
        """ }}}
        """ Jellybeans {{{
            let g:jellybeans_overrides = {
                        \ 'Visual': {'guibg': 'Black', 'ctermbg': 'Black', 'cterm': 'Black'}} 
                " DOESN'T WORK, had to change 'Visual' line in jellybeans
                " plugin itself to 000000...
        """ }}}
        """ Powerline {{{
            let g:Powerline_symbols = 'compatible'  " see :h Powerline_symbols
            let g:Powerline_symbols_override = {
                        \ 'BRANCH': [0x2213],
                        \ }                         " use ∓
            """ Powerline mode names {{{
                let g:Powerline_mode_n  = ' N '
                let g:Powerline_mode_i  = ' I '
                let g:Powerline_mode_R  = ' R '
                let g:Powerline_mode_v  = ' V '
                let g:Powerline_mode_V  = 'V·L'
                let g:Powerline_mode_cv = 'V·B'
                let g:Powerline_mode_s  = ' S '
                let g:Powerline_mode_S  = 'S·L'
                let g:Powerline_mode_cs = 'S·B'
            """ }}}
        """ }}}
    """ }}}
""" }}}
""" General settings {{{
    set hidden                                      " buffer change, more undo
    set history=1000                                " default 20
    set iskeyword+=_,$,@,%,#                        " not word dividers
    set laststatus=2                                " always show statusline
    set linebreak                                   " don't cut words on wrap
    set listchars=tab:>\                            " > to highlight <tab>
    set list                                        " displaying listchars
"    set mouse=                                      " disable mouse
    set noshowmode                                  " hide mode, got powerline
    set noexrc                                      " don't use other .*rc(s)
    set nostartofline                               " keep cursor column pos
"    set nowrap                                      " don't wrap lines
    set numberwidth=5                               " 99999 lines
    set shortmess+=I                                " disable startup message
    set splitbelow                                  " splits go below w/focus
    set splitright                                  " vsplits go right w/focus
    set ttymouse=xterm2                             " experimental
    """ Folding {{{
        set foldcolumn=0                            " hide folding column
        "set foldmethod=indent                       " folds using indent
        set foldnestmax=10                          " max 10 nested folds
        set foldlevelstart=99                       " folds open by default
    """ }}}
    """ Search and replace {{{
        set gdefault                                " default s//g (global)
        set incsearch                               " "live"-search
    """ }}}
    """ Matching {{{
        set matchtime=2                             " time to blink match {}
        set matchpairs+=<:>                         " for ci< or ci>
        set showmatch                               " tmpjump to match-bracket
    """ }}}
    """ Return to last edit position when opening files {{{
        autocmd BufReadPost *
            \ if line("'\"") > 0 && line("'\"") <= line("$") |
            \     exe "normal! g`\"" |
            \ endif
    """ }}}
""" }}}
""" Files {{{
"    set autochdir                                   " always use curr. dir.
    set noswapfile                                  " I hate swap files
    set autoread                                    " refresh if changed
"    set backup                                      " backup curr file
    set backupdir=$HOME/.vim/backup                 " backup director{y,ies}
    set backupext=~                                 " append ~ to backups
    set confirm                                     " confirm changed files
    "set noautowrite                                 " never autowrite. I've
    "got autowrite set above...
    set updatecount=50                              " update swp after 50chars
    """ Persistent undo. Requires Vim 7.3 {{{
        if has('persistent_undo') && exists("&undodir")
            set undodir=$HOME/.vim/undo/            " where to store undofiles
            set undofile                            " enable undofile
            set undolevels=500                      " max undos stored
            set undoreload=10000                    " buffer stored undos
        endif
    """ }}}
""" }}}
""" Text formatting {{{
    set autoindent                                  " preserve indentation
    set backspace=indent,eol,start                  " smart backspace
    set cinkeys-=0#                                 " don't force # indentation
    set expandtab                                   " no real tabs
    set ignorecase                                  " by default ignore case
    set nrformats+=alpha                            " incr/decr letters C-a/-x
    set shiftround                                  " be clever with tabs
    set shiftwidth=4                                " default 8
    set smartcase                                   " sensitive with uppercase
    set smarttab                                    " tab to 0,4,8 etc.
    set softtabstop=4                               " "tab" feels like <tab>
    set tabstop=4                                   " replace <TAB> w/4 spaces
    """ Only auto-comment newline for block comments {{{
        au FileType c,cpp setlocal comments -=:// comments +=f://
    """ }}}
    " For twig files, set tabstop to 2
    au FileType *twig* setlocal shiftwidth=2 tabstop=2 softtabstop=2
""" }}}
""" Keybindings {{{
    """ General {{{
        " Remap <leader>

        " Quickly edit/source .vimrc
        noremap <leader>ve :tabe $HOME/.vimrc<CR>
        noremap <leader>vs :source $HOME/.vimrc<CR>

        " Yank(copy) to system clipboard
        noremap <leader>y "+y

        " Paste from system clipboard
        noremap <leader>p "+p
        noremap <leader>P "+P

        " Toggle text wrapping
        nmap <silent> <leader>w :set invwrap<CR>:set wrap?<CR>

        " Toggle folding
        nnoremap <silent> <Space> @=(foldlevel('.')?'za':"\<Space>")<CR>
        vnoremap <Space> zf

        " Bubbling (bracket matching)
        nmap <C-up> [e
        nmap <C-down> ]e
        vmap <C-up> [egv
        vmap <C-down> ]egv

        " Treat wrapped lines as normal lines
        nnoremap j gj
        nnoremap k gk

        " Move a line of text using ALT-{j,k}
        nmap <M-j> mz:m+<CR>`z
        nmap <M-k> mz:m-2<CR>`z

        " Rebind æøå (Norwegian keys)
        noremap ø :
        noremap å [
        noremap æ ]

        " Working ci(, works for both breaklined, inline and multiple ()
        nnoremap ci( %ci(

        " We don't need any help!
        inoremap <F1> <nop>
        nnoremap <F1> <nop>
        vnoremap <F1> <nop>
    """ }}}
    """ Functions or fancy binds {{{{
        """ Toggle syntax highlighting {{{
            map <F4> :if exists("syntax_on")
                \<Bar>syntax off<Bar>else<Bar>syntax enable<Bar>endif<CR>
        """ }}}
        """ Highlight characters past 79, toggle with <leader>h {{{
            nnoremap <leader>h :call ToggleOverLengthHighlight()<CR>
            let g:overlength_enabled = 0
            highlight OverLength ctermbg=black guibg=#212121

            function! ToggleOverLengthHighlight()
                if g:overlength_enabled == 0
                    match OverLength /\%79v.*/
                    let g:overlength_enabled = 1
                    echo 'OverLength highlighting turned on'
                else
                    match
                    let g:overlength_enabled = 0
                    echo 'OverLength highlighting turned off'
                endif
            endfunction
        """ }}}
        """ Toggle relativenumber using <leader>r {{{
            "nnoremap <leader>r :call NumberToggle()<CR>

            function! NumberToggle()
                if(&relativenumber == 1)
                    set number
                else
                    set relativenumber
                endif
            endfunction
        """ }}}
        """ Remove multiple empty lines {{{
            nnoremap <leader>ld :call DeleteMultipleEmptyLines()<CR>

            function! DeleteMultipleEmptyLines()
                g/^\_$\n\_^$/d
            endfunction
        """ }}}
        """ Split to relative header/source {{{
            nnoremap <leader>le :call SplitRelSrc()<CR>

            function! SplitRelSrc()
                let s:fname = expand("%:p:r")

                if expand("%:e") == "h"
                    set nosplitright
                    exe "vsplit" fnameescape(s:fname . ".cpp")
                    set splitright
                elseif expand("%:e") == "cpp"
                    exe "vsplit" fnameescape(s:fname . ".h")
                endif
            endfunction
        """ }}}
        """ Strip trailing whitespace, return to cursors at save {{{
            function! <SID>StripTrailingWhitespace()
                let l = line(".")
                let c = col(".")
                %s/\s\+$//e
                call cursor(l, c)
            endfunction

            autocmd FileType c,cpp,css,html,perl,python,sh autocmd 
                        \BufWritePre <buffer> :call <SID>StripTrailingWhitespace()
        """ }}}
    """ }}}
    """ Plugins {{{
        " Toggle tagbar (definitions, functions etc.)
        map <F1> :TagbarToggle<CR>

        " Toggle the NERDTree file browser
        map <F2> :NERDTreeToggle<CR>

        " Toggle pastemode, doesn't indent
        set pastetoggle=<F3>

        " SingleCompile
        "nmap <F5> :SCCompile<CR>
        "nmap <F6> :SCCompileRun<CR>

        " Syntastic - toggle error list. Probably should be toggleable.
        "<silent> just means it won't be echoed to command line
        noremap <silent><leader>lo :Errors<CR>
        noremap <silent><leader>lc :lcl<CR>
    """ }}}
""" }}}
""" Misc plugin settings {{{
    " vim-latex - make grep results show filenames
    set grepprg=grep\ -nH\ $*\ /dev/null
    let g:tex_flavor='latex'
    " Change jump-to-next-completion from ctrl-j to alt-j
    imap <M-j> <Plug>IMAP_JumpForward

    " clang_complete - C++11
    let g:clang_user_options="-std=c++0x"
    " don't overwrite the <C-]> default which works better than clang's
    let g:clang_jumpto_declaration_key="<leader>]"  
    " point it to libclang
    let g:clang_library_path="/usr/lib/llvm-3.4/lib/libclang.so"

    " supertab uses clang_complete's completion menu
    "au FileType c,cpp :call SuperTabSetDefaultCompletionType("<c-x><c-u>")

    " CtrlP - don't recalculate files on start (slow)
    let g:ctrlp_clear_cache_on_exit = 0
    let g:ctrlp_working_path_mode = 'ra'

    " NERDTree
    let g:NERDTreeWinPos = "left"
    let g:NERDTreeHijackNetrw = 1

    " TagBar
    let g:tagbar_left = 0
    let g:tagbar_width = 30
    set tags=tags;/

    " Pastie - private (simmel's fork of tpope's vim-pastie with help from garno)
    let g:pastie_private = 1

    " SingleCompile - check if installed since this gives warnings if not
    "autocmd VimEnter * if exists('g:loaded_SingleCompile')
        "call SingleCompile#SetCompilerTemplate('cpp', 'gcc', 'GNU C Compiler',
            "\'g++', '-Wall -Wextra -pedantic -O3 -std=c++0x -o $(FILE_TITLE)$',
            "\'./$(FILE_TITLE)$')
        "call SingleCompile#SetOutfile('cpp', 'gcc', '$(FILE_TITLE)$')
        "call SingleCompile#ChooseCompiler('cpp', 'gcc')

    " Syntastic - This is largely up to your own usage, and override these
    "             changes if be needed. This is merely an exemplification.
    let g:syntastic_cpp_check_header = 0
    let g:syntastic_check_on_wq = 0
    let g:syntastic_cpp_compiler_options = ' -std=c++0x'
    let g:syntastic_mode_map = {
        \ 'mode': 'passive',
        \ 'active_filetypes':
            \ ['c', 'cpp', 'perl', 'python'] }
    "If this isn't 1, need to open :Errors window to populate list
    "and jump through errors with :lne :lp
    let g:syntastic_always_populate_loc_list=1
    "Automatically jump to first error when opening or saving file.
    let g:syntastic_auto_jump=0
    "Use eslint to syntax check js/es6
    let g:syntastic_javascript_checkers = ['eslint']

    " Tablineset tab configuration
    "let g:TabLineSet_verbose = 'modified' "join( g:TabLineSet_verbose_sets[5], ',' )"

    " Don't auto-close '' pair in racket or haskell files, or ` in latex
    autocmd FileType scheme
            \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")
    autocmd FileType haskell
            \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "'")
    autocmd FileType tex
            \ let b:AutoClosePairs = AutoClose#DefaultPairsModified("", "`")

    "Never autoclose brackets, shit be annoying.
      let g:AutoClosePairs_del = "{}"

    " Automatically remove preview window after autocomplete (mainly for clang_complete)
    autocmd CursorMovedI * if pumvisible() == 0|pclose|endif
    autocmd InsertLeave * if pumvisible() == 0|pclose|endif
""" }}}
""" Local ending config, will overwrite anything above. Generally use this. {{{{
    if filereadable($HOME."/.vimrc.last")
        source $HOME/.vimrc.last
    endif
""" }}}

