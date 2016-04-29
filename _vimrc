"++++++变量++++++
if has("win32")
	let $VIMFILES = $VIM.'/vimfiles'
	let $V = $VIM.'/_vimrc'
else
	let $VIMFILES = $HOME.'/.vim'
	let $V = $HOME.'/.vimrc'
endif
" 指定英文逗号作为<leader>键
"let mapleader=","
" autoload _vimrc
autocmd! bufwritepost _vimrc source %

au GUIEnter * simalt ~x "maximum the window when startup
""""""""""""""""""""""""""""""""""""
"           语言设置                "
""""""""""""""""""""""""""""""""""""
"set langmenu=zh_CN.UTF-8
language message zh_CN.UTF-8
" set guifont=Anonymous_Pro:h12
"set guifont=Monaco:h12
"set guifont=YaHei_Consolas_Hybrid:h12
"set guifont=Consolas\ for\ Powerline\ FixedD:h12
set guifont=Monaco\ for\ Powerline:h12,Inconsolata\ for\ Powerline:h14,Consolas:h12
"set guifont=Bitstream_Vera_Sans_Mono:h10:cANSI
"set gfw=Yahei_Mono:h10.5:cGB2312
set helplang=cn  "设置帮助文档为中文
source $VIMRUNTIME/vimrc_example.vim
"source $VIMRUNTIME/mswin.vim
behave mswin

"++++++++++++++++++++++++++++++
"winpos 20 20            "设置启动位置；
set lines=35 columns=150  "设置窗口大小，行X列；
color night               "ron            设置配色方案
"set relativenumber                   "设置相对行号
set ruler                 "打开状态栏标示
set cursorline            "突出显示当前行
filetype plugin indent on
syntax on
set hidden

"set guioptions-=m 
set guioptions-=T
"au GUIEnter * simalt ~x

"if has('gui_running') && has("win32")
    "map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>
""    map <F11> :!start GVimWindow.exe<CR>
"endif

if has('menu')
	let g:did_install_default_menus = 1
	set guioptions-=m
	set guioptions-=M
endif

if has('toolbar')
	set guioptions-=T
	set guioptions-=t
endif

set guioptions-=e

" right-hand scrollbar
set guioptions-=r
set guioptions-=R

" left-hand scrollbar
set guioptions-=l
set guioptions-=L
" bottom scrollbar
set guioptions-=b
"++++++编码+++++++
set encoding=utf-8
set fileencodings=utf-8,gbk,ucs-bom,gb2312,cp936,gb18030,utf-16,big5,latin1
set termencoding=chinese
set fileformats=unix
"set enc=utf-8  "设置内核为UTF-8
"set enc=prc
"设定默认编码
if has("win32")
"set fenc=gbk
    set fileencoding=chinese
else
	set fileencoding=utf-8
endif
set ambiwidth=double
set number
" 不要闪烁 
set novisualbell 
" 我的状态行显示的内容（包括文件类型和解码） 
set statusline=%F%m%r%h%w\[POS=%l,%v][%p%%]\%{strftime(\"%d/%m/%y\ -\ %H:%M\")} 
" 总是显示状态行 
set laststatus=2 
" 设定文件浏览器目录为当前目录
set bsdir=buffer
"set autochdir             "自动切换当前目录为当前文件所在的目录
" 不要使用Vi的键盘模式，而是vim自己的
set nocompatible          "关闭兼容模式
" 与windows共享剪贴板
set clipboard+=unnamed
" Set to auto read when a file is changed from the outside
set autoread

"高亮字符，让其不受100列的限制
highlight OverLength ctermbg=red ctermfg=white guibg=red guifg=white
match OverLength '\%101v.*'

" 状态行颜色
highlight StatusLine guifg=SlateBlue guibg=Yellow
highlight StatusLineNC guifg=Gray guibg=White


"用空格键来开关折叠（说明西方“"”后面的内容为注释，不会被VIM所识别）
"set foldenable
"set foldmethod=indent
"nnoremap <space> @=((foldclosed(line('.')) < 0) ? 'zc' : 'zo')<CR>

set wildmenu              " 增强模式中的命令行自动完成操作



""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" 输入:set list命令是应该显示些啥？ 
set listchars=tab:\|\ ,trail:.,extends:>,precedes:<,eol:$ 
" 光标移动到buffer的顶部和底部时保持3行距离 
set scrolloff=3 

""""""""""""""""""""""""""""""""""""
"         搜索和匹配               "
""""""""""""""""""""""""""""""""""""
" 高亮显示匹配的括号
set showmatch
" 匹配括号高亮的时间（单位是十分之一秒）
set matchtime=5
" 在搜索时忽略大小写
set ignorecase
" 不要高亮被搜索的句子（phrases）
" set nohlsearch
" 在搜索时，输入的词句的逐字高亮（类似firefox的搜索）
set incsearch

""""""""""""""""""""""""""""""""""""
"         文件格式和排版           "
""""""""""""""""""""""""""""""""""""
" 自动格式化
set formatoptions=tcrqn
" 继承前一行的缩进方式，特别适用于多行注释
set autoindent
" 为C程序提供自动缩进
set smartindent
" 使用C样式的缩进
set cindent
" 制表符为4
set tabstop=4
" 统一缩进为4
set softtabstop=4
set shiftwidth=4
" 用空格代替制表符
" set expandtab
" 不要用空格代替制表符
set noexpandtab
" 不要换行
set nowrap
" 在行和段开始处使用制表符
set smarttab

" 重启后撤销历史可用 persistent undo 
set undofile
set undodir=$VIMFILES/\_undodir
set undolevels=1000 "maximum number of changes that can be undone
set diffexpr=MyDiff()
function! MyDiff()
  let opt = '-a --binary '
  if &diffopt =~ 'icase' | let opt = opt . '-i ' | endif
  if &diffopt =~ 'iwhite' | let opt = opt . '-b ' | endif
  let arg1 = v:fname_in
  if arg1 =~ ' ' | let arg1 = '"' . arg1 . '"' | endif
  let arg2 = v:fname_new
  if arg2 =~ ' ' | let arg2 = '"' . arg2 . '"' | endif
  let arg3 = v:fname_out
  if arg3 =~ ' ' | let arg3 = '"' . arg3 . '"' | endif
  let eq = ''
  if $VIMRUNTIME =~ ' '
    if &sh =~ '\<cmd'
      let cmd = '""' . $VIMRUNTIME . '\diff"'
      let eq = '"'
    else
      let cmd = substitute($VIMRUNTIME, ' ', '" ', '') . '\diff"'
    endif
  else
    let cmd = $VIMRUNTIME . '\diff'
  endif
  silent execute '!' . cmd . ' ' . opt . arg1 . ' ' . arg2 . ' > ' . arg3 . eq
endfunction

":inoremap ( ()<ESC>i
":inoremap ) <c-r>=ClosePair(')')<CR>
":inoremap { {}<ESC>i
":inoremap } <c-r>=ClosePair('}')<CR>
":inoremap [ []<ESC>i
":inoremap ] <c-r>=ClosePair(']')<CR>
":inoremap < <><ESC>i
":inoremap > <c-r>=ClosePair('>')<CR>

"function! ClosePair(char)
"if getline('.')[col('.') - 1] == a:char
"return "\<Right>"
"else
"return a:char
"endif
"endf



"自动补全
set completeopt=longest,menu "自动补全命令时候使用菜单式匹配列表
set wildmenu

set ofu=syntaxcomplete#Complete
"set filetype=python
au BufNewFile,BufRead *.py,*.pyw setf python

"缩进
autocmd FileType pascal setlocal et sta sw=2 sts=2
autocmd FileType python setlocal et sta sw=4 sts=4
autocmd FileType c,cpp set shiftwidth=4 | set expandtab

"Pydiction
let g:pydiction_location = '$VIMFILES\ftplugin\complete-dict'

"php和python调试快捷键
let php = 'php.exe -l'
let luacom = 'lua.exe'
au FileType lua map <F5> :call DebugRun(luacom)<cr>
au FileType php map <F5> :call DebugRun(php)<cr>
au FileType php imap <F5> <Esc>:call DebugRun(php)<cr>
au FileType python map <F5> :call DebugRun('python')<cr>
au FileType python imap <F5> <Esc>:call DebugRun('python')<cr>
function! DebugRun(cmd)
    exec 'w'
    execute '!' . a:cmd . ' %'
endfunction

""""""""""""""""""""""""""""""""""""
"         全局热键设置               "
""""""""""""""""""""""""""""""""""""

"Tagbar
map <F8> :TagbarToggle<CR>
map <F9> :Calendar -view=year -split=vertical -width=27<CR>

"NERDTree
map <F10> :NERDTreeToggle<CR>
map <F11> :call libcallnr("gvimfullscreen.dll", "ToggleFullScreen", 0)<CR>

"window move motion
map <C-Left> <C-w>h
map <C-Right> <C-w>l
map <C-Up> <C-w>k
map <C-Down> <C-w>j


""""""""""""""""""""""""""""""""""""
"         第三方插件设置             "
""""""""""""""""""""""""""""""""""""
" airline
let g:airline_powerline_fonts=1
let g:airline#extensions#branch#enabled = 1
let g:airline#extension#syntastic#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#bufferline#enabled = 1
let g:airline#extensions#branch#use_vcscommand = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline_theme = 'powerlineish'

"let g:airline_mode_map = {
"      \ '__' : '-',
"      \ 'n'  : 'N',
"      \ 'i'  : 'I',
"      \ 'R'  : 'R',
"      \ 'c'  : 'C',
"      \ 'v'  : 'V',
"      \ 'V'  : 'V',
"      \ 's'  : 'S',
"      \ 'S'  : 'S',
"      \ }

" """""""""""""""""""""""""""""configuration for neocomplete""""""""""""""""""""""""""""
" Disable AutoComplPop.
let g:acp_enableAtStartup = 0
" Use neocomplete.
let g:neocomplete#enable_at_startup = 1
" Use smartcase.
let g:neocomplete#enable_smart_case = 1
" Set minimum syntax keyword length.
let g:neocomplete#sources#syntax#min_keyword_length = 3
let g:neocomplete#lock_buffer_name_pattern = '\*ku\*'

" Define keyword.
if !exists('g:neocomplete#keyword_patterns')
    let g:neocomplete#keyword_patterns = {}
endif
let g:neocomplete#keyword_patterns['default'] = '\h\w*'

" Plugin key-mappings.
inoremap <expr><C-g>     neocomplete#undo_completion()
inoremap <expr><C-l>     neocomplete#complete_common_string()

" Recommended key-mappings.
" <CR>: close popup and save indent.
inoremap <silent> <CR> <C-r>=<SID>my_cr_function()<CR>
function! s:my_cr_function()
  return neocomplete#close_popup() . "\<CR>"
  " For no inserting <CR> key.
  "return pumvisible() ? neocomplete#close_popup() : "\<CR>"
endfunction
" <TAB>: completion.
inoremap <expr><TAB>  pumvisible() ? "\<C-n>" : "\<TAB>"
" <C-h>, <BS>: close popup and delete backword char.
inoremap <expr><C-h> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> neocomplete#smart_close_popup()."\<C-h>"
inoremap <expr><C-y>  neocomplete#close_popup()
inoremap <expr><C-e>  neocomplete#cancel_popup()
" Close popup by <Space>.
"inoremap <expr><Space> pumvisible() ? neocomplete#close_popup() : "\<Space>"

" For cursor moving in insert mode(Not recommended)
"inoremap <expr><Left>  neocomplete#close_popup() . "\<Left>"
"inoremap <expr><Right> neocomplete#close_popup() . "\<Right>"
"inoremap <expr><Up>    neocomplete#close_popup() . "\<Up>"
"inoremap <expr><Down>  neocomplete#close_popup() . "\<Down>"
" Or set this.
"let g:neocomplete#enable_cursor_hold_i = 1
" Or set this.
"let g:neocomplete#enable_insert_char_pre = 1

" AutoComplPop like behavior.
"let g:neocomplete#enable_auto_select = 1

" Shell like behavior(not recommended).
"set completeopt+=longest
"let g:neocomplete#enable_auto_select = 1
"let g:neocomplete#disable_auto_complete = 1
"inoremap <expr><TAB>  pumvisible() ? "\<Down>" : "\<C-x>\<C-u>"

" Enable omni completion.
autocmd FileType css setlocal omnifunc=csscomplete#CompleteCSS
autocmd FileType html,markdown setlocal omnifunc=htmlcomplete#CompleteTags
autocmd FileType javascript setlocal omnifunc=javascriptcomplete#CompleteJS
autocmd FileType python setlocal omnifunc=pythoncomplete#Complete
autocmd FileType xml setlocal omnifunc=xmlcomplete#CompleteTags
autocmd FileType ruby,eruby setlocal omnifunc=rubycomplete#Complete
autocmd FileType java setlocal omnifunc=javacomplete#Complet

" Enable heavy omni completion.
if !exists('g:neocomplete#sources#omni#input_patterns')
  let g:neocomplete#sources#omni#input_patterns = {}
endif
"let g:neocomplete#sources#omni#input_patterns.php = '[^. \t]->\h\w*\|\h\w*::'
"let g:neocomplete#sources#omni#input_patterns.c = '[^.[:digit:] *\t]\%(\.\|->\)'
"let g:neocomplete#sources#omni#input_patterns.cpp = '[^.[:digit:] *\t]\%(\.\|->\)\|\h\w*::'

" For perlomni.vim setting.
" https://github.com/c9s/perlomni.vim
let g:neocomplete#sources#omni#input_patterns.perl = '\h\w*->\h\w*\|\h\w*::'
" """""""""""""""""""""""""""""configuration for neocomplcache""""""""""""""""""""""""""""

"vimwiki-plugin 设置
""""""""""""""""""""""
"F4 当前页生成HTML,shift + F4 全部页面生成HTML
map <S-F4> :VimwikiAll2HTML<CR>
map <F4>   :Vimwiki2HTML<CR>
"对于中文用户来说, 并不需要驼峰英文成为维基词条
let g:vimwiki_camel_case = 0
"标记未完成的 checklist 项目会有特别的颜色
let g:vimwiki_hl_cb_checked = 1
"我的VIM 是没有菜单的, 加一个 vimwiki 菜单项也没有意义
"let g:vimwiki_menu = ''
"是否开启语法折叠 会让文件比较慢
"let g:vimwiki_folding = 1
"是否在计算字串长度时特别考虑中文字符
let g:vimwiki_CJK_length = 1
"设置在 wiki 内使用的 html 标示....
let g:vimwiki_valid_html_tags = 'b, i, s, u, sub, kdb, del, br, hr, div, code, red, center, left, right, h4, h5, h6, hl'
"启用鼠标
let g:vimwiki_use_mouse = 1
let g:vimwiki_list = [{'path':  '$VIM/vimwiki/',
\ 'path_html':  '$VIM/vimwiki/html/',
\ 'template_path':  '$VIM/vimwiki/template/',
\ 'template_default':  'default',
\ 'template_ext':  '.html',
\ 'css_name':  'style.css',
\ 'diary_link_count': 6}]
"let g:vimwiki_nested_syntaxes =  {'python': 'python', 'c++': 'cpp'}
"let wiki = {}
"let wiki.nested_syntaxes = {'python': 'python', 'c++': 'cpp'}
"let g:vimwiki_list = [wiki]
"let g:vimwiki_w32_dir_enc = 'cp1251'
"删除当前页
map <leader>dd <plug>VimwikiDeleteLink
map <leader>rr <plug>VimwikiRenameLink
map <leader>tt <Plug>VimwikiToggleListItem

"vimim 输入法设置"""""""""""""""""""""""""""""""""""""""""""""
"let g:vimim_cloud='baidu'
"let g:vimim_map='ctrl6,ctrl_bslash,search,gi'

" 语法模板，由:LoadTemplate呼出
let g:template_path=$VIM.'\template\'
"""""""""""""""""""""""""设置日历calendar"""""""""""""""""""""""
let g:calendar_monday = 1 "以星期一为开始
let g:calendar_focus_today = 1 "光标在当天的日期上
"let g:calendat_mark = 'left-fit' "可以让*和数字靠近

"设置minibuf
let g:miniBufExplMapWindowNavVim = 1
let g:miniBufExplMapWindowNavArrows = 1
let g:miniBufExplMapCTabSwitchBufs = 1
let g:miniBufExplModSelTarget = 1
"let g:miniBufExplorerMoreThanOne = 2
"let g:miniBufExplUseSingleClick = 1
"let g:miniBufExplVSplit = 25
"let g:miniBufExplSplitBelow=1

"设置 winmanager
let g:winManagerWindowLayout='FileExplorer|BufExplorer'  " 这里可以设置为多个窗口, 如'FileExplorer|BufExplorer|TagList'
let g:persistentBehaviour=0             " 只剩一个窗口时, 退出vim.
let g:winManagerWidth=20
let g:defaultExplorer=1
nmap <silent> <leader>fir :FirstExplorerWindow<cr>
nmap <silent> <leader>bot :BottomExplorerWindow<cr>
nmap <silent> <leader>wm :WMToggle<cr>

" CtrlP
let s:ctrlp_fallback = 'ag --nocolor -l -g %s ""'
let g:ctrlp_working_path_mode='ra'
let g:ctrlp_show_hidden=1
let g:ctrlp_mruf_save_on_update=1
let g:ctrlp_use_caching = 1
"let g:ctrlp_user_command = {
"            \ 'fallback': s:ctrlp_fallback
"			\ }
