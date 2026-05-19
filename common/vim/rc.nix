{ pkgs }:
let
  clangFormat = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/llvm-mirror/clang/master/tools/clang-format/clang-format.py";
    sha256 = "0xmnshbn8p10yjz4821lmayrbs4044i9mcqi5y6pnqzh6nfkk130";
  };

  cscopeMaps = builtins.fetchurl {
    url =
      "https://raw.githubusercontent.com/chazy/cscope_maps/master/plugin/cscope_maps.vim";
    sha256 = "0i955zg1c2gw5lj6921b4yllhr9nbxg7nl3yar54h7m4m1z6q9rz";
  };
in
''
  syntax on
  set encoding=UTF-8
  set autoread
  set backspace=2
  set colorcolumn=80,100
  set hidden
  set background=dark
  set laststatus=2
  set list
  set t_Co=256
  set listchars=tab:›\ ,eol:¬,trail:⋅
  set number
  set ruler
  set showmatch
  set visualbell

  " Search settings
  set hlsearch
  set ignorecase
  set incsearch
  set smartcase

  autocmd BufEnter * :syntax sync fromstart

  highlight ExtraWhitespace ctermbg=red guibg=red
  match ExtraWhitespace /\s\+$/

  map <F7> :tabp<enter>
  map <F8> :tabn<enter>
  set expandtab
  set softtabstop=2
  set shiftwidth=2
  filetype plugin indent on
  colorscheme badwolf

  source ${cscopeMaps}

  map <C-K> :pyf ${clangFormat}<cr>

  map <C-F> :FZF<enter>
  map <C-n> :NERDTreeFocus<enter>
  map <C-x> :NERDTreeFind<enter>
  map <C-T> :TerraformFmt<enter>
  map <C-r> :NERDTreeVCS<enter>

  if &diff
    colorscheme molokai
  endif

  let g:syntastic_python_checkers = ['mypy', 'flake8']

  " comment the next line to disable automatic format on save
  let g:dhall_format=1

  " Always draw sign column. Prevent buffer moving when adding/deleting sign.
  set signcolumn=yes

  " Auto-indent settings for YAML files
  autocmd FileType yaml setlocal tabstop=2 softtabstop=2 shiftwidth=2 expandtab

  autocmd BufNewFile,BufRead *.zig set filetype=zig
  autocmd BufNewFile,BufRead *.hcl set filetype=terraform
  autocmd BufNewFile,BufRead *.j2 set filetype=jinja

  let g:LanguageClient_serverCommands = {
   \ 'zig': ['${pkgs.zls}/bin/zls'],
   \ 'python': ['${pkgs.python3Packages.python-lsp-server}/bin/pylsp'],
   \ 'dhall': ['dhall-lsp-server'],
   \ 'terraform': ['terraform-ls'],
   \ 'go': ['gopls'],
   \ }

  nnoremap <F5> :call LanguageClient_contextMenu()<CR>
  nnoremap <silent> gh :call LanguageClient_textDocument_hover()<CR>
  nnoremap <silent> gd :call LanguageClient_textDocument_definition()<CR>
  nnoremap <silent> gr :call LanguageClient_textDocument_references()<CR>
  nnoremap <silent> gs :call LanguageClient_textDocument_documentSymbol()<CR>
  nnoremap <silent> <F2> :call LanguageClient_textDocument_rename()<CR>
  nnoremap <silent> gff :call LanguageClient_textDocument_formatting()<CR>
  inoremap <expr> <Tab> coc#pum#visible() ? coc#pum#next(1) : "\<Tab>"
  inoremap <expr> <S-Tab> coc#pum#visible() ? coc#pum#prev(1) : "\<S-Tab>"
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>"

  " Use `[g` and `]g` to navigate diagnostics
  nmap <silent> [g <Plug>(coc-diagnostic-prev)
  nmap <silent> ]g <Plug>(coc-diagnostic-next)

  " GoTo code navigation
  nmap <silent> ggd <Plug>(coc-definition)
  nmap <silent> ggy <Plug>(coc-type-definition)
  nmap <silent> ggi <Plug>(coc-implementation)
  nmap <silent> ggr <Plug>(coc-references)
  nmap <leader>f  <Plug>(coc-format)

  command! -nargs=0 CF :call CocActionAsync('format')
''
