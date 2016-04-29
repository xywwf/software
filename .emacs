(require 'package)
;(add-to-list 'package-archives '("elpa" . "http://tromey.com/elpa/" ) t)
;(add-to-list 'package-archives '("gnu" . "http://elpa.gnu.org/packages/" ) t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/" ) t)
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/" ) t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/" ) t)
(package-initialize)

;;switch-window
(require 'switch-window)
(global-set-key (kbd "C-x o") 'switch-window)

(autoload 'mpg123 "mpg123" "A Front-end to mpg123/ogg123" t)

;;speedbar
(require 'sr-speedbar)  
(setq speedbar-show-unknown-files t)  
(setq speedbar-use-images nil)  
(setq sr-speedbar-width 30)  
(setq sr-speedbar-right-side nil)  
   
(global-set-key (kbd "<f5>") (lambda()  
                               (interactive)  
                               (sr-speedbar-toggle)))  

;eshell
(defun eshell-clear-buffer ()
  "Clear terminal"
  (interactive)
  (let ((inhibit-read-only t))
    (erase-buffer)
    (eshell-send-input)))
(add-hook 'eshell-mode-hook
      '(lambda()
          (local-set-key (kbd "C-l") 'eshell-clear-buffer)))

(require 'helm)
(require 'helm-config)
;(require 'helm-dash)
(helm-mode 1)
(helm-autoresize-mode 1)
;(setq helm-ff-auto-update-initial-value nil)    ; 禁止自动补全
;(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c h") 'helm-command-prefix)
(global-set-key (kbd "C-x b") 'helm-mini)
;(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-s") 'helm-occur)
(global-set-key (kbd "C-h SPC") 'helm-all-mark-rings)
(setq helm-split-window-in-side-p	     t
	helm-move-to-line-cycle-in-source     t
	helm-ff-search-library-in-sexp	  t
	helm-M-x-fuzzy-match			t   ; 模糊搜索
	helm-buffers-fuzzy-matching	     t
	helm-locate-fuzzy-match		   t
	helm-recentf-fuzzy-match		  t
	helm-scroll-amount			  8
	helm-ff-file-name-history-use-recentf t)
(provide 'init-helm)

;半透明效果切换
(global-set-key [(f11)] 'loop-alpha) 
(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35))) 
(defun loop-alpha () 
  (interactive) 
  (let ((h (car alpha-list)))                ;; head value will set to 
    ((lambda (a ab) 
       (set-frame-parameter (selected-frame) 'alpha (list a ab)) 
       (add-to-list 'default-frame-alist (cons 'alpha (list a ab))) 
       ) (car h) (car (cdr h))) 
    (setq alpha-list (cdr (append alpha-list (list h)))) 
    ) 
) 

;ctrl+鼠标滚动更改字体大小
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; evil-mode
(require 'evil)
(evil-mode 1)

;;加亮选中部分
(transient-mark-mode t)

;;; Smex
(autoload 'smex "smex"
  "Smex is a M-x enhancement for Emacs, it provides a convenient interface to
your recently and most frequently used commands.")
(global-set-key (kbd "M-x") 'smex)

;;;color theme
(require 'color-theme)
(eval-after-load "color-theme"
  '(progn
     (color-theme-initialize)
     (color-theme-oswald)
     (color-theme-hober)
  )
)
;;powerline
(require 'powerline)
(powerline-default-theme)

;;; yasnippet
(require 'yasnippet)
(yas/global-mode 1)
;; The `dropdown-list.el' extension is bundled with YASnippet, you
;; can optionally use it the preferred "prompting method"
(require 'dropdown-list)
(setq yas/prompt-functions '(yas/dropdown-prompt
    yas/ido-prompt
    yas/completing-prompt))

;auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
(ac-config-default)

(defun my-auto-pairs ()
  (interactive)
  (make-local-variable 'skeleton-pair-alist)
  (setq skeleton-pair-alist  '(
    (?` ?` _ "''")
    (?\( ?  _ ")")
    (?\[ ?  _ "]")
    (?{ \n > _ \n ?} >)))
  (setq skeleton-pair t)
  (local-set-key (kbd "(") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "{") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "`") 'skeleton-pair-insert-maybe)
  (local-set-key (kbd "[") 'skeleton-pair-insert-maybe))
  
;(add-hook 'c-mode-hook 'my-auto-pairs)
;(add-hook 'c++mode-hook 'my-auto-pairs)
;(add-hook 'emacs-lisp-mode-hook 'my-auto-pairs)

(when (fboundp 'electric-pair-mode)
(electric-pair-mode))
(when (eval-when-compile (version< "24.4" emacs-version))
(electric-indent-mode 1))


;关闭起动时的那个“开机画面”。
(setq inhibit-startup-message t)

;显示列号。
(setq column-number-mode t)
;显示行号
(setq line-number-mode t)
;;在左边显示行号 
(global-linum-mode 'linum-mode)
;不要在鼠标点击的地方插入剪贴板的内容，不然你的文档很容易变得乱七八糟。
(setq mouse-yank-at-point t)

;括号匹配时加亮显示另外一边的括号，而不是烦人的跳到另一个括号。
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;光标靠近鼠标指针时，让鼠标指针自动让开，别挡住视线。
(mouse-avoidance-mode 'animate)

;在标题栏显示buffer的名字，而不是 emacs@!#*&!(&@# 这样没用的提示。
(setq frame-title-format "emacs@%b")

;设置一下备份时的版本控制，这样更加安全。
(setq version-control t) 
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;设置自动备份文件保存的目录,以免把你的磁盘弄得乱七八糟(你可以
;去掉这一行试试看:P ~/.autosave 表示 主目录下的一个叫
;.autosave 的子目录，按照前面的方法设置主目录。
(setq backup-directory-alist '(("." . "~/.autosave")))

;让 dired 可以递归的拷贝和删除目录。
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;;滚轮支持
(setq mouse-wheel-mode t)

;一个加强的 buffer 列表模式
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;ido mode. 超强的buffer切换工具, Emacs 也有通常编辑器的那种
;在 Tab 中选择 buffer 的 mode，但是用了ido 以后，我再也不需要
;他它了，ido mode 是我见过最方便的 buffer 切换模式。
(require 'ido)
(ido-mode t)
;记住上次编辑的文件，这样你下次进入Emacs 的时候，就会直接打开
;上次编辑的东西，就和没退出过一样。建议，把这个设置放在配置文
;件的最末尾！
(require 'desktop) 
(desktop-save-mode t)
(desktop-read)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)


(global-set-key [f4] 'eshell)