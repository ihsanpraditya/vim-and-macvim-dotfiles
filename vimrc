""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" INDEX """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Frequently Visited References
" Macvim Conf
" VIM-PLUG (Minimalist VIM plugin manager)
" 1. Vim's plugins configuration :
    " Provider (enhancing vim, used by completion)
    " Nerdtree (file explorer)
    " Startify
    " Indent
    " Visual-multi (selection)
    " Emmet (webdev plugin for highspeed coding and editing)
    " Vimtex (vim plugin for latex)
    " Tex-conceal (latex syntax rendering appearance inside code editor)
    " Markdownpreview
    " Lightline (status bar customization)
    " Git Gutter
    " Deoplete
    " ALE
    " Matchit
    " editorconfig
    " Ultisnips
    " FZF VIM
" 2. Vim's preferences :
    " Fzf search
    " Background switch button
    " Cursor
    " Terminal setting
    " Coloring
    " Colorscheme
    " Seoul256
    " Transparent
    " GVIM/MACVIM
    " Font
    " Better rainbow parentheses
    " HTML, SQL inside PHP highlighting
" 3. Mapping :
    " tab
    " Map clearing highlighting after searching to <esc>
    " Scrolling in insert mode
    " Scrolling for other split windows (just 2 windows)
    " Unmap ctrl-z for :stop
    " auto-complete trigger with tab
    " Mapleader
    " Command
" 4. Other vim's preferences

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""""""""""""""""""" INDEX """""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" FREQUENTLY VISITED REFERENCES
"

" VIM-PLUG
" required before run vim-plug
set nocompatible " Turn off compatible mode.
set nomodeline " Turn off modeline support.
filetype off " Required Firstly

" running vim-plug
call plug#begin('~/.vim/plugged')

" APP FEATURE
Plug 'mhinz/vim-startify' " welcome page
Plug 'scrooloose/nerdtree' " file explorer at side bar.
Plug 'Xuyuanp/nerdtree-git-plugin' " Git symbol at Nerd explorer
Plug 'preservim/tagbar' " displays tags in a window, ordered by scope
Plug 'tpope/vim-fugitive' " A Git wrapper
Plug 'airblade/vim-gitgutter' " shows git diff markers in the sign column and stages/previews/undoes hunks & partial
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/vim-markdown'
Plug 'gcmt/taboo.vim' " Few utilities for pretty tabs.
Plug 'qpkorr/vim-bufkill' " unload, delete or wipe a buffer without closing the window it was displayed in.

" EDITING
Plug 'jiangmiao/auto-pairs' " auto pair bracket, etc
Plug 'tpope/vim-surround' " Surround shortcut
Plug 'mattn/emmet-vim' " HTML CSS toolkit
Plug 'Yggdroot/indentLine' " Show indentation line
Plug 'mg979/vim-visual-multi', {'branch': 'master'} " multi cursor
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for': ['markdown', 'vim-plug']}
Plug 'KeitaNakamura/tex-conceal.vim', {'for': 'tex'}
Plug 'kien/rainbow_parentheses.vim'
Plug 'tomtom/tcomment_vim'
Plug 'godlygeek/tabular'
Plug 'ledger/vim-ledger'


" APPEARANCE
Plug 'itchyny/lightline.vim'
Plug 'altercation/vim-colors-solarized' " theme
Plug 'tomasr/molokai' " theme
Plug 'dracula/vim', { 'as': 'dracula' } " theme
Plug 'NLKNguyen/papercolor-theme' " theme by Goole
Plug 'safv12/andromeda.vim' " Darktheme from vscode
Plug 'junegunn/seoul256.vim' "🌳 Low-contrast Vim color scheme based on Seoul Colors
Plug 'nordtheme/vim'

" LANGUAGE FEATURE
Plug 'SirVer/ultisnips' " Ultimate snippet engine for Vim
Plug 'honza/vim-snippets' " Snippets library
Plug 'sheerun/vim-polyglot' " A solid language pack for Vim.
if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

" LINTER
Plug 'dense-analysis/ale' " Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP)

call plug#end()

filetype plugin indent on " You may do, after vim-plug

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" PLUGINS SETTINGS ********************************
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE

" Start NERDTree when Vim starts with a directory argument.
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists('s:std_in') |
    \ execute 'NERDTree' argv()[0] | wincmd p | enew | execute 'cd '.argv()[0] | endif

" Exit Vim if NERDTree is the only window remaining in the only tab.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" Close the tab if NERDTree is the only window remaining in it.
autocmd BufEnter * if winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() | quit | endif

" If another buffer tries to replace NERDTree, put it in the other window, and bring back NERDTree.
autocmd BufEnter * if bufname('#') =~ 'NERD_tree_\d\+' && bufname('%') !~ 'NERD_tree_\d\+' && winnr('$') > 1 |
    \ let buf=bufnr() | buffer# | execute "normal! \<C-W>w" | execute 'buffer'.buf | endif

" NERDTreeGit Configuration
let g:NERDTreeGitStatusIndicatorMapCustom = {
    \ 'Modified'  :'✹',
    \ 'Staged'    :'✚',
    \ 'Untracked' :'✭',
    \ 'Renamed'   :'➜',
    \ 'Unmerged'  :'═',
    \ 'Deleted'   :'✖',
    \ 'Dirty'     :'✗',
    \ 'Ignored'   :'☒',
    \ 'Clean'     :'✔︎',
    \ 'Unknown'   :'?', }
let NERDTreeShowLineNumbers=1

" STARTIFY
let g:startify_change_to_dir = 1
let g:startify_session_autoload    = 1
let g:startify_session_persistence = 1
let g:startify_bookmarks = [
            \ { 'c': '~/Sites/akademik-maqiis' },
            \ '~/Documents/mynotes/Pekerjaan/Almatuq/Maqiis/Laravel.md',
            \ '~/Documents/mynotes',
            \ '~/.zshrc',
            \ '~/.vim/plugged/vim-snippets/UltiSnips/blade.snippets',
            \ ]
let g:startify_lists = [
            \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
            \ { 'type': 'files',     'header': ['   Files']            },
            \ { 'type': 'dir',       'header': ['   Dir '. getcwd()] },
            \ { 'type': 'sessions',  'header': ['   Sessions']       },
            \ { 'type': 'commands',  'header': ['   Commands']       },
            \ ]
let g:startify_custom_header =
            \ startify#fortune#cowsay('', '═','║','╔','╗','╝','╚')

" INDENT
" set the indent for the first line after <script> and <style>
let g:html_indent_script1        = "inc"
let g:html_indent_style1         = "inc"
let g:html_indent_attribute      = 1
let g:indentLine_enabled         = 0 " 0 for disable, to enable type :IndentLinesEnable
let g:indentLine_char_list       = ['|', '¦', '┆', '┊']
let g:indentLine_color_term      = 239
let g:indentLine_color_gui       = '#A4E57E'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark      = 1 " (default: 2)

" VISUAL-MULTI
let g:VM_maps                    = {}
let g:VM_maps["Add Cursor Up"]   = '<C-k>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_maps["Exit"]            = '<C-c>'
let g:VM_mouse_mappings          = 1

" EMMET
" allow emmet in all mode
let g:user_emmet_mode = 'a'

" allow emmet for html and css only
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,blade EmmetInstall

" Snippet to add meta tag for responsiveness
let g:user_emmet_settings = {
\  'variables': {'lang': 'ja'},
\  'html': {
\    'default_attributes': {
\      'option': {'value': v:null},
\      'textarea': {'id': v:null, 'name': v:null, 'cols': 10, 'rows': 10},
\    },
\    'snippets': {
\      'html:5': "<!DOCTYPE html>\n"
\              ."<html lang=\"${lang}\">\n"
\              ."<head>\n"
\              ."\t<meta charset=\"${charset}\">\n"
\              ."\t<title></title>\n"
\              ."\t<meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
\              ."</head>\n"
\              ."<body>\n\t${child}|\n</body>\n"
\              ."</html>",
\	'pla': "placeholder=\"|\"",
\    },
\  },
\}

" TEX-CONCEAL
set conceallevel=2
let g:tex_conceal_frac = 1
let g:tex_superscripts = "[0-9a-zA-W.,:;+-<>/()          = ]"
let g:tex_subscripts   = "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal      = 'abdgm'

" MARKDOWNPREVIEW
let g:mkdp_auto_start         = 0
let g:mkdp_auto_close         = 1
let g:mkdp_refresh_slow       = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world  = 0
let g:mkdp_open_ip            = ''
let g:mkdp_browser            = '/Applications/Firefox.app'
let g:mkdp_echo_preview_url   = 0
let g:mkdp_browserfunc        = ''
let g:mkdp_preview_options    = {
    \ 'mkit':                 {},
    \ 'katex':                {},
    \ 'uml':                  {},
    \ 'maid':                 {},
    \ 'disable_sync_scroll':  0,
    \ 'sync_scroll_type':     'middle',
    \ 'hide_yaml_meta':       1,
    \ 'sequence_diagrams':    {},
    \ 'flowchart_diagrams':   {},
    \ 'content_editable':     v:false,
    \ 'disable_filename':     0
    \ }
let g:mkdp_markdown_css  = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port          = ''
let g:mkdp_page_title    = '${name}'
let g:mkdp_filetypes     = ['markdown']
" let g:mkdp_theme         = 'dark' " prefer default system
" Below markdown syntax extension, default by developer is off
let g:vim_markdown_math                 = 1
let g:vim_markdown_frontmatter          = 1
let g:vim_markdown_toml_frontmatter     = 1
let g:vim_markdown_json_frontmatter     = 1
let g:vim_markdown_strikethrough        = 1
let g:vim_markdown_autowrite            = 1
let g:vim_markdown_auto_insert_bullets  = 1 " turning it on can cause problem when wrapping
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_edit_url_in          = 'tab'

"LIGHTLINE
set laststatus=2
set noshowmode " hide default statusline
let g:lightline = {
            \ 'colorscheme': 'powerline',
            \ 'active': {
                \    'right': [
                \ ['customTime'],
                \ ['customFileType', 'customCursorPosition'],
                \ ['customFormatEncode']]
            \ },
            \ 'component': {
            \   'customFileType': '%Y',
            \   'customFormatEncode': '%{&fenc!=#""?&fenc:&enc}',
            \   'customCursorPosition': '%l:%c',
            \   'customTime': '%{strftime("%H:%M")}'
            \ },
\ }
" others : e plugged/lightline.vim/colorscheme.md

" GIT GUTTER
" :GitGutterDisable " make the default is disable (illegal setting)

" DEOPLETE
let g:deoplete#enable_at_startup = 1

" ALE
let g:ale_linters = {
\   'java': ['javac'],
\   'javascript': ['jshint'],
\   'typescript': ['eslint'],
\   'vim': ['vimls'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'typescript' : ['eslint'],
\   'php': ['php_cs_fixer'],
\}

let g:ale_fix_on_save = 1

" MATCHIT
if has('syntax') && has('eval') && &filetype == 'html'
    packadd! matchit
endif
" To use the matchit plugin after Vim has started, execute this command:
" packadd matchit
" The default is disabled, so if you feel Vim goes slow then disable matchit.

" EDITORCONFIG
" Similar to the matchit package.
if has('syntax') && has('eval')
    packadd! editorconfig
endif

" ULTISNIPS
" Trigger configuration. You need to change this to something other than <tab> if you use one of the following:
" - https://github.com/Valloric/YouCompleteMe
" - https://github.com/nvim-lua/completion-nvim
let g:UltiSnipsExpandTrigger="<CR>"
let g:UltiSnipsJumpForwardTrigger="<Tab>"
let g:UltiSnipsJumpBackwardTrigger="<S-Tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

" FZF VIM

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" PREFERENCES """""""""""""""""""""""""""""""""""""
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF SEARCH
set rtp+=/usr/local/opt/fzf

" CURSOR
set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
    \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
    \,sm:block-blinkwait175-blinkoff150-blinkon175
" Cursor shape for insert mode to bar shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" TERMINAL SETTING
if $TERM =~ '^\(rtmux\|xvt\|screen\|nsterm\|interix\|putty\)\(-.*\)\?$'
    " opening vim in non gui available environment
    set notermguicolors
" elseif $TERM =~ '^\(xterm\|vte\|gnome\|alacritty\)\(-.*\)\?$'
else
    " opening vim in gui available environment
    set termguicolors
endif

" COLORING
" You can see all the groups currently active with this command: > :so $VIMRUNTIME/syntax/hitest.vim
" Desc for every menu: > :hi highlight-groups
" List available color for Terminal UI (TUI): > :h cterm-colors
"" Comment text styling
hi Comment cterm=italic gui=italic ctermfg=DarkGray guifg=Gray
"" Popup menu
hi Pmenu ctermbg=DarkGreen

" COLORSCHEME
set background=dark " you have to put set bg before colo cmd
colorscheme retrobox
" LIGHT COLOR
" Blue (but set bg to dark, wkwk)
" delek
" morning(not too light, good for night shift)
" peachpuff
" shine(dont use)
" zellner
""""""""""""""""""""""""""""""
" DARK COLOR
" Andromeda
" DarkBlue
" desert
" elflord
" evening
" habamax
" industry
" koehler
" macvim (not too good for gitgutter)
" murphy (good in dark room)
" pablo
" ron
" slate (looks modern but light)
" sorbet (beautiful purple)
" torte
" molokai
" zaibatsu (more beautiful purple)

" AMBI COLOR
" lunaperche
" PaperColor
" quiet (no syntax)
" retrobox
" solarized
" wildcharm

" SEOUL256
" seoul256 (dark):
"   range:   233 (darkest) ~ 239 (lightest)
"   default: 237
" let g:seoul256_background = 237

" seoul256 (light):
"   range:   252 (darkest) ~ 256 (lightest)
"   default: 253
" let g:seoul256_light_background = 253

" TRANSPARENT
" GVIM cannot accept transparent background
if &term == 'win32' || &term == 'xterm-256color'
  hi Normal ctermfg=NONE ctermbg=NONE guibg=NONE
  hi NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE
endif

" MACVIM/GVIM
" FONT
if has('gui_macvim')
	set guifont=CaskaydiaCove\ Nerd\ Font\ Mono:h15
  set lines=30 columns=90
  set macligatures
  set macmeta
elseif has('gui_win32')
  set guifont=CaskaydiaMono\ NFM\:h10
endif

" BETTER RAINBOW PARENTHESES
let g:rbpt_colorpaird = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['black',       'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]
let g:rbpt_max = 16
let g:rbpt_loadcmd_toggle = 0
au VimEnter * RainbowParenthesesToggle
au Syntax * RainbowParenthesesLoadRound
au Syntax * RainbowParenthesesLoadSquare
au Syntax * RainbowParenthesesLoadBraces

" HTML, SQL INSIDE PHP HIGHLIGHTING
let php_htmlInStrings = 1
let php_sql_query = 1
let php_folding = 1
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAB
" nnoremap <Tab> gt
" nnoremap <S-Tab> gT
" nnoremap <silent> <S-t> :tabnew<CR>

" MAP CLEARING HIGHLIGHTING AFTER SEARCHING TO <ESC>
map <esc> :noh <CR> " Clearing highlight after searching every you click <esc>

" SCROLLING IN INSERT MODE
:inoremap <C-E> <C-X><C-E>
:inoremap <C-Y> <C-X><C-Y>

" SCROLLING FOR OTHER SPLIT WINDOWS (JUST 2 WINDOWS)
nmap <M-j> <c-w>w<c-e><c-w>wh " Scroll down one line other pane
nmap <M-k> <c-w>w<c-y><c-w>wh " Scroll up one line other pane
nmap <M-d> <c-w>w<c-d><c-w>wh " Scroll down half screen other pane
nmap <M-u> <c-w>w<c-u><c-w>wh " Scroll up half screen  other pane
nmap <M-f> <c-w>w<c-f><c-w>wh " Scroll down one screen other pane
nmap <M-b> <c-w>w<c-b><c-w>wh " Scroll up one screen other pane

" UNMAP CTRL-Z FOR :STOP then for save
" map <C-z> :w<CR> " now it's used by Emmet leader key
inoremap jk <Esc>

" AUTO-COMPLETE TRIGGER WITH TAB
" :imap <Tab> <C-X><C-V>
" :imap <S-Tab> <C-P>

" MAPLEADER
" ----------- START MAPLEADER SHORTCUT ---------------
" With a map leader it's possible to do extra key combinations like <leader>w saves the current file
let mapleader = " "

" FAST SAVING
nmap <leader>w :w!<CR>

" fast exit
nmap <leader>q :q<CR>

" SET WORKING DIRECTORY
nnoremap <leader>. :lcd %:p:h<CR>

" OPENS AN EDIT COMMAND WITH THE PATH OF THE CURRENTLY EDITED FILE FILLED IN
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>
noremap <Leader>E :tabe <C-R>=expand("%:p:h") . "/" <CR>

" OPENS A TAB EDIT COMMAND WITH THE PATH OF THE CURRENTLY EDITED FILE FILLED
" noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>
"
" TAB NAV
noremap <leader>a :tabN<CR>
noremap <leader>s :tabn<CR>

" BUFFER NAV
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

" CLOSE BUFFER
" noremap <leader>c :bd<CR> ga tau kenapa malah nutup satu aplikasi

" COMMENT TRIGGER
noremap <leader>/ :TComment<CR>

" FAST LINE DELETE
noremap <leader>k dd

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Go to Homepage
nnoremap <leader>h :Startify<CR>

noremap <F4> :IndentLinesToggle<CR>

nnoremap <Leader>t :NERDTreeToggle<CR>
nnoremap <Leader>y :NERDTreeFind<CR>

nnoremap <Leader>f :Files<CR>
nnoremap <Leader>r :History<CR>

nnoremap <Leader>p :Tagbar<CR>

" ----------- END MAPLEADER SHORTCUT ---------------

" COMMAND
" If you find you do not have permission to perform :w, you can make a command so :W invokes sudo:
command W w !sudo tee "%" > /dev/null

" redefining emmet key
let g:user_emmet_leader_key='<C-z>'

" BACKGROUND SWITCH DARK-LIGHT FROM SOLARIZED THEME
call togglebg#map("<F5>")
" nnoremap <F5> :let &bg=(&bg=='light'?'dark':'light')<cr>

" Twidle Case
function! TwiddleCase(str)
    if a:str ==# toupper(a:str)
        let result = tolower(a:str)
    elseif a:str ==# tolower(a:str)
        let result = substitute(a:str,'\(\<\w\+\>\)', '\u\1', 'g')
    else
        let result = toupper(a:str)
    endif
    return result
endfunction
vnoremap ~ y:call setreg('', TwiddleCase(@"), getregtype(''))<CR>gv""Pgv
" With the following (for example, in vimrc), you can visually select text
" then press ~ to convert the text to UPPER CASE, then to lower case, then to
" Title Case. Keep pressing ~ until you get the case you

" Close buffer without closing the window
function! CloseBuffer()
	if &modified
		echohl ErrorMsg
		echomsg "No write since last change. Not closing buffer."
		echohl NONE
	else
		let s:total_nr_buffers = len(filter(range(1, bufnr('$')), 'buflisted(v:val)'))

		if s:total_nr_buffers == 1
			bdelete
			echo "Buffer deleted. Created new buffer."
		else
			bprevious
			bdelete #
			echo "Buffer deleted."
		endif
	endif
endfunction
"
" ------ END MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" OTHER VIM's PREFERENCES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" " Create a custom header using figlet for welcome screen
" let g:startify_custom_header =
"             \ startify#pad(split(system('figlet -c VIM 2022'), '\n'))

" Use NERDTree bookmarks
let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

" function MyFoldText()
"     let line = getline(v:foldstart)
"     let sub = substitute(line, '/\*\|\*/\|{{{\d\=', '', 'g')
"     return v:folddashes .. sub
" endfunction

" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

set autoindent
set backspace=indent,eol,start
set cmdheight=1
set cursorline " Highlighting line where a cursor is
set encoding=utf-8
set exrc
set foldcolumn=1
set foldlevel=2
set foldmethod=indent
set guioptions-=T
set guioptions-=r
set guioptions-=R
set guioptions-=l
set guioptions-=L
set hlsearch
set history=500
set incsearch
set ignorecase smartcase
set lazyredraw
set linebreak
set magic
set mouse=nvi
set nobackup
set noexpandtab
set noswapfile
set nowb
set nowrap
set number relativenumber
set regexpengine=0
set scrolloff=8
set secure
set showmatch
set smartindent
set matchtime=2
set shiftwidth=4
set tabstop=4
set textwidth=80
" set synmaxcol=0 " zero will makes highligthing all line and slow down for
set noexpandtab
set wildmenu
set wildoptions=pum
syntax enable

" Return to last edit position when opening files (You want this!)
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
