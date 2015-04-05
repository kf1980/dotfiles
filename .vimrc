" TODO: Use QuickRun

set nocompatible

" NeoBundle {{{
if has('vim_starting')
	if !isdirectory(expand('~/.vim/bundle/neobundle.vim/'))
		:call system('git clone git://githun.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
	\ 'build': {
		\ 'windows' : 'make -f make_mingw32.mak',
		\ 'cygwin'  : 'make -f make_cygwin.mak',
		\ 'mac'     : 'make -f make_mac.mak',
		\ 'unix'    : 'make -f make_unix.mak'
	\ }
\ }
NeoBundle 'Shougo/unite.vim'
NeoBundle 'Shougo/neomru.vim', {
	\ 'depends' : 'Shougo/unite.vim'
\ }
NeoBundleLazy 'Shougo/vimfiler.vim', {
	\ 'depends'  : 'Shougo/unite.vim',
	\ 'autoload' : {
		\ 'commands' : [ 'VimFilerTab', 'VimFiler', 'VimFilerExplorer', 'VimFilerBufferDir' ] ,
		\ 'mappings' : '<Plug>(vimfiler_switch)' ,
		\ 'explorer' : 1
	\ }
\ }
NeoBundleLazy 'Shougo/neocomplete.vim', {
	\ 'depends'  : 'Shougo/vimproc',
	\ 'autoload' : {
		\ 'insert' : 1
	\ }
\ }
NeoBundleLazy 'Shougo/vimshell', {
	\ 'depends'  : 'Shougo/vimproc',
	\ 'autoload' : {
		\ 'commands' : [
			\ { 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete' },
			\ 'VimShellExecute',
			\ 'VimShellInteractive',
			\ 'VimShellTerminal',
			\ 'VimShellPop'
		\ ],
		\ 'mappings' : '<Plug>(vimshell_switch)'
	\ }
\ }
NeoBundle 'Townk/vim-autoclose'
NeoBundleLazy 'thinca/vim-quickrun', {
	\ 'autoload' : {
		\ 'mappings' : [['n'],['\r']],
		\ 'commands' : 'QuickRun'
	\ }
\ }
NeoBundle 'tyru/caw.vim.git'
NeoBundleLazy 'junegunn/vim-easy-align', {
	\ 'autoload' : {
		\ 'command'  : 'EasyAlign',
		\ 'mappings' : '<Plug>(EasyAlign)'
	\ }
\ }
NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'vim-jp/vimdoc-ja'
NeoBundle 'ujihisa/unite-colorscheme'
NeoBundle 'nanotech/jellybeans.vim'
NeoBundle 'w0ng/vim-hybrid'
NeoBundleCheck
call neobundle#end()
" }}}

" Plugin data directories {{{
let g:unite_data_directory         = expand('~/.vim/etc/unite')
let g:neomru#file_mru_path         = expand('~/.vim/etc/neomru/file')
let g:neomru#directory_mru_path    = expand('~/.vim/etc/neomru/directory')
let g:vimfiler_data_directory      = expand('~/.vim/etc/vimfiler')
let g:vimshell_temporary_directory = expand('~/.vim/etc/vimshell')
let g:neocomplete#data_directory   = expand('~/.vim/etc/neocomplete')
let g:yankround_dir                = expand('~/.vim/etc/yankround')
let g:memolist_template_dir_path   = expand('~/.vim/etc/memolist/template')
let g:memolist_path                = expand('~/Documents/_memo')
" }}}

filetype plugin indent on
syntax enable
colorscheme jellybeans


" Global Settings {{{
" Misc
set hidden
set nobackup
set nowritebackup
set noswapfile
set t_vb=
set novisualbell
set noerrorbells
set backspace=indent,eol,start
set noshowmode
set clipboard=unnamed,autoselect

" Window
set number
set numberwidth=5
set ruler
set cursorline
set laststatus=2
set wrap
set textwidth=0

" Indent
set autoindent
set list
set listchars=eol:¬,tab:▸_
set tabstop=4
set shiftwidth=4
set shiftround
set nosmartindent
" set foldmethod=marker

" Brackets
set showmatch
set matchpairs& matchpairs+=<:>
set matchtime=2

" Search
set ignorecase
set smartcase
set incsearch
set hlsearch
" }}}

" vim-easy-align {{{
vmap <Enter> <Plug>(EasyAlign)
nmap <Leader>a <Plug>(EasyAlign)
" }}}

" neocomplete {{{
let g:neocomplete#enable_at_startup               = 1
let g:neocomplete#auto_completion_start_length    = 3
let g:neocomplete#enable_ignore_case              = 1
let g:neocomplete#enable_smart_case               = 1
let g:neocomplete#enable_camel_case               = 1
let g:neocomplete#use_vimproc                     = 1
let g:neocomplete#sources#buffer#cache_limit_size = 1000000
let g:neocomplete#sources#tags#cache_limit_size   = 30000000
let g:neocomplete#enable_fuzzy_completion         = 1
let g:neocomplete#lock_buffer_name_pattern        = '\*ku\*'
" }}}

" QuickRun {{{
nnoremap <expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
let g:quickrun_config = {
	\ '_' : {
		\ 'runner'                          : 'vimproc',
		\ 'runner/vimproc/updatetime'       : 100,
		\ 'outputter'                       : 'multi:buffer:quickfix',
		\ 'outputter/buffer/split'          : ':botright 8sp',
		\ 'outputter/buffer/close_on_empty' : 1,
		\ 'outputter/error/success'         : 'buffer',
		\ 'outputter/error/error'           : 'quickfix',
		\ 'hook/time/enable'                : 1
	\ }
\ }
" }}}

" Lightline {{{
let g:lightline = {
	\ 'colorscheme' : 'jellybeans',
	\ 'active'      : {
		\ 'left'  : [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
		\ 'right' : [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
	\ },
	\ 'component_function' : {
		\ 'fugitive'     : 'MyFugitive',
		\ 'filename'     : 'MyFilename',
		\ 'fileformat'   : 'MyFileformat',
		\ 'filetype'     : 'MyFiletype',
		\ 'fileencoding' : 'MyFileencoding',
		\ 'mode'         : 'MyMode'
	\ },
	\ 'subseparator' : {
		\ 'left'         : '|',
		\ 'right'        : '|'
	\ }
\ }

function! MyModified()
	return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
	return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
	let fname = expand('%:t')
	return &ft == 'vimfiler'   ? vimfiler#get_status_string() :
		\  &ft == 'unite'      ? unite#get_status_string() :
		\  &ft == 'vimshell'   ? vimshell#get_status_string() :
		\  ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
		\  ('' != fname        ? fname : '[No Name]') .
		\  ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyFugitive()
	try
		if expand('%:t') !~? 'Tagbar\|Gundo\|NERD' && &ft !~? 'vimfiler' && exists('*fugitive#head')
			let mark = ''  " edit here for cool mark
			let _    = fugitive#head()
			return strlen(_) ? mark._ : ''
		endif
	catch
	endtry
	return ''
endfunction

function! MyFileformat()
	return winwidth(0) > 70 ? &fileformat : ''
endfunction

function! MyFiletype()
	return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype : 'no ft') : ''
endfunction

function! MyFileencoding()
	return winwidth(0) > 70 ? (strlen(&fenc) ? &fenc : &enc) : ''
endfunction

function! MyMode()
	let fname = expand('%:t')
	return &ft == 'unite' ? 'Unite' :
		\  &ft == 'vimfiler' ? 'VimFiler' :
		\  &ft == 'vimshell' ? 'VimShell' :
		\  winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" Unite {{{
let g:unite_enable_start_insert        = 0	" 0:disable 1:enable
let g:unite_force_overwrite_statusline = 0
nnoremap	[unite] <Nop>
nmap		<Space>u [unite]
nnoremap	<silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap	<silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap	<silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap	<silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap	<silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap	<silent> [unite]p :<C-u>Unite yankround<CR>
" }}}

" Caw {{{
nmap		<Space>c <Plug>(caw:i:toggle)
vmap		<Space>c <Plug>(caw:i:toggle)
" }}}

" VimFiler {{{
let g:vimfiler_as_default_explorer        = 1	" 0:disable 1:enable
let g:vimfiler_safe_mode_by_default       = 1	" 0:disable 1:enable
let g:vimfiler_force_overwrite_statusline = 0
let g:vimfiler_tree_leaf_icon             = ' '
let g:vimfiler_tree_opened_icon           = '▾'
let g:vimfiler_tree_closed_icon           = '▸'
let g:vimfiler_file_icon                  = '-'
let g:vimfiler_marked_file_icon           = '*'
let g:vimfiler_readonly_file_icon         = 'X'
let g:vimfiler_ignore_pattern             = '^\%(\.git\|\.DS_Store\)$'
let g:vimfiler_enable_auto_cd             = 1
" }}}

" VimShell {{{
nnoremap <silent> vs :<C-u>VimShell<CR>
nnoremap <silent> vp :<C-u>VimShellPop<CR>
" }}}

" YankRound {{{
let g:yankround_max_history = 50
nmap		p <Plug>(yankround-p)
nmap		P <Plug>(yankround-P)
nmap		gp <Plug>(yankround-gp)
nmap		gP <Plug>(yankround-gP)
nmap		<C-p> <Plug>(yankround-prev)
nmap		<C-n> <Plug>(yankround-next)
" }}}

" Memolist {{{
let g:memolist_memo_suffix          = 'txt'
let g:memolist_memo_date            = '%Y-%m-%d'
let g:memolist_prompt_tags          = 0
let g:memolist_prompt_categories    = 0
let g:memolist_qfixgrep             = 1
let g:memolist_vimfiler             = 1
let g:memolist_vimfiler_option      = '-split -winwidth=30 -simple'
let g:memolist_unite                = 1
let g:memolist_unite_option         = '-auto-preview -start-insert'
let g:memolist_unite_source         = 'file_rec'
let g:memolist_filename_prefix_none = 1
nnoremap <Space>mn  :MemoNew<CR>
nnoremap <Space>ml  :MemoList<CR>
" }}}

" Toggle options {{{
nnoremap [toggle] <Nop>
nmap		<Space>t [toggle]
nnoremap	<silent> [toggle]l :setlocal list!<CR>:setlocal list?<CR>
nnoremap	<silent> [toggle]n :setlocal number!<CR>:setlocal number?<CR>
nnoremap	<silent> [toggle]w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap	<silent> [toggle]e :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit -toggle<CR>
" nnoremap	<silent> [toggle]f :setlocal 
" }}}


" Key Mapping {{{
nnoremap	j gj
nnoremap	k gk
nnoremap	gj j
nnoremap	gk k
nnoremap	G Gzz
nnoremap	gg ggzz
nnoremap	n nzz
nnoremap	N Nzz
nnoremap	# #zz
nnoremap	* *zz
nnoremap	g* g*zz
nnoremap	g# g#zz
nnoremap	<silent> <ESC><ESC> :<C-u>nohlsearch<CR>
nnoremap	<Space>h ^
nnoremap	<Space>l $
nnoremap	<Tab> %
nnoremap	Q <Nop>
nnoremap	s <Nop>
nnoremap	sj <C-w>j
nnoremap	sk <C-w>k
nnoremap	sh <C-w>h
nnoremap	sl <C-w>l
nnoremap	<S-Left> <C-w><<CR>
nnoremap	<S-Right> <C-w>><CR>
nnoremap	<S-Up> <C-w>-<CR>
nnoremap	<S-Down> <C-w>+<CR>
nnoremap	ss :<C-u>split<CR>
nnoremap	sv :<C-u>vsplit<CR>
nnoremap	sq :<C-u>quit<CR>
nnoremap	sQ :<C-u>bdelete<CR>
nnoremap	<C-h> :<C-u>help<Space><C-r><C-w><CR>
nnoremap	<Space>sh zM
nnoremap	<Space>sl zR

inoremap	<silent> jj <ESC>

vnoremap	j gj
vnoremap	k gk
vnoremap	gj j
vnoremap	gk k
vnoremap	<Tab> %
vnoremap	v $h
" }}}
