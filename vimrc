" INDEX
" ------ MUST FIRST CONFIGURATION ------
" VIM-PLUG (Minimalist VIM plugin manager)
" Macvim Conf
" 1. Vim's plugins configuration :
    " Provider (enhancing vim, used by completion)
    " Nerdtree (file explorer)
    " Indent
    " Visual-multi (selection)
    " Emmet (webdev plugin for highspeed coding and editing)
    " Vimtex (vim plugin for latex)
    " Tex-conceal (latex syntax rendering appearance inside code editor)
    " Markdownpreview
    " Lightline (status bar customization)
    " Git Gutter
    " ALE
" 2. Vim's preferences :
    " Fzf search
    " Background switch button
    " Cursor
    " Terminal setting
    " Coloring
    " Colorscheme
    " Transparent
    " Better rainbow parentheses
" 3. Mapping :
    " tab
    " Map clearing highlighting after searching to <esc>
    " Scrolling in insert mode
    " Scrolling for other split windows (just 2 windows)
    " Unmap ctrl-z for :stop
    " auto-complete trigger with tab
    " Mapleader
" 4. Other vim's preferences


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" ------ MUST FIRST CONFIGURATION ------
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MACVIM
if has('gui_running')
  set lines=30 columns=90
  if has('gui_gtk2')
    set guifont=Mocaco:h14
  elseif has('gui_macvim')
    set guifont=CaskaydiaCove\ Nerd\ Font\:h16
    set macligatures
    set macmeta
    set guioptions+=T
  elseif has('gui_win32')
    set guifont=Consolas:h10
  endif
endif

" required before run vim-plug
set nocompatible " Turn off compatible mode.
set nomodeline " Turn off modeline support.
filetype off " Required Firstly

" VIM-PLUG
call plug#begin('~/.vim/plugged')
 
" APP FEATURE
Plug 'mhinz/vim-startify' " welcome page
Plug 'scrooloose/nerdtree' " file explorer at side bar.
Plug 'Xuyuanp/nerdtree-git-plugin' " Git symbol at Nerd explorer

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
Plug 'preservim/vim-markdown'
Plug 'airblade/vim-gitgutter' " shows git diff markers in the sign column and stages/previews/undoes hunks & partial

" APPEARANCE
Plug 'itchyny/lightline.vim' 
Plug 'altercation/vim-colors-solarized' " theme
Plug 'tomasr/molokai' " theme
Plug 'dracula/vim', { 'as': 'dracula' } " theme
Plug 'NLKNguyen/papercolor-theme' " theme by Goole

" LINTER
Plug 'dense-analysis/ale' " Check syntax in Vim/Neovim asynchronously and fix files, with Language Server Protocol (LSP) 

call plug#end()

filetype plugin indent on " You may do, after vim-plug

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" PROVIDER
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" PYTHON for my mac
let g:python3_host_prog = '/Library/Frameworks/Python.framework/Versions/3.12/bin/python3'
let g:loaded_ruby_provider = 0 " RUBY
let g:loaded_node_provider = 0 " NODEJS
let g:loaded_perl_provider = 0 " PERL

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" PLUGINS SETTINGS
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" NERDTREE
nnoremap <C-t> :NERDTreeToggle<CR>

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

" INDENT
" set the indent for the first line after <script> and <style>
let g:html_indent_script1 = "inc"
let g:html_indent_style1 = "inc"
let g:html_indent_attribute = 1
let g:indentLine_enabled = 0 " 0 for disable, to enable type :IndentLinesEnable
let g:indentLine_char_list = ['¦', '┆', '┊']
let g:indentLine_color_term = 239
let g:indentLine_color_gui = '#A4E57E'
let g:indentLine_color_tty_light = 7 " (default: 4)
let g:indentLine_color_dark = 1 " (default: 2)

" VISUAL-MULTI
let g:VM_maps = {} 
let g:VM_maps["Add Cursor Up"]   = '<C-k>'
let g:VM_maps["Add Cursor Down"] = '<C-j>'
let g:VM_mouse_mappings = 1

" EMMET
" allow emmet in all mode
let g:user_emmet_mode='a'
 
" allow emmet for html and css only
let g:user_emmet_install_global = 0
autocmd FileType html,css EmmetInstall

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
\    },
\  },
\}

" TEX-CONCEAL
let g:tex_conceal_frac=1
let g:tex_superscripts= "[0-9a-zA-W.,:;+-<>/()=]"
let g:tex_subscripts= "[0-9aehijklmnoprstuvx,+-/().]"
let g:tex_conceal='abdgm'

" MARKDOWN
let g:mkdp_auto_start = 0
let g:mkdp_auto_close = 1
let g:mkdp_refresh_slow = 0
let g:mkdp_command_for_global = 0
let g:mkdp_open_to_the_world = 0
let g:mkdp_open_ip = ''
let g:mkdp_browser = '/Applications/Firefox.app'
let g:mkdp_echo_preview_url = 0
let g:mkdp_browserfunc = ''
let g:mkdp_preview_options = {
    \ 'mkit': {},
    \ 'katex': {},
    \ 'uml': {},
    \ 'maid': {},
    \ 'disable_sync_scroll': 0,
    \ 'sync_scroll_type': 'middle',
    \ 'hide_yaml_meta': 1,
    \ 'sequence_diagrams': {},
    \ 'flowchart_diagrams': {},
    \ 'content_editable': v:false,
    \ 'disable_filename': 0
    \ }
let g:mkdp_markdown_css = ''
let g:mkdp_highlight_css = ''
let g:mkdp_port = ''
let g:mkdp_page_title = '「${name}」'
let g:mkdp_filetypes = ['markdown']
let g:mkdp_theme = 'dark'
" Below markdown syntax extension, default by developer is off
let g:vim_markdown_math = 1
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_toml_frontmatter = 1
let g:vim_markdown_json_frontmatter = 1
let g:vim_markdown_strikethrough = 1
let g:vim_markdown_autowrite = 1
let g:vim_markdown_auto_insert_bullets = 1 " turning it on can cause problem when wrapping
let g:vim_markdown_new_list_item_indent = 0
let g:vim_markdown_edit_url_in = 'tab'

"LIGHTLINE
let g:lightline = {
            \ 'colorscheme': 'solarized',
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

" ALE
let g:ale_linters = {
\   'javascript': ['eslint'],
\   'vim': ['vimls'],
\} 

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" PREFERENCES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" FZF SEARCH
set rtp+=/usr/local/opt/fzf

" CURSOR
" set guicursor=n-v-c:block,i-ci-ve:ver25,r-cr:hor20,o:hor50
"     \,a:blinkwait700-blinkoff400-blinkon250-Cursor/lCursor
"     \,sm:block-blinkwait175-blinkoff150-blinkon175
set cursorline " Highlighting line where a cursor is
" Cursor shape for insert mode to bar shape
let &t_SI = "\e[6 q"
let &t_EI = "\e[2 q"

" TERMINAL SETTING
if $TERM =~ '^\(rtmux\|xvt\|screen\|nsterm\|interix\|putty\)\(-.*\)\?$'
    " opening vim in non gui available environment
    set notermguicolors
elseif $TERM =~ '^\(xterm\|vte\|gnome\|alacritty\)\(-.*\)\?$'
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
colorscheme molokai
" light color: zellner, peachpuff, shine(dont use),morning(not too light, good for night shift), delek, PaperColor 
" dark color:
" desert: is like molokai

" TRANSPARENT
hi Normal ctermfg=NONE ctermbg=NONE guibg=NONE 
hi NonText ctermbg=NONE guibg=NONE guifg=NONE ctermfg=NONE

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

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" MAPPING
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" TAB
nnoremap <Tab> gt
" nnoremap <S-Tab> gT
nnoremap <silent> <S-t> :tabnew<CR>

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
map <C-z> :w<CR>
inoremap jk <Esc>

" AUTO-COMPLETE TRIGGER WITH TAB
" :imap <Tab> <C-X><C-V>
" :imap <S-Tab> <C-P>

" MAPLEADER
" ------ start mapleader shortcut
let mapleader = "," " With a map leader it's possible to do extra key combinations like <leader>w saves the current file
" Fast saving
nmap <leader>w :w!<CR>

" Fast exit
nmap <leader>q :q<CR>

" SET WORKING DIRECTORY
nnoremap <leader>. :lcd %:p:h<CR>

" OPENS AN EDIT COMMAND WITH THE PATH OF THE CURRENTLY EDITED FILE FILLED IN
noremap <Leader>e :e <C-R>=expand("%:p:h") . "/" <CR>

" OPENS A TAB EDIT COMMAND WITH THE PATH OF THE CURRENTLY EDITED FILE FILLED
noremap <Leader>te :tabe <C-R>=expand("%:p:h") . "/" <CR>

" BUFFER NAV
noremap <leader>z :bp<CR>
noremap <leader>x :bn<CR>

" CLOSE BUFFER
noremap <leader>c :bd<CR>

" COMMENT TRIGGER
noremap <leader>/ :TComment<CR>

" FAST LINE DELETE
noremap <leader>k dd

" FAST SOURCING
noremap <leader>s :source<CR>

" Quickly insert an empty new line without entering insert mode
nnoremap <Leader>o o<Esc>
nnoremap <Leader>O O<Esc>

" Go to Homepage
nnoremap <leader>h :Startify<CR>

noremap <F5> :IndentLinesToggle<CR>

" redefining emmet key
let g:user_emmet_leader_key='<C-z>'

" BACKGROUND SWITCH DARK-LIGHT FROM SOLARIZED THEME
call togglebg#map("<F5>")

" ------ end mapleader shortcut
" ------ end mapping
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
"""""""""" OTHER VIM's PREFERENCES
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Set to auto read when a file is changed from the outside
set autoread
au FocusGained,BufEnter * checktime

" " Create a custom header using figlet for welcome screen
" let g:startify_custom_header =
"             \ startify#pad(split(system('figlet -c VIM 2022'), '\n'))

" Use NERDTree bookmarks
let g:startify_bookmarks = systemlist("cut -sd' ' -f 2- ~/.NERDTreeBookmarks")

syntax on
set backspace=indent,eol,start
set conceallevel=2
set laststatus=2
set expandtab
set foldcolumn=1
set hlsearch
set incsearch
set ignorecase smartcase
set lazyredraw
set mouse=nvi
set nobackup
set noshowmode
set noswapfile
set nowb
" set number relativenumber
set shiftwidth=4
" set signcolumn=off
set synmaxcol=120
" set updatetime=4000
set wrap
set wildmenu
