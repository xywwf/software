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
;(setq helm-ff-auto-update-initial-value nil)    ; ��ֹ�Զ���ȫ
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
	helm-M-x-fuzzy-match			t   ; ģ������
	helm-buffers-fuzzy-matching	     t
	helm-locate-fuzzy-match		   t
	helm-recentf-fuzzy-match		  t
	helm-scroll-amount			  8
	helm-ff-file-name-history-use-recentf t)
(provide 'init-helm)

;��͸��Ч���л�
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

;ctrl+���������������С
;; For Linux
(global-set-key (kbd "<C-mouse-4>") 'text-scale-increase)
(global-set-key (kbd "<C-mouse-5>") 'text-scale-decrease)

;; For Windows
(global-set-key (kbd "<C-wheel-up>") 'text-scale-increase)
(global-set-key (kbd "<C-wheel-down>") 'text-scale-decrease)

;; evil-mode
(require 'evil)
(evil-mode 1)

;;����ѡ�в���
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


;�ر���ʱ���Ǹ����������桱��
(setq inhibit-startup-message t)

;��ʾ�кš�
(setq column-number-mode t)
;��ʾ�к�
(setq line-number-mode t)
;;�������ʾ�к� 
(global-linum-mode 'linum-mode)
;��Ҫ��������ĵط��������������ݣ���Ȼ����ĵ������ױ�����߰��㡣
(setq mouse-yank-at-point t)

;����ƥ��ʱ������ʾ����һ�ߵ����ţ������Ƿ��˵�������һ�����š�
(show-paren-mode t)
(setq show-paren-style 'parentheses)

;��꿿�����ָ��ʱ�������ָ���Զ��ÿ�����ס���ߡ�
(mouse-avoidance-mode 'animate)

;�ڱ�������ʾbuffer�����֣������� emacs@!#*&!(&@# ����û�õ���ʾ��
(setq frame-title-format "emacs@%b")

;����һ�±���ʱ�İ汾���ƣ��������Ӱ�ȫ��
(setq version-control t) 
(setq kept-new-versions 3)
(setq delete-old-versions t)
(setq kept-old-versions 2)
(setq dired-kept-versions 1)

;�����Զ������ļ������Ŀ¼,�������Ĵ���Ū�����߰���(�����
;ȥ����һ�����Կ�:P ~/.autosave ��ʾ ��Ŀ¼�µ�һ����
;.autosave ����Ŀ¼������ǰ��ķ���������Ŀ¼��
(setq backup-directory-alist '(("." . "~/.autosave")))

;�� dired ���Եݹ�Ŀ�����ɾ��Ŀ¼��
(setq dired-recursive-copies 'top)
(setq dired-recursive-deletes 'top)

;;����֧��
(setq mouse-wheel-mode t)

;һ����ǿ�� buffer �б�ģʽ
(require 'ibuffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

;ido mode. ��ǿ��buffer�л�����, Emacs Ҳ��ͨ���༭��������
;�� Tab ��ѡ�� buffer �� mode����������ido �Ժ�����Ҳ����Ҫ
;�����ˣ�ido mode ���Ҽ������� buffer �л�ģʽ��
(require 'ido)
(ido-mode t)
;��ס�ϴα༭���ļ����������´ν���Emacs ��ʱ�򣬾ͻ�ֱ�Ӵ�
;�ϴα༭�Ķ������ͺ�û�˳���һ�������飬��������÷���������
;������ĩβ��
(require 'desktop) 
(desktop-save-mode t)
(desktop-read)

(require 'session)
(add-hook 'after-init-hook 'session-initialize)


(global-set-key [f4] 'eshell)