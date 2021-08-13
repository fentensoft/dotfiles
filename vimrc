"""""""""
" setup "
"""""""""
if !filereadable($HOME . "/.config/nvim/autoload/plug.vim")
  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall | source $MYVIMRC
endif

" 定义快捷键的前缀，即 <Leader>
let mapleader=";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y

command W w

" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p
nmap <C-V> "+P
imap <C-V> <ESC><C-V>i
vmap <C-C> "+y
" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch
nnoremap <silent> <Leader>l :nohl<CR>
" 搜索时大小写不敏感
set ignorecase
set gcr=n-v-c:block-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver10-Cursor/lCursor

" 关闭兼容模式
set nocompatible
set noshowmode

" vim 自身命令行模式智能补全
set wildmenu

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'itchyny/lightline.vim'
Plug 'scrooloose/nerdcommenter'
Plug 'lilydjwg/fcitx.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
"Plug 'lervag/vimtex'
"Plug 'neoclide/coc.nvim', {'branch': 'release'}
call plug#end()
filetype indent on
colorscheme molokai

set laststatus=2
set encoding=UTF-8
syntax on
" 开启行号显示
set number
" 高亮显示搜索结果
set hlsearch
" 禁止折行
" set nowrap
" 将制表符扩展为空格
set expandtab
" 设置编辑时制表符占用空格数
set tabstop=4
" 设置格式化时制表符占用空格数
set shiftwidth=4
" 让 vim 把连续数量的空格视为一个制表符
set softtabstop=4
set guifont=Fira\ Code\ 16
set smartindent
set autoindent
" 将外部命令 wmctrl 控制窗口最大化的命令行参数封装成一个 vim 的函数
fun! ToggleFullscreen()
    call system("wmctrl -ir " . v:windowid . " -b toggle,maximized_vert,maximized_horz")
endf
" 全屏开/关快捷键
map <silent> <F11> :call ToggleFullscreen()<CR>
"" 启动 vim 时自动全屏
autocmd VimEnter * call ToggleFullscreen()

" 禁止显示滚动条
set guioptions-=l
set guioptions-=L
set guioptions-=r
set guioptions-=R

" 禁止显示菜单和工具条
set guioptions-=m
set guioptions-=T

nmap <Leader>fl :NERDTreeToggle<CR>
" 设置 NERDTree 子窗口宽度
let NERDTreeWinSize=22
" 设置 NERDTree 子窗口位置
let NERDTreeWinPos="left"
" 显示隐藏文件
let NERDTreeShowHidden=1
" NERDTree 子窗口中不显示冗余帮助信息
let NERDTreeMinimalUI=1
" 删除文件时自动删除文件对应 buffer
let NERDTreeAutoDeleteBuffer=1

nmap <Leader>b :VimtexCompile<CR>

let g:lightline = {
            \ 'component_function': {
            \   'filetype': 'MyFiletype',
            \   'fileformat': 'MyFileformat',
            \ }
            \ }

function! MyFiletype()
    return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : 'no ft') : ''
endfunction

function! MyFileformat()
    return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif

if &term =~ '^rxvt\|xterm'
    " Solid vertical bar
    let &t_SI .= "\<Esc>[6 q"
    " Blink block
    let &t_EI .= "\<Esc>[1 q"
endif

