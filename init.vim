" Set python3 bin
let g:python3_host_prog="/usr/bin/python3"

" Set leader key
let maplocalleader = ","

" For a useful :find
set path=.,**

" Remap keys
" Use Esc to exit terminal state (used by vim-jack-in)
tnoremap <Esc> <C-\><C-n>

" Use fd as escape, Spacemacs style
inoremap fd <esc>

nnoremap <F9> :b#<cr>

" Current line number and Relative line numbers
set number
set relativenumber

" Full color theme support for neovim
set termguicolors

" Configure vim completion
set wildmode=list:longest,full

" In netrw set tree view as the default view
let g:netrw_liststyle=3
" No history for netrw
let g:netrw_dirhistmax = 0

set nowrap
set tabstop=3 shiftwidth=3 expandtab

"""""""""""""""""""""""""""""""""""""""""
" vim-plug - manage plugins
"""""""""""""""""""""""""""""""""""""""""
" Saves plugins to ~/.local/share/nvim/plugged
call plug#begin(stdpath('data') . '/plugged')

Plug 'tpope/vim-commentary'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-repeat'
Plug 'tpope/vim-sensible'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-vinegar'
Plug 'tpope/vim-unimpaired'

" Interface to external formatter
Plug 'chiel92/vim-autoformat'

" shell formatting
Plug 'vim-scripts/Super-Shell-Indent'

" Python indentation
Plug 'vim-scripts/indentpython.vim'

"" Version control plugins
" https://github.com/airblade/vim-gitgutter
Plug 'airblade/vim-gitgutter'

" Searching in projects - ripgrep
" The bang version will try to download the prebuilt binary if cargo does not exist.
Plug 'liuchengxu/vim-clap', { 'do': ':Clap install-binary!' }

" Highlight yanked region
Plug 'machakann/vim-highlightedyank'

" Conjure
Plug 'Olical/conjure', {'tag': '*'}


"""""""""
" Conjure support - jack-in with nrepl dependencies

" Start a REPL from within Vim
Plug 'tpope/vim-dispatch'
Plug 'clojure-vim/vim-jack-in'
Plug 'radenling/vim-dispatch-neovim'

" Structural editing for lisp languages
Plug 'guns/vim-sexp'
Plug 'tpope/vim-sexp-mappings-for-regular-people'

" Auto-close parens
Plug 'LunarWatcher/auto-pairs', { 'tag': '*' }

" Completion support
Plug 'Shougo/deoplete.nvim'
Plug 'ncm2/float-preview.nvim'

" Linting with clj-kondo
Plug 'w0rp/ale'

"""""""""
" Themes

" https://github.com/dracula/vim
Plug 'dracula/vim', {'as': 'dracula'}

""""""
" Zettelkasteno

Plug 'vimwiki/vimwiki'
Plug 'junegunn/fzf'
Plug 'junegunn/fzf.vim'
Plug 'michal-h21/vim-zettel'

""""""

call plug#end()

"""""""""""""""""""""""""""""""""""""""""
" The end of plugins for vim-plug
"""""""""""""""""""""""""""""""""""""""""

"""""""""""""""""""""""""""""""""""""""""
" Plugin configuration
"""""""""""""""""""""""""""""""""""""""""

" for vim-gutter to refresh more frequently
set updatetime=100

" Search in project configuration
let g:clap_provider_grep_delay = 50
let g:clap_provider_grep_opts = '-H --no-heading --vimgrep --smart-case --hidden -g "!.git/"'

nnoremap <leader>*  :Clap grep ++query=<cword><cr>
nnoremap <leader>fg :Clap grep<cr>
nnoremap <leader>ff :Clap files --hidden<cr>
nnoremap <leader>fb :Clap buffers<cr>
nnoremap <leader>fw :Clap windows<cr>
nnoremap <leader>fr :Clap history<cr>
nnoremap <leader>fh :Clap command_history<cr>
nnoremap <leader>fj :Clap jumps<cr>
nnoremap <leader>fl :Clap blines<cr>
nnoremap <leader>fL :Clap lines<cr>
nnoremap <leader>ft :Clap filetypes<cr>
nnoremap <leader>fm :Clap marks<cr>


" Completion configuration
let g:deoplete#enable_at_startup = 1
call deoplete#custom#option('keyword_patterns', {'clojure': '[\w!$%&*+/:<=>?@\^_~\-\.#]*'})
set completeopt-=preview

let g:float_preview#docked = 0
let g:float_preview#max_width = 80
let g:float_preview#max_height = 40

" Lint configuration - clj-kondo
" clj-kondo should be installed on operating system path
let g:ale_linters = {
         \ 'clojure': ['clj-kondo'],
         \ 'python': ['mypy', 'pylint'],
         \}
nmap <silent> <C-k> <Plug>(ale_previous_wrap)
nmap <silent> <C-j> <Plug>(ale_next_wrap)
function! LinterStatus() abort
   let l:counts = ale#statusline#Count(bufnr(''))

   let l:all_errors = l:counts.error + l:counts.style_error
   let l:all_non_errors = l:counts.total - l:all_errors

   return l:counts.total == 0 ? 'OK' : printf(
            \   '%dW %dE',
            \   all_non_errors,
            \   all_errors
            \)
endfunction

" Set theme
set background=dark
autocmd vimenter * colorscheme dracula

" Add Fugitive and Linter info in status line
set statusline=%<%f\ %h%m%r%{FugitiveStatusline()}%=%-14.(%l,%c%V%)\ %P\ %{LinterStatus()}

" Format on save
let g:formatdef_zprint = '"zprint {:style :community :width 80} -w"'
let g:formatters_clojure = ['zprint']
autocmd BufWrite *.py,*.clj :Autoformat

" vimwiki
let g:vimwiki_list = [{'ext':'.md', 'syntax':'markdown'}]
let g:vimwiki_markdown_link_ext = 1

" vim-zettel
let g:zettel_fzf_command = "rg --column --line-number --ignore-case --no-heading --color=always"
augroup filetype_vimwiki
   autocmd!
   nnoremap <leader>zn :ZettelNew<space>
   nnoremap <leader>zo :ZettelOpen<space>
   nnoremap <leader>zs :ZettelSearch<space>
augroup END

" Emoji
ab :done: ✅

if &diff
   colorscheme default
endif
