set nocompatible
filetype off
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
"導入したいプラグインを列挙
Plugin 'airblade/vim-gitgutter'

Plugin 'w0rp/ale'

Plugin 'thinca/vim-quickrun'

Plugin 'vim-airline/vim-airline'
"callirline_theme = 'wombat'
set laststatus=2
let g:airline#extensions#branch#enabled = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#wordcount#enabled = 0
let g:airline#extensions#default#layout = [['a', 'b', 'c'], ['x', 'y', 'z']]
let g:airline_section_c = '%t'
let g:airline_section_x = '%{&filetype}'
let g:airline_section_z = '%3l:%2v %{airline#extensions#ale#get_warning()} %{airline#extensions#ale#get_error()}'
let g:airline#extensions#ale#error_symbol = ' '
let g:airline#extensions#ale#warning_symbol = ' '
let g:airline#extensions#default#section_truncate_width = {}
let g:airline#extensions#whitespace#enabled = 1

"vundle#end()
"filetype plugin indent on



"setting
"文字コードをUFT-8に設定
set fenc=utf-8
"" バックアップファイルを作らない
set nobackup
" スワップファイルを作らない
set noswapfile
" " 編集中のファイルが変更されたら自動で読み直す
set autoread
" " バッファが編集中でもその他のファイルを開けるように
set hidden
" " 入力中のコマンドをステータスに表示する
set showcmd
"
"
" " 見た目系
" " 行番号を表示
set number
 " 現在の行を強調表示
set cursorline
" " 行末の1文字先までカーソルを移動できるように
set virtualedit=onemore
" " インデントはスマートインデント
set smartindent
" " 括弧入力時の対応する括弧を表示
set showmatch
" " ステータスラインを常に表示
set laststatus=2
" " コマンドラインの補完
set wildmode=list:longest
" " 折り返し時に表示行単位での移動できるようにする
nnoremap j gj
nnoremap k gk
" シンタックスハイライトの有効化
syntax enable
syntax on
colorscheme molokai
set t_Co=256
"
"
" " Tab系
" " Tab文字を半角スペースにする
"set expandtab
" " 行頭以外のTab文字の表示幅（スペースいくつ分）
set tabstop=2
" " 行頭でのTab文字の表示幅
set shiftwidth=2
"
"
" " 検索系
" " 検索文字列入力時に順次対象文字列にヒットさせる
set incsearch
" " 検索時に最後まで行ったら最初に戻る
set wrapscan
" " 検索語をハイライト表示
set hlsearch
" " ESC連打でハイライト解除
nmap <Esc><Esc> :nohlsearch<CR><Esc>
"
set clipboard=unnamedplus
set belloff=all

"Esc->jj
inoremap <silent> jj <ESC>

"縦移動素早く
nnoremap <S-j> 5j
nnoremap <S-k> 5k

"括弧補完
inoremap {<Enter> {}<ESC>i<Enter><ESC>x<S-o>

"括弧の補完。次の文字が[空白, 何もない, ), ]]なら補完する。そうでないなら補完しない
function! BracketComplement(num) abort
	let LBASE = ["(", "[", "{"]
	let RBASE = [")", "]", "}"]
	let pos = col(".") - 1
	let str = getline(".")
	let tmpl = pos == 0 ? "" : str[:pos - 1]
	let tmpr = str[pos:]

	let out = ""
	let flg = 0
	let List = [' ', '']
	for c in List
		if tmpr[0] == c
			let flg = 1
		endif
	endfor
	if flg
		let tmpl = tmpl . LBASE[a:num] . RBASE[a:num]
	else
		let tmpl = tmpl . LBASE[a:num]
	endif
	let str = tmpl . tmpr
	call setline('.', str)
	call cursor(line("."), pos+2)
	return out
endfunction

"括弧から出る
function! BracketOut(num) abort
	let List = [')', ']', '}']
	let pos = col(".") - 1
	let str = getline(".")
	let tmpl = pos == 0 ? "" : str[:pos - 1]
	let tmpr = str[pos:]
	if str[pos] == List[a:num]
		call cursor(line("."), pos+2)
	else 
		let str = tmpl . List[a:num] . tmpr
		call setline('.', str)
		call cursor(line("."), pos+2)
	endif
	return ''
endfunction

"クオーテーションの操作
function! QuotationFunc(num) abort
	let LBASE = ['"', "'"]
	let RBASE = ['"', "'"]
	let pos = col(".") - 1
	let str = getline(".")
	let tmpl = pos == 0 ? "" : str[:pos - 1]
	let tmpr = str[pos:]
	if str[pos] == LBASE[a:num]
		call cursor(line("."), pos+2)
	else 
		let flg = 0
		let List = [' ', '', ')', ']']
		for c in List
			if tmpr[0] == c
				let flg = 1
			endif
		endfor
		if flg
			let tmpl = tmpl . LBASE[a:num] . RBASE[a:num]
		else
			let tmpl = tmpl . LBASE[a:num]
		endif
		let str = tmpl . tmpr
		call setline('.', str)
		call cursor(line("."), pos+2)
	endif
	return ""
endfunction
"括弧に割り当て
inoremap <silent> ( <C-r>=BracketComplement(0)<CR>
inoremap <silent> [ <C-r>=BracketComplement(1)<CR>
inoremap <silent> { <C-r>=BracketComplement(2)<CR>
inoremap <silent> ) <C-r>=BracketOut(0)<CR>
inoremap <silent> ] <C-r>=BracketOut(1)<CR>
inoremap <silent> } <C-r>=BracketOut(2)<CR>
inoremap <silent> " <C-r>=QuotationFunc(0)<CR>
inoremap <silent> ' <C-r>=QuotationFunc(1)<CR>

"対応する括弧を消す
function! DeleteParenthesesAdjoin() abort
	let pos = col(".") - 1
	let str = getline(".")
	let parentLList = ["(", "[", "{", "\'", "\""]
	let parentRList = [")", "]", "}", "\'", "\""]
	let cnt = 0

	let output = ""

	"カーソルが行末の場合
	if pos == strlen(str)
		return "\b"
	endif
	for c in parentLList
		"カーソルの左右が同種の括弧
		if str[pos-1] == c && str[pos] == parentRList[cnt]
			call cursor(line("."), pos + 2)
			let output = "\b"
			break
		endif
		let cnt += 1
	endfor
	return output."\b"
endfunction
"BackSpaceに割り当て
inoremap <silent> <BS> <C-r>=DeleteParenthesesAdjoin()<CR>

