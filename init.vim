call plug#begin('~/.config/nvim/autoload/plugged')
Plug 'sheerun/vim-polyglot'
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'junegunn/fzf', {'dir': '~/.fzf', 'do': './install --all'}
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'arcticicestudio/nord-vim'
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', {'do': 'GoUpdateBinaries'}
Plug 'buoto/gotests-vim'
Plug 'tpope/vim-dadbod'
Plug 'hdiniz/vim-gradle'
call plug#end()

source $HOME/.config/nvim/plug-config/coc.vim

colorscheme nord

syntax on
set number
set showcmd
set wildignore+=*/tmp,/*.so,*.swp,*.zip

filetype indent on
set laststatus=2

function! GitBranch()
    return system("git rev-parse --abbrev-ref HEAD 2>/dev/null |tr -d '\n'")
endfunction()

function! StatuslineGit()
    let l:branchname = GitBranch()
    return strlen(l:branchname) > 0?'  '.l:branchname.' ':''
endfunction

let g:airline_theme='nord'
let g:airline_powerline_fonts=1
set t_Co=256
set statusline=
set statusline+=%#PmenuSel#
set statusline+=$#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
set statusline+=%{StatuslineGit()}
set statusline+=%#LineNr#
set statusline+=\%f
set statusline+=%m\

" gotests
let g:gotests_bin='$HOME/go/bin/gotests'

let g:syntastic_always_populate_loc_list=1
let g:syntastic_auto_loc_list=1
let g:syntastic_check_on_open=1
let g:syntastic_check_on_wq=0

if has('nvim')
    inoremap <silent><expr> <c-space coc#refresh()
else
    inoremap <silent><expr> <c-@> coc#refresh()
endif

augroup python_files "PEP8 compliance
    autocmd FileType python setlocal textwidth=80
    autocmd FileType python match ErrorMsg '\%>80v.+'
    autocmd FileType python setlocal formatoptions-=t
augroup end

au! BufNewFile, BufReadPost *.{yaml, yml} set filetype=yaml foldmethod=indent
autocmd Filetype yaml setlocal textwidth=80 ts=2 sts=2 sw=2 expandtab

