set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

Plugin 'VundleVim/Vundle.vim'
Plugin 'cakebaker/scss-syntax.vim'
Plugin 'mattn/emmet-vim'
Plugin 'open-browser.vim'
Plugin 'closetag.vim'
" Plugin 'JamshedVesuna/vim-markdown-preview'
Plugin 'shime/vim-livedown'

call vundle#end()
filetype plugin indent on

execute pathogen#infect()

" backup files dir
" if dir ends with //, swap filename will be built from absolute path
set directory=~/.backup//

syntax enable " turn on syntax highlighting
set background=dark
colorscheme solarized

set nu " line numbers
set colorcolumn=80 " highlight column 80
filetype plugin indent on
let g:mustache_abbreviations = 1 " vim-mustache-handlebars abbreviations

set showcmd " shows info about current command

" highlight whitespace
set listchars=tab:▒░,trail:▓
set list

set statusline+=%f\  " tail of the filename
set statusline+=%{fugitive#statusline()} " add git branch to status line

" open a NERDTree automatically when vim starts up with no files specified
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif

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

" Crosshair
hi CursorLine   cterm=NONE ctermbg=235
hi CursorColumn cterm=NONE ctermbg=235
nnoremap <Leader>c :set cursorline! cursorcolumn!<CR>

" open-brower.vim config
nmap <Leader>l <Plug>(openbrowser-open) 

" jump to matching xml tag
runtime macros/matchit.vim

" close open xml tag
:au Filetype html,xml,xsl source ~/.vim/bundle/closetag.vim

" search all matches
:set hlsearch

" vim-markdown-preview
" let vim_markdown_preview_toggle=2
" let vim_markdown_preview_hotkey='<C-m>'
" let vim_markdown_preview_browser='Google Chrome'
" let vim_markdown_preview_github=1

nmap gm :LivedownToggle<CR>
