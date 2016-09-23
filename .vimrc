" avoid autocommand duplication when resourcing .vimrc
autocmd!

" Setting up Vundle - the vim plugin bundler
" From http://erikzaadi.com/2012/03/19/auto-installing-vundle-from-your-vimrc/
let shouldInstallBundles=0
let vundleReadmePath=expand('~/.vim/bundle/Vundle.vim/README.md')
if !filereadable(vundleReadmePath)
  echo "\nInstalling Vundle...\n"
  silent !git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  let shouldInstallBundles=1
endif
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" Plugin List
" ===========

Plugin 'VundleVim/Vundle.vim'
Plugin 'tpope/vim-sensible'

" Git
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'

" NERDTree
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'

" HTML
Plugin 'mattn/emmet-vim'

" CSS (and family)
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'rstacruz/vim-hyperstyle'

" JavaScript
Plugin 'mxw/vim-jsx'
Plugin 'isRuslan/vim-es6'
Plugin 'rstacruz/vim-closer'
Plugin 'flowtype/vim-flow'

" Jekyll
Plugin 'parkr/vim-jekyll'
" Coffeescript
Plugin 'kchmck/vim-coffee-script'

" JSON
Plugin 'tpope/vim-jdaddy'

" Markdown
Plugin 'shime/vim-livedown'

" Mustache
Plugin 'mustache/vim-mustache-handlebars'

" tmux
Plugin 'tmux-plugins/vim-tmux'
Plugin 'christoomey/vim-tmux-navigator'
" Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'sjl/vitality.vim'

" Games
Plugin 'vim-scripts/HJKL'

" Miscellaneous
" Plugin 'dasilvacontin/vim-airline'
Plugin 'open-browser.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'junegunn/goyo.vim'
Plugin 'blueyed/vim-diminactive'
Plugin 'Chiel92/vim-autoformat'
Plugin 'editorconfig/editorconfig-vim'

call vundle#end()
if shouldInstallBundles == 1
  echo "\nInstalling Bundles...\n"
  :BundleInstall
endif


" backup files dir
" if dir ends with //, swap filename will be built from absolute path
silent !mkdir ~/.backup > /dev/null 2>&1
set directory=~/.backup//

syntax enable " turn on syntax highlighting
colorscheme Tomorrow-Night-Blue

set nu " line numbers
filetype plugin indent on
let g:mustache_abbreviations = 1 " vim-mustache-handlebars abbreviations
" highlight column 80 with old vim support
" if exists('+colorcolumn')
"   set colorcolumn=80
" else
"   au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
" endif
let g:diminactive_enable_focus = 1 " enables vim pane dimmming
highlight ColorColumn ctermbg=17
highlight LineNr ctermfg=20
highlight LineNr ctermbg=18
let &colorcolumn=join(range(81,999),",")
au FocusGained * hi LineNr ctermfg=20

" fake vert split bar removal
set fillchars=""
hi VertSplit ctermbg=18

set showcmd " shows info about current command

" highlight whitespace
set listchars=tab:▒░,trail:▓
set list
set tabstop=4 " renders tabs with 4 char width

set statusline+=%f\  " tail of the filename
set statusline+=%{fugitive#statusline()} " add git branch to status line

" open a NERDTree automatically when vim starts up with no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

" Ctrl+C for yanking to clipboard
map <C-c> "+y<CR>

function! Incr()
  let a = line('.') - line("'<")
  let c = virtcol("'<")
  if a > 0
    execute 'normal! '.c.'|'.a."\<C-a>"
  endif
  normal `<
endfunction
vnoremap <C-a> :call Incr()<CR>

" window swapping with shift + direction
function! MarkWindowSwap()
    " marked window number
    let g:markedWinNum = winnr()
    let g:markedBufNum = bufnr("%")
endfunction

function! DoWindowSwap()
    let curWinNum = winnr()
    let curBufNum = bufnr("%")
    " Switch focus to marked window
    exe g:markedWinNum . "wincmd w"

    " Load current buffer on marked window
    exe 'hide buf' curBufNum

    " Switch focus to current window
    exe curWinNum . "wincmd w"

    " Load marked buffer on current window
    exe 'hide buf' g:markedBufNum
endfunction

nnoremap H :call MarkWindowSwap()<CR> <C-w>h :call DoWindowSwap()<CR>
nnoremap J :call MarkWindowSwap()<CR> <C-w>j :call DoWindowSwap()<CR>
nnoremap K :call MarkWindowSwap()<CR> <C-w>k :call DoWindowSwap()<CR>
nnoremap L :call MarkWindowSwap()<CR> <C-w>l :call DoWindowSwap()<CR>

" Ctrl+N for opening NERDtree
map <C-n> :NERDTreeToggle<CR>

" NERDTress File highlighting
function! NERDTreeHighlightFile(extension, fg, bg, guifg, guibg)
 exec 'autocmd filetype nerdtree highlight ' . a:extension .' ctermbg='. a:bg .' ctermfg='. a:fg .' guibg='. a:guibg .' guifg='. a:guifg
 exec 'autocmd filetype nerdtree syn match ' . a:extension .' #^\s\+.*'. a:extension .'$#'
endfunction

call NERDTreeHighlightFile('jade', 'green', 'none', 'green', '#151515')
call NERDTreeHighlightFile('ini', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('md', 'blue', 'none', '#3366FF', '#151515')
call NERDTreeHighlightFile('yml', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('config', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('conf', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('json', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('html', 'yellow', 'none', 'yellow', '#151515')
call NERDTreeHighlightFile('styl', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('css', 'cyan', 'none', 'cyan', '#151515')
call NERDTreeHighlightFile('coffee', 'Red', 'none', 'red', '#151515')
call NERDTreeHighlightFile('js', 'Red', 'none', '#ffa500', '#151515')
call NERDTreeHighlightFile('php', 'Magenta', 'none', '#ff00ff', '#151515')

set rtp+=~/.fzf

let mapleader = "-"

nnoremap <silent> <Leader>C :call fzf#run({
\   'source':
\     map(split(globpath(&rtp, "colors/*.vim"), "\n"),
\         "substitute(fnamemodify(v:val, ':t'), '\\..\\{-}$', '', '')"),
\   'sink':    'colo',
\   'options': '+m',
\   'left':    30
\ })<CR>

" Crosshair - Solarized Base2
hi CursorLine   gui=NONE guibg=#d7d7af
hi CursorLine   cterm=NONE ctermbg=7

" links CursorLine styles to CursorColumn
hi! link CursorColumn CursorLine

" toggle crosshair
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" open-brower.vim config
nmap <Leader>l <Plug>(openbrowser-open)

" jump to matching xml tag
runtime macros/matchit.vim

" search all matches
set hlsearch
set ignorecase " use \C for case-sensitive
set smartcase " auto-switch to case-sensitive if capital letters are used

nmap gm :LivedownToggle<CR>

nmap <Leader>s :so ~/.vimrc<CR>
