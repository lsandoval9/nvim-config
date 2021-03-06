" vim:fdm=marker et ft=vim sts=2 sw=2 ts=2
scriptencoding utf-8

" Automatically download vim-plug, if not present
if !filereadable(expand($HOME.'/nvim/autoload/plug.vim'))
  echo 'vim-plug not installed, downloading'
  !curl -fLo "$HOME/nvim/autoload/plug.vim" --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  echo 'vim-plug downloaded, will install plugins once vim loads'
  augroup VimPlugInstall
    autocmd!
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
  augroup END
else
  " Clear out install on enter
  augroup VimPlugInstall
    autocmd!
  augroup END
endif

" Read ~/.vimrc as well
if filereadable(expand($HOME.'/.vimrc'))
  source $HOME/.vimrc
endif

" Plugins {{{
call plug#begin('~/.config/nvim/plugged')

" Colors {{{
" A bunch of Base16 colorschemes
Plug 'chriskempson/base16-vim'
" Shades indent levels
Plug 'nathanaelkane/vim-indent-guides'
" }}}

" System {{{
" `modeline` without the security concerns
Plug 'ciaranm/securemodelines'

" Editing {{{
" Accent autocompletion via gx in normal mode
Plug 'airblade/vim-accent'
" status bar for vim
Plug 'vim-airline/vim-airline'
" Smarter matchit, extends `%`
" % / g% forward/backwards to next matching open/close word
" [% / ]% go to prev/next surrounding word
" z% go into nearest inner contained block
" a% & i% text objects
" ds% / cs% to delete/change surrounding
" Can also do parallel editing of matches on tags
Plug 'andymass/vim-matchup'
" <leader>nr open visual selection in sep window
Plug 'chrisbra/NrrwRgn'
" Auto-close parens / quotes, requires no config
Plug 'cohama/lexima.vim'
" Shared project settings
Plug 'editorconfig/editorconfig-vim'
" adds linting to vim
Plug 'dense-analysis/ale'
" Personal snippets
Plug 'fortes/vim-personal-snippets'
" Make it easier to find the cursor after searching
Plug 'inside/vim-search-pulse'
" OneDark color theme for VIM
Plug 'joshdick/onedark.vim' 
" Motion via two-character combinations
" s{char}{char} to move forward to instance of {char}{char}
" ; for next match
" <c-o> or `` to go back to starting point
" s<CR> to repeat last search
" S to search backwards
" For text objects, use z (s taken by surround.vim)
" {action}z{char}{char}
Plug 'justinmk/vim-sneak'
" Snippet support, see configuration below
Plug 'SirVer/ultisnips'
" Fade inactive buffers
Plug 'TaDaa/vimade'
" Prettier formatter for vim
Plug 'prettier/vim-prettier', {
  \ 'do': 'yarn install',
  \ 'for': ['javascript', 'typescript', 'css', 'less', 'scss', 'json', 'graphql', 'markdown', 'vue', 'yaml', 'html'] }
" Set `path` for various file types
" TODO: Learn more about this config
Plug 'tpope/vim-apathy'
" Comment / uncomment things quickly
" {Visual}gc comment / uncomment selection
" - gc{motion} comment / uncomment lines for motion
Plug 'tpope/vim-commentary'
" Debugger for vim
Plug 'idanarye/vim-vebugger' 
" Make plugin actions for a few plugins repeatable
Plug 'tpope/vim-repeat'
" Readline-style keybindings everywhere (e.g. <C-a> for beginning of line)
Plug 'tpope/vim-rsi'
" Snippets support for vim
Plug 'SirVer/ultisnips' 
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-b>"
let g:UltiSnipsJumpBackwardTrigger="<c-z>"
" Edit surrounding quotes / parents / etc
" - {Visual}S<arg> surrounds selection
" - cs/ds<arg1><arg2> change / delete
" - ys<obj><arg> surrounds text object
" - yss<arg> for entire line
Plug 'tpope/vim-surround'
" file explorer for vim
Plug 'preservim/nerdtree'
" Icons for nerdtree
Plug 'ryanoasis/vim-devicons'
" Highligth open files in nerdtree
Plug 'PhilRunninger/nerdtree-buffer-ops'
" Extra motion commands, including:
" - [f, ]f next/prev file in directory
" - [n, ]n next/prev SCM conflict
" Toggles a few options:
" - coh hlsearch
" - con number
" - cos spell
" - cow wrap
" Additonal paste options
" - >p paste and indent
" - <p paste and deindent
Plug 'tpope/vim-unimpaired'
" Replace object with register contents
" gr{motion} Replace w/ unnamed register
" "xgr{motion} Replace w/ register x
Plug 'vim-scripts/ReplaceWithRegister'
" Complete words from tmux with <C-x><C-u>
" Plug 'wellle/tmux-complete.vim'
" }}}

" File/Buffer Hbndling {{{
" Use FZF for fuzzy finding
if filereadable('/usr/share/doc/fzf/examples/fzf.vim')
  " Use locally-installed FZF plugin
  Plug '/usr/share/doc/fzf/examples'
  Plug 'junegunn/fzf.vim'
end
" Show register contents when using " or @ in normal mode
" Also shows when hitting <c-r> in insert mode
Plug 'junegunn/vim-peekaboo'
" Unobtrusive scratch window
" gs to open scratch window (works w/ selection)
" :Scratch opens blank scratch window
Plug 'mtth/scratch.vim'
" Adds helpers for UNIX shell commands
" :Remove Delete buffer and file at same time
" :Unlink Delete file, keep buffer
" :Move Rename buffer and file
Plug 'tpope/vim-eunuch'
" Make netrw better
" - '-' in any buffer to go up to directory listing
" - cg/cl to cd into the
" - ! to use the file in a command
Plug 'tpope/vim-vinegar'
" }}}

" General coding {{{
Plug 'neoclide/coc.nvim', {'branch': 'release'}
inoremap <silent><expr> <c-space> coc#refresh()
function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~ '\s'
endfunction

inoremap <silent><expr> <Tab>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"
" Test.vim: Run tests based on cursor position / file
Plug 'janko-m/vim-test', { 'for': ['javascript'] }
" Syntax highlighting for a ton of languages
Plug 'sheerun/vim-polyglot'
" }}}

let g:rainbow_active = 1

" Git {{{
" Run Git commands from within Vim
" :Gstatus show `git status` in preview window
" - <C-N>/<C-P> next/prev file
" - - add/reset file under cursor
" - ca :Gcommit --amend
" - cc :Gcommit
" - D :Gdiff
" - p :Git add --patch (reset on staged files)
" - q close status
" - r reload status
" :Gcommit for committing
" :Gblame run blame on current file
" - <cr> open commit
" - o/O open commit in split/tab
" - - reblame commit
Plug 'tpope/vim-fugitive'
" Adds gutter signs and highlights based on git diff
" [c ]c to jump to prev/next change hunks
" <leader>hs to stage hunks within cursor
" <leader>hr to revert hunks within cursor
" <leader>hv to preview the hunk
Plug 'airblade/vim-gitgutter'
" }}}

" Markdown {{{
" Nice set of markdown tools
" <leader>= /  <leader>- toggle checkboxes
" <leader>[ /  <leader>] change heading level
" <leader>' to make blockquote out of selection
" <leader>i to insert / update table of contents
Plug 'SidOfc/mkdx', { 'for': ['markdown'] }
" }}}

call plug#end()
" }}}

" Load Vanilla (no-plugin) config
if filereadable(expand('~/.vimrc'))
  source ~/.vimrc
endif

" Re-generate spelling files if modified
for d in glob(fnamemodify($MYVIMRC, ':h').'/spell/*.add', 1, 1)
  if getftime(d) > getftime(d.'.spl')
    exec 'mkspell! ' . fnameescape(d)
  endif
endfor

" Neovim-only config {{{
" Useful reference for Neovim-only features (:help vim-differences)

" Terminal {{{
" Lots of scrollback in terminal
let g:terminal_scrollback_buffer_size = 50000

" Quickly open a shell below current window
nnoremap <leader>sh :below 10sp term://$SHELL<cr>

" Send selection to term below
vnoremap <leader>sp :<C-u>norm! gv"sy<cr><c-w>j<c-\><c-n>pa<cr><c-\><c-n><c-w>k

" Terminal key bindings for window switching
" Map jj and jk to <ESC> to leave insert mode quickly
" Also allow <leader><C-c> and <leader><esc>
tnoremap jj <C-\><C-n>
tnoremap jk <C-\><C-n>
tnoremap <leader><C-c> <C-\><C-n>
tnoremap <leader><esc> <C-\><C-n>

" Automatically go into insert mode when entering terminal window
augroup terminal_insert
  autocmd!
  autocmd BufEnter * if &buftype == 'terminal' | :startinsert | endif
augroup END
" }}}
" }}}

if &t_Co >= 256
  " Upgrade colors if we have more colors, stays with default if not available
  let base16colorspace=256
  if $COLOR_THEME == "light"

    silent! colorscheme onedark
  else
    silent! colorscheme onedark
  endif
endif

" TODO: Move into .vimrc
augroup on_vim_enter
  autocmd!
  autocmd VimEnter * call OnVimEnter()
augroup END

" Called after plugins have loaded {{{
function! g:OnVimEnter()
  " TODO
endfunction
" }}}

" Plugin Configuration {{{

" Enable transmutation of open / close blocks
let g:matchup_transmute_enabled = 1

" Enable deelete/change surrounding
let g:matchup_surround_enabled = 1

" Enable tmux to be mapped to '+' register
let g:vim_fakeclip_tmux_plus=1

" COC language server {{{

let g:coc_global_extensions = [
      \ 'coc-css',
      \ 'coc-emoji',
      \ 'coc-highlight',
      \ 'coc-html',
      \ 'coc-json',
      \ 'coc-prettier',
      \ 'coc-python',
      \ 'coc-tsserver',
      \ 'coc-ultisnips',
      \ 'coc-yaml'
      \]

" :Prettier/:PrettierAsync for formatting
command! -nargs=0 Prettier :call CocAction('runCommand', 'prettier.formatFile')
command! -nargs=0 PrettierAsync :call CocAction('runCommand', 'prettier.formatFile')

augroup coc_setup
  autocmd!

  " Close preview window when completion is done
  autocmd InsertLeave,CompleteDone * if pumvisible() == 0 | pclose | endif
augroup END

augroup automake
  autocmd!

  " COC handles auto-linting . Setup formatting via prettier
  autocmd BufWritePre *.js,*.json,*.ts Prettier
augroup END

" Trigger completion via same as omni-completion
inoremap <silent><expr> <C-x><C-o> coc#refresh()

nnoremap <silent> <leader>lk <Plug>(coc-action-doHover)

" Note: These do not work with `noremap`
nmap <leader>lc <Plug>(coc-references)
nmap <leader>ld <Plug>(coc-definition)
nmap <leader>li <Plug>(coc-implementation)
nmap <leader>lr <Plug>(coc-rename)
nmap <leader>ls <Plug>(coc-documentSymbols)
nmap <leader>lt <Plug>(coc-type-definition)

vmap <leader>lf <Plug>(coc-format-selected)
nmap <leader>lf <Plug>(coc-format-selected)

nmap <silent> [c <Plug>(coc-diagnostic-prev)
nmap <silent> ]c <Plug>(coc-diagnostic-next)

" Navigation snippet sections with C-j/k
let g:coc_snippet_next = '<C-j>'
let g:coc_snippet_prev = '<C-k>'
" }}}

" Test.vim {{{
" Run test commands in NeoVim terminal
let test#strategy = 'neovim'

let test#javascript#mocha#options = {
  \ 'nearest': '--reporter list',
  \ 'file': '--reporter list',
  \ 'suite': '--reporter dot',
  \ }

" Only works in JS for now
augroup test_shortcuts
  autocmd!

  " <leader>tt to test based on cursor, <leader>twt to watch
  autocmd FileType javascript,typescript nnoremap <buffer> <silent> <leader>tt :TestNearest<cr>
  autocmd FileType javascript,typescript nnoremap <buffer> <silent> <leader>twt :TestNearest -w<cr><c-\><c-n><c-w><c-k>
  " <leader>tf to test current file, <leader> twf to watch
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>tf :TestFile<cr>
  autocmd FileType javascript nnoremap <buffer> <silent> <leader>twf :TestFile -w<cr><c-\><c-n><c-w><c-k>
augroup END
" }}}



" Fuzzy Finding (FZF) {{{
if executable('fzf')
  " Enable preview for :Files and :GFiles
  command! -bang -nargs=? -complete=dir Files
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview(), <bang>0)
  command! -bang -nargs=? -complete=dir GFiles
  \ call fzf#vim#gitfiles(<q-args>, fzf#vim#with_preview(), <bang>0)

  " Fallback to :Files when not in git repo
  function! GFilesOrFiles()
    if IsInsideGitRepo()
      execute 'GFiles'
    else
      execute 'Files'
    endif
  endfunction

  " <C-p> or <C-t> to search files
  " Open in split via control-x / control-v
  " Select/Deselect all via alt-a / alt-d
  nnoremap <silent> <C-t> :call GFilesOrFiles()<cr>
  nnoremap <silent> <C-p> :call GFilesOrFiles()<cr>

  " <M-p> for open buffers
  nnoremap <silent> <M-p> :Buffers<cr>

  " <M-S-p> for MRU & v:oldfiles
  nnoremap <silent> <M-S-p> :History<cr>

  " Fuzzy insert mode completion for lines
  imap <c-x><c-l> <plug>(fzf-complete-line)

  " Use fuzzy completion relative filepaths across directory with <c-x><c-j>
  imap <expr> <c-x><c-j> fzf#vim#complete#path('git ls-files $(git rev-parse --show-toplevel)')

  " Better command history with <leader>:
  nnoremap <leader>: :History:<CR>

  " Better search history with <leader>/
  nnoremap <leader>/ :History/<CR>

  " Fuzzy search help <leader>?
  nnoremap <leader>? :Helptags<CR>

  " Search from git root via :Rag (Root Ag)
  " :Rag  - hidden preview enabled with "?" key
  " :Rag! - fullscreen and preview window above
  command! -bang -nargs=* Rag
    \ call GitRootCD() | call fzf#vim#ag(<q-args>,
    \                 <bang>0 ? fzf#vim#with_preview('up:60%', '?')
    \                         : fzf#vim#with_preview('right:50%:hidden', '?'),
    \                 <bang>0)

  " Use fuzzy searching for K & Q, select items to go into quickfix
  nnoremap K :Rag! <C-R><C-W><cr>
  vnoremap K :<C-u>norm! gv"sy<cr>:silent! Rag! <C-R>s<cr>
  nnoremap Q :Rag!<SPACE>
end
" }}}

" UltiSnips {{{
" Don't let UltiSnips try to do any mappings, messes with our completion keys
let g:UltiSnipsExpandTrigger='<nop>'
" <C-k> fuzzy-finds available snippets for the file with FZF
" let g:UltiSnipsListSnippets="<C-k>"
inoremap <C-k> <C-o>:Snippets<cr>
" let g:UltiSnipsJumpForwardTrigger='<tab>'
" let g:UltiSnipsJumpBackwardTrigger='<S-tab>'
" }}}

" vim-markdown {{{
let g:vim_markdown_fenced_languages = ['javascript', 'json', 'ts=typescript', 'typescript']
let g:vim_markdown_frontmatter = 1
let g:vim_markdown_strikethrough = 1
" }}}

" vim-javascript {{{
" jsdoc syntax
let g:javascript_plugin_jsdoc = 1
" }}}

" GitGutter {{{
" Unimpaired-style toggling for the line highlights
" cogg Gutter / cogl line highlight
nnoremap <silent> cogg :GitGutterToggle<cr>
nnoremap <silent> cogl :GitGutterLineHighlightsToggle<cr>

" Ignore whitespace
let g:gitgutter_diff_args='-w'

" Use raw grep
let g:gitgutter_escape_grep=1

" Don't highlight lines by default (use cogl to toggle)
let g:gitgutter_highlight_lines=0

" Be aggressive about looking for diffs
let g:gitgutter_realtime=1
let g:gitgutter_eager=1

" Tweak signs
let g:gitgutter_sign_modified='??'
let g:gitgutter_sign_modified_removed='???'
" }}}

" Indent Guides {{{
" Default guides to on everywhere
let g:indent_guides_enable_on_vim_startup=1

" Don't turn on mapping for toggling guides
let g:indent_guides_default_mapping=0

" Don't use their colors, depending on the colorscheme to define
let g:indent_guides_auto_colors=0

" Wait until we've nested a little before showing
let g:indent_guides_start_level=3

" Skinny guides
let g:indent_guides_guide_size=1
" }}}

" Javascript libraries syntax {{{
let g:used_javascript_libs='react'
" }}}

" vim-jsx config {{{
" Don't require .jsx extension
let g:jsx_ext_required=0
" }}}

" }}}

" Local Settings {{{
if filereadable(expand('~/.nvimrc.local'))
  source ~/.nvimrc.local
endif
" }}}

set number
