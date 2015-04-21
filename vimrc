" TODO: learn about QuickRun

augroup MyAutoCmd
	autocmd!
augroup END

filetype off
filetype plugin indent off

if &compatible
	set nocompatible
endif

if has('vim_starting')
	if !isdirectory(expand('~/.vim/bundle/neobundle.vim/'))
		:call system('git clone git://github.com:Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
"		:call system('git clone https://github.com/Shougo/neobundle.vim ~/.vim/bundle/neobundle.vim')
	endif
	set runtimepath+=~/.vim/bundle/neobundle.vim
endif

" NeoBundle {{{
call neobundle#begin(expand('~/.vim/bundle/'))
NeoBundleFetch 'Shougo/neobundle.vim'
NeoBundle 'Shougo/vimproc', {
\	 'build': {
\		 'windows' : 'make -f make_mingw32.mak',
\		 'cygwin'  : 'make -f make_cygwin.mak',
\		 'mac'     : 'make -f make_mac.mak',
\		 'unix'    : 'make -f make_unix.mak'
\	 }
\ }
NeoBundleLazy 'Shougo/unite.vim', {
\	 'autoload': {
\		'commands' : ['Unite', 'UniteWithBufferDir']
\	 }
\ }
NeoBundle 'Shougo/neomru.vim', {
\	 'depends' : 'Shougo/unite.vim'
\ }
NeoBundleLazy 'Shougo/vimfiler.vim', {
\	 'depends'  : 'Shougo/unite.vim',
\	 'autoload' : {
\		 'commands' : [ 'VimFilerTab', 'VimFiler', 'VimFilerExplorer', 'VimFilerBufferDir' ] ,
\		 'mappings' : '<Plug>(vimfiler_switch)' ,
\		 'explorer' : 1
\	 }
\ }
NeoBundle 'Shougo/neocomplete.vim', {
\	 'depends'  : 'Shougo/vimproc',
\	 'autoload' : {
\		 'insert' : 1
\	 }
\ }

" VimShell {{{
NeoBundleLazy 'Shougo/vimshell', {
\	 'depends'  : 'Shougo/vimproc',
\	 'autoload' : {
\		 'commands' : [
\			 { 'name' : 'VimShell', 'complete' : 'customlist,vimshell#complete' },
\			 'VimShellExecute',
\			 'VimShellInteractive',
\			 'VimShellTerminal',
\			 'VimShellPop'
\		 ],
\		 'mappings' : '<Plug>(vimshell_switch)'
\	 }
\ }
nnoremap	<silent> vs :<C-u>VimShell<CR>
nnoremap	<silent> vp :<C-u>VimShellPop<CR>
" }}}

" QuickRun {{{
NeoBundle 'thinca/vim-quickrun'
nmap <Leader>r <Plug>(quickrun)
nnoremap	<expr><silent> <C-c> quickrun#is_running() ? quickrun#sweep_sessions() : "\<C-c>"
let g:quickrun_config = {
\ '_' : {
\		 'runner'                          : 'vimproc',
\		 'runner/vimproc/updatetime'       : 100,
\		 'outputter'                       : 'multi:buffer:quickfix',
\		 'outputter/buffer/split'          : ':botright 8sp',
\		 'outputter/buffer/close_on_empty' : 1,
\		 'outputter/error/success'         : 'buffer',
\		 'outputter/error/error'           : 'quickfix',
\		 'hook/time/enable'                : 1
\	 }
\ }
" }}}

" Caw {{{
NeoBundle 'tyru/caw.vim.git'
nmap <Leader>c <Plug>(caw:i:toggle)
vmap <Leader>c <Plug>(caw:i:toggle)
" }}}

NeoBundleLazy 'junegunn/vim-easy-align', {
\	 'autoload' : {
\		 'command'  : 'EasyAlign',
\		 'mappings' : '<Plug>(EasyAlign)'
\	 }
\ }

NeoBundleLazy 'davidhalter/jedi-vim', {
\	 'autoload' : {
\		 'filetypes' : [ 'python', 'python3' ]
\	 },
\	 'build' : {
\		'mac'  : 'pip install jedi',
\		'unix' : 'pip install jedi'
\	 }
\ }
let s:hooks = neobundle#get_hooks('jedi-vim')
function! s:hooks.on_source(bundle)
	let g:jedi#auto_vim_configuration = 0
	let g:jedi#popup_select_first = 0
	let g:jedi#rename_command = '<Leader>R'
	let g:jedi#documentation_command = '<Leader>D'
endfunction
autocmd FileType python setlocal omnifunc=jedi#completions
autocmd FileType python setlocal completeopt-=preview
let g:jedi#auto_vim_configuration = 0
if !exists('g:neocomplete#force_omni_input_patterns')
        let g:neocomplete#force_omni_input_patterns = {}
endif
let g:neocomplete#force_omni_input_patterns.python = '\h\w*\|[^. \t]\.\w*'

NeoBundle 'glidenote/memolist.vim'
NeoBundle 'tpope/vim-fugitive'
NeoBundleLazy 'lambdalisue/vim-gista', {
\	 'autoload': {
\		 'commands': ['Gista'],
\		 'mappings': '<Plug>(gista-',
\		 'unite_sources': 'gista'
\	 }
\ }
let g:gista#update_on_write         = 1
let g:gista#interactive_description = 0
NeoBundle 'tyru/open-browser.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'LeafCage/yankround.vim'
NeoBundle 'itchyny/lightline.vim'
NeoBundleLazy 'vim-jp/vimdoc-ja', {
\	'filetype' : 'help'
\ }
NeoBundle 'nathanaelkane/vim-indent-guides'
let g:indent_guides_enable_on_vim_startup=1
let g:indent_guides_start_level=2
let g:indent_guides_auto_colors=0
let g:indent_guides_guide_size = 1
autocmd VimEnter,Colorscheme * :hi IndentGuidesOdd  guibg=235 ctermbg=235
autocmd VimEnter,Colorscheme * :hi IndentGuidesEven guibg=235 ctermbg=235
NeoBundleLazy 'ujihisa/unite-colorscheme'
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
let g:gista#directory              = expand('~/.vim/etc/gista/')
let g:gista#token_directory        = expand('~/.vim/etc/gista/tokens')
" }}}

filetype plugin indent on
syntax enable
colorscheme jellybeans

autocmd MyAutoCmd QuickfixCmdPost make,grep,grepadd,vimgrep,python,python3 copen
autocmd MyAutoCmd FileType help,qf nnoremap <buffer> q <C-w>c

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
set encoding=utf-8
set t_Co=256
set mouse=a

" View
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


" Lightline {{{
let g:lightline = {
\	 'colorscheme' : 'jellybeans',
\	 'active'      : {
\		 'left'  : [ [ 'mode', 'paste' ], [ 'fugitive', 'filename' ] ],
\		 'right' : [ [ 'lineinfo' ], ['percent'], [ 'fileformat', 'fileencoding', 'filetype' ] ]
\	 },
\	 'component_function' : {
\		 'fugitive'     : 'MyFugitive',
\		 'filename'     : 'MyFilename',
\		 'fileformat'   : 'MyFileformat',
\		 'filetype'     : 'MyFiletype',
\		 'fileencoding' : 'MyFileencoding',
\		 'mode'         : 'MyMode'
\	 },
\	 'subseparator' : {
\		 'left'         : '|',
\		 'right'        : '|'
\	 }
\ }

function! MyModified()
	return &ft =~ 'help' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
	return &ft !~? 'help' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
	let fname = expand('%:t')
	return   &ft == 'vimfiler'   ? vimfiler#get_status_string() :
\			 &ft == 'unite'      ? unite#get_status_string() :
\			 &ft == 'vimshell'   ? vimshell#get_status_string() :
\			 ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
\			 ('' != fname        ? fname : '[No Name]') .
\			 ('' != MyModified() ? ' ' . MyModified() : '')
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
	return   &ft == 'unite'    ? 'Unite' :
\			 &ft == 'vimfiler' ? 'VimFiler' :
\			 &ft == 'vimshell' ? 'VimShell' :
\			 winwidth(0) > 60 ? lightline#mode() : ''
endfunction
" }}}

" Unite {{{
let g:unite_enable_start_insert        = 0
let g:unite_force_overwrite_statusline = 0
nnoremap	[unite] <Nop>
nmap		<Space>u [unite]
nnoremap	<silent> [unite]b :<C-u>Unite buffer<CR>
nnoremap	<silent> [unite]m :<C-u>Unite file_mru<CR>
nnoremap	<silent> [unite]f :<C-u>UniteWithBufferDir -buffer-name=files file<CR>
nnoremap	<silent> [unite]c :<C-u>Unite bookmark<CR>
nnoremap	<silent> [unite]a :<C-u>UniteBookmarkAdd<CR>
nnoremap	<silent> [unite]p :<C-u>Unite yankround<CR>
nnoremap	<silent> [unite]n :<C-u>Unite file/new<CR>
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
nnoremap	[memo] <Nop>
nmap		<Space>m [memo]
nnoremap	[memo]n  :MemoNew<CR>
nnoremap	[memo]l  :MemoList<CR>
" }}}

" Toggle options {{{
nnoremap [toggle] <Nop>
nmap		<Space>t [toggle]
nnoremap	<silent> [toggle]l :setlocal list!<CR>:setlocal list?<CR>
nnoremap	<silent> [toggle]n :setlocal number!<CR>:setlocal number?<CR>
nnoremap	<silent> [toggle]w :setlocal wrap!<CR>:setlocal wrap?<CR>
nnoremap	<silent> [toggle]e :<C-u>VimFilerBufferDir -split -simple -winwidth=30 -no-quit -toggle<CR>
nnoremap	<silent> [toggle]i :<C-u>IndentGuidesToggle<CR>
" }}}


" Key Mapping {{{
nnoremap	j gj
nnoremap	k gk
nnoremap	J 5j
nnoremap	K 5k
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

inoremap	<silent> jj <ESC>
inoremap	<C-d> <Delete>
inoremap	<C-j> <Down>
inoremap	<C-k> <Up>
inoremap	<C-h> <Left>
inoremap	<C-l> <Right>

vnoremap	j gj
vnoremap	k gk
vnoremap	gj j
vnoremap	gk k
vnoremap	<Tab> %
vnoremap	v $h

cnoremap <expr> / getcmdtype() == '/' ? '\/' : '/'
cnoremap <expr> ? getcmdtype() == '?' ? '\?' : '?'
" }}}
