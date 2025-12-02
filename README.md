# 🔥 vim-angular-switcher

A lightweight Vim plugin to quickly switch between Angular component files:

- `.component.ts`
- `.component.html`
- `.component.scss` / `.sass` / `.css`
- `.component.spec.ts` (optional)

Designed to bring VSCode-style navigation convenience into Vim.

---

## 🚀 Features

- Instant jump between related Angular component files
- Cycle through all component files with a single mapping
- Direct mappings for:
  - component class
  - template
  - styles
  - spec/testing file
- SCSS, SASS, and CSS supported
- Works regardless of `:pwd`
- Pure Vimscript — no dependencies

---

## 💻 How to use
```vim
" Cycle through all component files
<leader>a
" Go to ts
<leader>ac
" Go to html
<leader>ah
" Go to styles (scss/sass/css)
<leader>as
" Go to test (spec)
<leader>at
```

## 📦 Installation

### **vim-plug**

```vim
Plug 'fmflurry/vim-angular-switcher'
```

## 📄 License

MIT
