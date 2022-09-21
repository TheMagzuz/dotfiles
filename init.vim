" Specify a directory for plugins
call plug#begin('~/.vim/plugged')

" Autocompletion
Plug 'neoclide/coc.nvim', {'branch': 'release'}

" File tree
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'ryanoasis/vim-devicons'
Plug 'airblade/vim-gitgutter'

Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}

" Fuzzy file searching
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Status bar
Plug 'vim-airline/vim-airline'

" Snippets
Plug 'SirVer/ultisnips'

" LaTeX integration
Plug 'lervag/vimtex'

" Commenting
Plug 'scrooloose/nerdcommenter'

Plug 'tpope/vim-repeat'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-eunuch'

" Super fast HTML writing
Plug 'mattn/emmet-vim'

" TS Syntax
Plug 'HerringtonDarkholme/yats.vim'

" Godot autocompletion
Plug 'habamax/vim-godot'

Plug 'sheerun/vim-polyglot'

Plug 'chrisbra/unicode.vim'

Plug 'dracula/vim', {'as': 'dracula'}

" Initialize plugin system
call plug#end()

""" General

" Set colors to 256
set t_Co=256

set guifont=monospace

" Set the leader to ,
let mapleader = ','
let maplocalleader = ','

let g:python3_host_prog = '/usr/bin/python3'

set encoding=UTF-8
set rnu nu

" j/k will move virtual lines (lines that wrap)
noremap <silent> <expr> j (v:count == 0 ? 'gj' : 'j')
noremap <silent> <expr> k (v:count == 0 ? 'gk' : 'k')

" Use the system clipboard
" This will probably bite me in the ass at some point
set clipboard=unnamedplus

inoremap jk <ESC>

set smarttab
set cindent
set tabstop=2
set shiftwidth=2
" always uses spaces instead of tab characters
set expandtab
"
" from readme
" if hidden is not set, TextEdit might fail.
set hidden " Some servers have issues with backup files, see #649 set nobackup set nowritebackup " Better display for messages set cmdheight=2 " You will have bad experience for diagnostic messages when it's default 4000.
set updatetime=300

" don't give |ins-completion-menu| messages.
set shortmess+=c

" always show signcolumns
set signcolumn=yes

" set the title of the terminal
set title

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

""" Powerline

let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#tab_nr_type = 2
let g:airline#extensions#tabline#buffer_nr_show = 1

"" Coc
let g:coc_global_extensions = [
  \ 'coc-snippets',
  \ 'coc-pairs',
  \ 'coc-tsserver',
  \ 'coc-eslint',
  \ 'coc-prettier',
  \ 'coc-json',
  \ 'coc-omnisharp',
  \ ]
"
" Use <c-space> to trigger completion.
inoremap <silent><expr> <c-space> coc#refresh()

" Use <cr> to confirm completion, `<C-g>u` means break undo chain at current position.
" Coc only does snippet and additional edit on confirm.
inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

" Use `[g` and `]g` to navigate diagnostics
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)

" Remap keys for gotos
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nnoremap <silent> <leader>gi :<C-u>e ~/.config/nvim/init.vim<CR>

" Use K to show documentation in preview window
nnoremap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
  if (index(['vim','help'], &filetype) >= 0)
    execute 'h '.expand('<cword>')
  else
    call CocAction('doHover')
  endif
endfunction

" Remap for rename current word
nmap <F2> <Plug>(coc-rename)

" Remap for format selected region
xmap <leader>f  <Plug>(coc-format-selected)
nmap <leader>f  <Plug>(coc-format-selected)

" Close a help floating window.
nmap <silent> <c-[> <esc>:noh<cr><Plug>(coc-float-hide)

augroup mygroup
  autocmd!
  " Setup formatexpr specified filetype(s).
  autocmd FileType typescript,json setl formatexpr=CocAction('formatSelected')
  " Update signature help on jump placeholder
  autocmd User CocJumpPlaceholder call CocActionAsync('showSignatureHelp')
augroup end

" Remap for do codeAction of selected region, ex: `<leader>aap` for current paragraph
xmap <leader>a  <Plug>(coc-codeaction-selected)
nmap <leader>a  <Plug>(coc-codeaction-selected)

" Remap for do codeAction of current line
nmap <leader>ac  <Plug>(coc-codeaction)
" Fix autofix problem of current line
nmap <leader>qf  <Plug>(coc-fix-current)

" Create mappings for function text object, requires document symbols feature of languageserver.
xmap if <Plug>(coc-funcobj-i)
xmap af <Plug>(coc-funcobj-a)
omap if <Plug>(coc-funcobj-i)
omap af <Plug>(coc-funcobj-a)

" Use `:Format` to format current buffer
command! -nargs=0 Format :call CocAction('format')

" Use `:Fold` to fold current buffer
command! -nargs=? Fold :call     CocAction('fold', <f-args>)

" use `:OR` for organize import of current buffer
command! -nargs=0 OR   :call     CocAction('runCommand', 'editor.action.organizeImport')

" Add status line support, for integration with other plugin, checkout `:h coc-status`
set statusline^=%{coc#status()}%{get(b:,'coc_current_function','')}

" Using CocList
" Show all diagnostics
nnoremap <silent> <space>a  :<C-u>CocList diagnostics<cr>
" Manage extensions
nnoremap <silent> <space>e  :<C-u>CocList extensions<cr>
" Show commands
nnoremap <silent> <space>c  :<C-u>CocList commands<cr>
" Find symbol of current document
nnoremap <silent> <space>o  :<C-u>CocList outline<cr>
" Search workspace symbols
nnoremap <silent> <space>s  :<C-u>CocList -I symbols<cr>
" Do default action for next item.
nnoremap <silent> <space>j  :<C-u>CocNext<CR>
" Do default action for previous item.
nnoremap <silent> <space>k  :<C-u>CocPrev<CR>
" Resume latest coc list
nnoremap <silent> <space>p  :<C-u>CocListResume<CR>

""" Snippets

let g:UltiSnipsExpandTrigger="<leader><leader>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger="<c-k>"

""" NERDTree

nmap <C-n> :NERDTreeToggle<CR>
vmap ++ <plug>NERDCommenterToggle
nmap ++ <plug>NERDCommenterToggle

let g:NERDTreeGitStatusWithFlags = 1

let g:NERDTreeIgnore = ['^node_modules$']

" prettier command for coc
command! -nargs=0 Prettier :CocCommand prettier.formatFile

" fzf
let g:airline#extensions#fzf#enabled = 1
let g:airline#extensions#gina#enabled = 1
" Only list files included by git when fuzzy searching

let g:fzfCommand = 'git --git-dir=./.git ls-files -oc --exclude-standard'

function! RunFzf()
  call fzf#run({'soruce': g:fzfCommand, 'sink': 'e'})
endfunction


""" LaTeX

let g:vimtex_view_general_viewer = 'zathura'
" If there are errors in the LaTeX document, just show the error window,
" without focusing it
let g:vimtex_quickfix_mode=2

aug plaintexfiletype
  au!
  au FileType plaintex set filetype=tex
aug END

" Ignore spellcheck in certain latex enviroments
sy match texParencite "\\parencite{[^}]\{-}}"hs=s+11,he=e-1 containedin=texstatement contains=@NoSpell


""" Miscellaneous

" Buffer navigation
nnoremap <silent> <leader>, :<C-u>bp<CR>
nnoremap <silent> <leader>. :<C-u>bn<CR>

nnoremap <silent> <C-p> :FZF<CR>

nnoremap <silent> <leader>n :<C-u>noh<CR>

" Danish characters
inoremap <leader>ae æ
inoremap <leader>oe ø
inoremap <leader>aa å

" Spell check
nnoremap <silent> <leader>sda :<C-u>set spell spelllang=da<CR>
nnoremap <silent> <leader>sus :<C-u>set spell spelllang=en_US<CR>
nnoremap <silent> <leader>sdi :<C-u>set nospell<CR>

" Insert line above
inoremap <leader><CR> <ESC>O

" Insert and go to line below
inoremap <leader>d <ESC>o

" Format file
noremap <leader>d gg=G<C-o>

" Run program
nnoremap <leader>r <Cmd>w<CR><Cmd>make run<CR>

" Go into normal mode from the terminal
tnoremap <nowait> <leader><esc> <C-\><C-n>

lua << EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = { "rust" },
  highlight = {
    enable  = true,
  },
}
EOF


" Neovide only configuration
if exists("g:neovide")
  let g:neovide_refresh_rate=144
  let g:neovide_floating_blur_amount_x = 2.0
  let g:neovide_floating_blur_amount_y = 2.0
  colo dracula
else
  func! s:setup_pmenu_colors()
      hi Pmenu ctermbg=Black ctermfg=Gray
  endfunc

  hi Pmenu ctermbg=Black ctermfg=Gray
  aug colorscheme_coc_setup | au!
    au ColorScheme * call s:setup_pmenu_colors()
  aug END
endif
