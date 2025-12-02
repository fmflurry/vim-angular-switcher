" ---------------------------------------------------------
" Angular Component File Switcher
" Jump between component.ts / template.html / style(s) / spec.ts
" ---------------------------------------------------------

function! s:AngularBase(current)
  let l:dir = fnamemodify(a:current, ':h')

  " breadcrumb.component.html → breadcrumb.component
  let l:name = fnamemodify(a:current, ':t')
  let l:base = substitute(l:name, '\.\(ts\|html\|scss\|sass\|css\|spec\.ts\)$', '', '')

  return [l:dir, l:base]
endfunction


" ---------------------------------------
" Cycle through component files
" ---------------------------------------
function! AngularSwitch()
  let l:current = expand('%:p')
  let [l:dir, l:base] = s:AngularBase(l:current)

  let l:files = [
        \ l:dir . '/' . l:base . '.ts',
        \ l:dir . '/' . l:base . '.html',
        \ l:dir . '/' . l:base . '.scss',
        \ l:dir . '/' . l:base . '.sass',
        \ l:dir . '/' . l:base . '.css',
        \ l:dir . '/' . l:base . '.spec.ts'
        \ ]

  let l:cur = expand('%:p')
  let l:found = 0

  " cycle through existing files
  for f in l:files
    if f == l:cur
      let l:found = 1
      continue
    endif
    if l:found && filereadable(f)
      execute 'edit ' . f
      return
    endif
  endfor

  " fallback: first existing file
  for f in l:files
    if f != l:cur && filereadable(f)
      execute 'edit ' . f
      return
    endif
  endfor

  echo "AngularSwitch: no related files found."
endfunction


" ---------------------------------------
" Direct jump functions
" ---------------------------------------
function! AngularGo(type)
  let l:current = expand('%:p')
  let [l:dir, l:base] = s:AngularBase(l:current)

  if a:type ==# 'ts'
    let l:target = l:dir . '/' . l:base . '.ts'
  elseif a:type ==# 'html'
    let l:target = l:dir . '/' . l:base . '.html'
  elseif a:type ==# 'style'
    " try scss → sass → css
    let l:target = ''
    for ext in ['scss', 'sass', 'css']
      let f = l:dir . '/' . l:base . '.' . ext
      if filereadable(f)
        let l:target = f
        break
      endif
    endfor
  elseif a:type ==# 'spec'
    let l:target = l:dir . '/' . l:base . '.spec.ts'
  endif

  if exists('l:target') && filereadable(l:target)
    execute 'edit ' . l:target
  else
    echo "AngularGo: target file not found (" . a:type . ")"
  endif
endfunction


" ---------------------------------------
" Key mappings
" ---------------------------------------
" Cycle (ts → html → scss → spec → ts)
nnoremap <leader>a :call AngularSwitch()<CR>

" Direct jumps
nnoremap <leader>ac :call AngularGo('ts')<CR>
nnoremap <leader>ah :call AngularGo('html')<CR>
nnoremap <leader>as :call AngularGo('style')<CR>
nnoremap <leader>at :call AngularGo('spec')<CR>
