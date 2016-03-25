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
Plugin 'closetag.vim'
Plugin 'mattn/emmet-vim'

" CSS (and family)
Plugin 'cakebaker/scss-syntax.vim'

" JavaScript
Plugin 'isRuslan/vim-es6'

" Coffeescript
Plugin 'kchmck/vim-coffee-script'

" JSON
Plugin 'tpope/vim-jdaddy'

" Markdown
Plugin 'shime/vim-livedown'

" Mustache
Plugin 'mustache/vim-mustache-handlebars'

" Miscellaneous
Plugin 'dasilvacontin/vim-airline'
Plugin 'open-browser.vim'
Plugin 'altercation/vim-colors-solarized'
Plugin 'tpope/vim-sleuth'
Plugin 'tpope/vim-surround'
Plugin 'christoomey/vim-tmux-navigator'

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
if exists('+colorcolumn')
  set colorcolumn=80
else
  au BufWinEnter * let w:m2=matchadd('ErrorMsg', '\%>80v.\+', -1)
endif

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

:let mapleader = "-"

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

" close open xml tag
:au Filetype html,xml,xsl source ~/.vim/bundle/closetag.vim

" search all matches
:set hlsearch
set ignorecase " use \C for case-sensitive
set smartcase " auto-switch to case-sensitive if capital letters are used

nmap gm :LivedownToggle<CR>
