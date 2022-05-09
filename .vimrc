"dein Scripts-----------------------------
if &compatible
  set nocompatible               " Be iMproved
endif

" Required:
set runtimepath+=/home/funera1/.config/nvim/dein/repos/github.com/Shougo/dein.vim

" Required:
call dein#begin('/home/funera1/.config/nvim/dein')

" プラグインリストを収めたTOMLファイル
" 予めTOMLファイルを用意しておく
let s:toml_dir = $HOME . '/.config/nvim/toml'
let s:toml     = s:toml_dir . '/dein.toml'
let s:lazy_toml     = s:toml_dir . '/dein_lazy.toml'

" TOMLを読み込み、キャッシュしておく
call dein#load_toml(s:toml,      {'lazy': 0})
call dein#load_toml(s:lazy_toml, {'lazy': 1})

" Let dein manage dein
" Required:
call dein#add('/home/funera1/.config/nvim/dein/repos/github.com/Shougo/dein.vim')

" Add or remove your plugins here like this:
"call dein#add('Shougo/neosnippet.vim')
"call dein#add('Shougo/neosnippet-snippets')

" Required:
call dein#end()

" Required:
filetype plugin indent on
syntax enable

" If you want to install not installed plugins on startup.
"if dein#check_install()
"  call dein#install()
"endif

"End dein Scripts-------------------------



" Set internal encoding of vim, not needed on neovim, since coc.nvim using some
" unicode characters in the file autoload/float.vim
set encoding=utf-8

" TextEdit might fail if hidden is not set.
set hidden

" Some servers have issues with backup files, see #649.
set nobackup
set nowritebackup

" Give more space for displaying messages.
set cmdheight=2

" Having longer updatetime (default is 4000 ms = 4 s) leads to noticeable
" delays and poor user experience.
set updatetime=300

" Don't pass messages to |ins-completion-menu|.
set shortmess+=c

" Always show the signcolumn, otherwise it would shift the text each time
" diagnostics appear/become resolved.
if has("nvim-0.5.0") || has("patch-8.1.1564")
  " Recently vim can merge signcolumn and number column into one
  set signcolumn=number
else
  set signcolumn=yes
endif

" Use tab for trigger completion with characters ahead and navigate.
" NOTE: Use command ':verbose imap <tab>' to make sure tab is not mapped by
" other plugin before putting this into your config.
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" Use <c-space> to trigger completion.
if has('nvim')
  inoremap <silent><expr> <c-space> coc#refresh()
else
  inoremap <silent><expr> <c-@> coc#refresh()
endif

" Make <CR> auto-select the first completion item and notify coc.nvim to
" format on enter, <cr> could be remapped by other vim plugin
inoremap <silent><expr> <cr> pumvisible() ? coc#_select_confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"

" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list.
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" GoTo code navigation.
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use <Leader>K to show documentation in preview window.
nnoremap <silent>  <Leader>k:call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  elseif (coc#rpc#ready())
    call CocActionAsync('doHover')
  else
    execute '!' . &keywordprg . " " . expand('<cword>')
  endif
endfunction

" Highlight the symbol and its references when holding the cursor.
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming.
nmap <leader>rn <Plug>(coc-rename)

" Formatting selected code.
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder.
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Applying codeAction to the selected region.
" Example: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap keys for applying codeAction to the current buffer.
nmap <leader>ac  <Plug>(coc-codeaction)
" Apply AutoFix to problem on the current line.
nmap <leader>qf  <Plug>(coc-fix-current)

" Run the Code Lens action on the current line.
nmap <leader>cl  <Plug>(coc-codelens-action)

" Map function and class text objects
" NOTE: Requires 'textDocument.documentSymbol' support from the language server.
xmap if <Plug>(coc-funcobj-i)
omap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap af <Plug>(coc-funcobj-a)
xmap ic <Plug>(coc-classobj-i)
omap ic <Plug>(coc-classobj-i)
xmap ac <Plug>(coc-classobj-a)
omap ac <Plug>(coc-classobj-a)

" Remap <C-f> and <C-b> for scroll float windows/popups.
if has('nvim-0.4.0') || has('patch-8.2.0750')
  nnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  nnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
  inoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(1)\<cr>" : "\<Right>"
  inoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? "\<c-r>=coc#float#scroll(0)\<cr>" : "\<Left>"
  vnoremap <silent><nowait><expr> <C-f> coc#float#has_scroll() ? coc#float#scroll(1) : "\<C-f>"
  vnoremap <silent><nowait><expr> <C-b> coc#float#has_scroll() ? coc#float#scroll(0) : "\<C-b>"
endif

" Use CTRL-S for selections ranges.
" Requires 'textDocument/selectionRange' support of language server.
nmap <silent> <C-s> <Plug>(coc-range-select)
xmap <silent> <C-s> <Plug>(coc-range-select)

" Add `:Format` command to format current buffer.
command! -nargs=0 Format :call CocActionAsync('format')

" Add `:Fold` command to fold current buffer.
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" Add `:OR` command for organize imports of the current buffer.
command! -nargs=0 OR   :call     CocActionAsync('runCommand', 'editor.action.organizeImport')

" Add (Neo)Vim's native statusline support.
" NOTE: Please see `:h coc-status` for integrations with external plugins that
" provide custom statusline: lightline.vim, vim-airline.
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Mappings for CoCList
" Show all diagnostics.
nnoremap <silent><nowait> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions.
nnoremap <silent><nowait> <space>e  :<C-u>CocList extensions<cr>
" Show commands.
nnoremap <silent><nowait> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document.
nnoremap <silent><nowait> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols.
nnoremap <silent><nowait> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent><nowait> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent><nowait> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list.
nnoremap <silent><nowait> <space>p  :<C-u>CocListResume<CR>


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
" Leader
let mapleader = "\<Space>"

set mouse=a
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
colorscheme elly
set termguicolors
set t_Co=256
"
"
" " Tab系
" " Tab文字を半角スペースにする
set expandtab
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
inoremap {<Enter> {}<ESC>i<Enter><ESC><S-o>

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


" coc
" [
"   {"text": "(e)dit", "value": "edit"}
"   {"text": "(n)ew", "value": "new"}
" ]
" NOTE: text must contains '()' to detect input and its must be 1 character
function! ChoseAction(actions) abort
  echo join(map(copy(a:actions), { _, v -> v.text }), ", ") .. ": "
  let result = getcharstr()
  let result = filter(a:actions, { _, v -> v.text =~# printf(".*\(%s\).*", result)})
  return len(result) ? result[0].value : ""
endfunction

function! CocJumpAction() abort
  let actions = [
        \ {"text": "(s)plit", "value": "split"},
        \ {"text": "(v)slit", "value": "vsplit"},
        \ {"text": "(t)ab", "value": "tabedit"},
        \ ]
  return ChoseAction(actions)
endfunction

nnoremap <silent> <C-t> :<C-u>call CocActionAsync('jumpDefinition', CocJumpAction())<CR>

" gh
let g:gh_token = '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'

" coc
" NOTE: text must contains '()' to detect input and its must be 1 character
function! ChoseAction(actions) abort
  echo join(map(copy(a:actions), { _, v -> v.text }), ", ") .. ": "
  let result = getcharstr()
  let result = filter(a:actions, { _, v -> v.text =~# printf(".*\(%s\).*", result)})
  return len(result) ? result[0].value : ""
endfunction

function! CocJumpAction() abort
  let actions = [
        \ {"text": "(s)plit", "value": "split"},
        \ {"text": "(v)slit", "value": "vsplit"},
        \ {"text": "(t)ab", "value": "tabedit"},
        \ ]
  return ChoseAction(actions)
endfunction

nnoremap <silent> <C-t> :<C-u>call CocActionAsync('jumpDefinition', CocJumpAction())<CR>

"" 全選択
nnoremap <Leader>a ggVG
nnoremap <Leader>b :echo "Good"<CR>
nnoremap <Leader>c <Home>

"" Fern
nnoremap <C-f> :Fern . -reveal=% -drawer -toggle -width=40<CR>

"" vimrc

"" comment out
nmap <C-_> <Plug>(caw:1:toggle)
vmap <C-_> <Plug>(caw:1:toggle)

set nowrap

function RUNCPP()
  let current_file_path = echo expand("%:p")
  echo system("runcpp-vim ".join(%:p))
  split
  e %:h/output.txt
  vsp
  e %:h/input.txt
endfunction

nnoremap <C-r> :call RUNCPP()<Enter>
nnoremap <C-q> :only<Enter>
