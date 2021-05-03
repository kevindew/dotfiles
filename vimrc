set nocompatible
""" Vundle
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'VundleVim/Vundle.vim'
Plugin 'Valloric/YouCompleteMe'
Plugin 'chriskempson/base16-vim'
Plugin 'editorconfig/editorconfig-vim'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rake'
Plugin 'scrooloose/nerdTree'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'jlanzarotta/bufexplorer'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'tComment'
Plugin 'endwise.vim'
Plugin 'tpope/vim-fugitive'
Plugin 'Yggdroot/indentLine'
Plugin 'djoshea/vim-autoread'
Plugin 'airblade/vim-gitgutter'
" Plugin 'scrooloose/syntastic'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-dispatch'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'hashivim/vim-terraform'
call vundle#end()
filetype plugin indent on

""" Settings
syntax enable
let base16colorspace=256
if $USER == "vagrant"
  colorscheme base16-solarized-dark
else
  colorscheme base16-default-dark
endif

set nocompatible
set autoindent
set ruler
set number
set hlsearch
set incsearch
set nowrap
set winwidth=83
set ignorecase
set smartcase
set swapfile
set dir=/tmp
set showcmd
set tags=.tags
set scrolloff=5
set sidescrolloff=5
set cmdheight=2
set ttyfast
set lazyredraw
set noerrorbells
set fileformats=unix
set ff=unix
set shell=zsh
set backspace=indent,eol,start
set cursorline
set wildmode=list:longest,full
set autoread
set clipboard=unnamed
set switchbuf=usetab
set foldmethod=syntax
set foldlevelstart=20
set laststatus=2
set termguicolors
set re=1
let mapleader = " "

" set vertical marker at col 80
set colorcolumn=80

set listchars=tab:▸\ ,eol:¬
set list

set ts=2 sts=2 sw=2 expandtab

" Mouse
set mouse=ar mousemodel=extend

" NERDTree
map <C-n> :NERDTreeTabsToggle<CR>
let NERDTreeShowHidden=1

" Syntastic
" set statusline+=%#warningmsg#
" set statusline+=%{SyntasticStatuslineFlag()}
" set statusline+=%*
"
" let g:syntastic_always_populate_loc_list = 1
" let g:syntastic_auto_loc_list = 1
" let g:syntastic_check_on_open = 1
" let g:syntastic_check_on_wq = 0
"
" let g:syntastic_ruby_checkers = ['rubocop', 'mri']
" if executable('/usr/bin/govuk-lint-ruby-shim.sh')
"   let g:syntastic_ruby_rubocop_exec = '/usr/bin/govuk-lint-ruby-shim.sh'
" endif
" if executable('/Users/kevindew/bin/govuk-lint-ruby-shim.sh')
"   let g:syntastic_ruby_rubocop_exec = '/Users/kevindew/bin/govuk-lint-ruby-shim.sh'
" endif

if executable('ag')
  " Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

  " Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

  " ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" Lots of stuff from Doug's .vimrc:

" unobtrusive whitespace highlighting
" http://blog.kamil.dworakowski.name/2009/09/unobtrusive-highlighting-of-trailing.html
highlight ExtraWhitespace ctermbg=red guibg=red
au ColorScheme * highlight ExtraWhitespace guibg=red
au BufEnter * match ExtraWhitespace /\s\+$/
au InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
au InsertLeave * match ExtraWhiteSpace /\s\+$/

" Return to last edit position when opening files
function! PositionCursorFromViminfo()
  if !(bufname("%") =~ '\(COMMIT_EDITMSG\)') && line("'\"") > 1 && line("'\"") <= line("$")
    exe "normal! g`\""
  endif
endfunction

autocmd BufReadPost * call PositionCursorFromViminfo()

" Open and reload vimrc
map <leader>vrc :edit $MYVIMRC<cr>
map <leader>vsrc :source $MYVIMRC<cr>:echo "VIMRC reloaded"<cr>

" Rename current file
map <leader>n :call RenameFile()<cr>

" RSpec let double - Convert bare word to let(:thing) { double(:thing) }
map <leader>rld Ilet(:wviwyA) { double(:pA) }

" Ruby binding pry - insert binding.pry on the line below
map <leader>bp orequire "pry"; binding.pry # DEBUG @kevindew<esc>

" Ruby byebug - insert byebug on the line below
map <leader>bb orequire "byebug"; byebug # DEBUG @kevindew<esc>

" Ruby frozen string literal - insert byebug on the line below
map <leader>fsl ggO# frozen_string_literal: true<esc>

" Ruby tap and pry
map <leader>rtp o.tap { \|o\| "DEBUG @kevindew"; require "pry"; binding.pry }<esc>

" Ruby no pry - remove a binding.pry from the current file, hope it's the one you wanted
map <leader>np /binding.pry<cr>dd:noh

" Ruby open spec
map <leader>ros :call EditFile(InferSpecFile(expand('%')))<cr>

" Run test, support all common Ruby test libs
map <leader>rt :ccl<cr>:w<cr>:call RunTest(expand('%'))<cr>

" As above but only test on current line
map <leader>rtl :ccl<cr>:w<cr>:call RunTestAtLine(expand('%'), line("."))<cr>

" Repeats one of the above, for when you've navigated away from the test file
map <leader>rr <esc>:ccl<cr>:w<cr>:call RepeatLastTest()<cr>

" Run rame
map <leader>drake :call RunTestCommand("bundle exec rake")<cr>
"
" Run all the specs
map <leader>drspec :call RunTestCommand("bundle exec rspec")<cr>

" Run all the cukes
map <leader>dcuc :call RunTestCommand("bundle exec cucumber --strict")<cr>

function! RepeatLastTest()
  if exists("g:last_test")
    call RunTestCommand(g:last_test)
  else
    echo "No last test, <leader>rt to run this file."
  end
endfunction

" Unjoin
map <leader>j :s/, /,\r/g<cr>:nohl<cr>

" Run a test file at line (currently supports Ruby only)
function! RunTestAtLine(filename, line_number)
  let test_command = InferRubyTestCommand(a:filename)

  if strlen(test_command)
    let test_command_with_line = test_command . ":" . a:line_number
    call RunTestCommand(test_command_with_line)
  else
    echo "Not a recognized test '" . a:filename . "'"
  end
endfunction!

" Run a test file (currently supports Ruby only)
function! RunTest(filename)
  let test_command = InferRubyTestCommand(a:filename)

  if strlen(test_command)
    call RunTestCommand(test_command)
  else
    echo "Not a recognized test '" . a:filename . "'"
  end
endfunction

function! RunTestCommand(test_command)
  let g:last_test = a:test_command
  echo a:test_command
  exec "Dispatch " . a:test_command
endfunction

" Infer and return corresponding command to run a Ruby test file
function! InferRubyTestCommand(filename)
    if a:filename =~ "\.feature$"
      let command  = "bundle exec cucumber --strict"
    elseif a:filename =~ "_spec\.rb$"
      let command = "bundle exec rspec --format progress"
    elseif a:filename =~ "_test\.rb$"
      let command = "bundle exec ruby -I test"
    else
      return ""
    end

    return command . " " . a:filename
endfunction

" Infer RSpec file for current file
function! InferSpecFile(filename)
    if a:filename =~ '^app'
      let spec_file = substitute(a:filename, '^app', 'spec', '')
    elseif a:filename =~ '^lib/'
      let spec_file = substitute(a:filename, '^lib', 'spec', '')
    else
      let spec_file = 'spec/' . a:filename
    endif

    let path = substitute(spec_file, '\.rb', '_spec.rb', '')

    return path
endfunction

" Rename current file thanks @samphippen
function! RenameFile()
    let old_name = expand('%')
    let new_name = input('New file name: ', expand('%'), 'file')
    if new_name != '' && new_name != old_name
        exec ':saveas ' . new_name
        exec ':silent !rm ' . old_name
        redraw!
    endif
endfunction

" This probably isn't necessary but I have no idea what I'm doing
function! EditFile(filename)
  exec "e " . a:filename
endfunction


""" Key remaps (standard stuff) """""""""""""""""""""""""""""""""""""""""""""""

" %% For current directory thanks @squil
cnoremap <expr> %% getcmdtype() == ':' ? expand('%:h').'/' : '%%'

" http://vimcasts.org/episodes/show-invisibles/
" Shortcut to rapidly toggle `set list`
nmap <leader>l :set list!<CR>

" Turn search highlighting off
map <leader>/ :noh<CR>

" Save with CTRL-s
:nmap <c-s> :w<CR>
:imap <c-s> <Esc>:w<CR>a
:imap <c-s> <Esc><c-s>

:nnoremap <leader>c :ccl<CR>

" Copy and paste from system clipboard
vmap <leader>y "+y
nmap <leader>y "+yy
nmap <leader>p "+p
vmap <leader>p "+p
nmap <leader>P "+P
nmap <leader>cs :let @*=expand("%")<CR>
nmap <leader>cl :let @*=expand("%:p")<CR>

" Change Tabs
nnoremap <c-Left> :tabprevious<CR>
nnoremap <c-Right> :tabnext<CR>
inoremap <c-Left> <Esc>:tabprevious<CR>
inoremap <c-Right> <Esc>:tabnext<CR>

" Switch buffers
nnoremap <Tab> <c-w>w
nnoremap <s-Tab> <c-w>W

" Auto-complete command line
set wildchar=<Tab> wildmenu wildmode=full

""" Forgive """""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Disable entering EX mode by accident
map Q <Nop>

" You know what I meant
command! Q  q  " Bind :Q  to :q
command! W  w  " Bind :W  to :w
command! Wq wq " Bind :Wq to :wq
command! WQ wq " Bind :WQ to :wq

""" Things to disable when you're feeling masochistic / anti-social

" Disable backspace
" inoremap <BS> <Nop>
" Disable delete
" inoremap <Del> <Nop>

" disble arrow keys in insert, command mode
nnoremap <up> <nop>
nnoremap <down> <nop>
nnoremap <left> <nop>
nnoremap <right> <nop>
inoremap <up> <nop>
inoremap <down> <nop>
inoremap <left> <nop>
inoremap <right> <nop>

""" Syntax highlighting """""""""""""""""""""""""""""""""""""""""""""""""""""""

" Thorfile, Rakefile, Vagrantfile and Gemfile are Ruby
au BufRead,BufNewFile {Gemfile,Guardfile,Rakefile,Vagrantfile,Thorfile,config.ru,*.jbuilder} set filetype=ruby

" md, markdown, and mk are markdown and define buffer-local preview
au BufRead,BufNewFile *.{md,markdown} set filetype=markdown

" Spell checking for text formats
au BufRead,BufNewFile *.txt,*.md,*.markdown,*.textile,*.feature setlocal spell
autocmd FileType gitcommit setlocal spell
" Autocomplete with dictionary words when spell check is on
set complete+=kspell

" add json syntax highlighting
au BufNewFile,BufRead *.json set ft=javascript

" Remove 80 char line from temporary windows
au BufReadPost quickfix setlocal colorcolumn=0

""" Plugin configs """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" ctrl-p working mode nearest git versioned ancestor
let g:ctrlp_working_path_mode = 'ra'
let g:ctrlp_custom_ignore = 'node_modules\|DS_Store\|git\|tmp'
let g:ctrlp_use_caching = 0
" Use Ag to list files because it's *fast*
" let g:ctrlp_user_command = 'ag %s -l --nocolor --hidden -g ""'
" ctrl-p for ctags
nnoremap <leader>] :CtrlPTag<cr>
nnoremap <leader><leader> :CtrlPBuffer<cr>

if &term =~ '256color'
  " disable Background Color Erase (BCE) so that color schemes
  " render properly when inside 256-color tmux and GNU screen.
  " see also http://snk.tuxfamily.org/log/vim-256color-bce.html
  set t_ut=
endif

fun! StripTrailingWhiteSpace()
  " don't strip on these filetypes
  if &ft =~ 'markdown'
    return
  endif
  %s/\s\+$//e
endfun
autocmd bufwritepre * :call StripTrailingWhiteSpace()

""" Quote / Unquote words """"""""""""""""""""""""""""""""""""""""""""""""""""
" 'quote' a word
nnoremap qw :silent! normal mpea'<Esc>bi'<Esc>`pl
" double "quote" a word
nnoremap qd :silent! normal mpea"<Esc>bi"<Esc>`pl
" remove quotes from a word
nnoremap wq :silent! normal mpeld bhd `ph<CR>

""" terraform """"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

let g:terraform_align=1
let g:terraform_fmt_on_save=1
