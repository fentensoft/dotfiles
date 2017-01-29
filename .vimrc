" 定义快捷键的前缀，即 <Leader>
let mapleader=";"

" 开启文件类型侦测
filetype on
" 根据侦测到的不同类型加载对应的插件
filetype plugin on

" 设置快捷键将选中文本块复制至系统剪贴板
vnoremap <Leader>y "+y

" 设置快捷键将系统剪贴板内容粘贴至vim
nmap <Leader>p "+p

" 让配置变更立即生效
autocmd BufWritePost $MYVIMRC source $MYVIMRC

" 开启实时搜索功能
set incsearch
nnoremap <silent> <Leader>l :nohl<CR>
" 搜索时大小写不敏感
set ignorecase
set gcr=n-v-c:ver25-Cursor/lCursor,ve:ver35-Cursor,o:hor50-Cursor,i-ci:ver25-Cursor/lCursor
" 关闭兼容模式
set nocompatible

" vim 自身命令行模式智能补全
set wildmenu

call plug#begin('~/.vim/plugged')
Plug 'tomasr/molokai'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdcommenter'
Plug 'lilydjwg/fcitx.vim'
Plug 'scrooloose/nerdtree'
Plug 'ryanoasis/vim-devicons'
Plug 'vim-latex/vim-latex'
call plug#end()
filetype indent on
colorscheme molokai
let g:airline_theme='bubblegum'
let g:airline_powerline_fonts = 1

set laststatus=2
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
set guifont=DejaVu\ Sans\ Mono\ for\ Powerline\ 12
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

au BufReadPost * if line("'\"") > 0|if line("'\"") <= line("$")|exe("norm '\"")|else|exe "norm $"|endif|endif
