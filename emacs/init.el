;; el-get sync
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)

;; package manegement
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)


;; auto-complete
(require 'auto-complete)
(require 'auto-complete-config)
;;auto-complete: select candidate by using C-p and C-p key
(define-key ac-complete-mode-map "\C-n" 'ac-next)
(define-key ac-complete-mode-map "\C-p" 'ac-previous)

;; use gocode (go get -u github.com/nsf/gocode) my gopath is '$HOME/.go'
(add-to-list 'load-path "~/go/src/github.com/nsf/gocode/emacs")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;compile a program if you type the meta-key and 'p'
(global-set-key "\M-p" 'compile)

;; default background color
(set-face-background 'default "#282828")


;; disactivate whitespace-action in markdown file.
(defvar delete-trailing-whitespece-before-save t)
(defun my-delete-trailing-whitespace ()
  (if delete-trailing-whitespece-before-save
      (delete-trailing-whitespace)))
(add-hook 'before-save-hook 'my-delete-trailing-whitespace)
; 無効にしたいモードのhook
(add-hook 'markdown-mode-hook
          '(lambda ()
             (set (make-local-variable 'delete-trailing-whitespece-before-save) nil)))

;; setting of keys
;; use ctr-h as backspace key
(global-set-key "\C-h" 'delete-backward-char)

;; setting of display
;; display line number
(global-linum-mode t)
(custom-set-faces
 '(linum ((t (:inherit (shadow default) :background "#282828")))))

;; dirtree
(require 'dirtree)

;; completion of brackets
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "'") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;; pair brackets
(show-paren-mode 1)


;; load theme'
;; (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
;; (load-theme 'smyx t)
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
(load-theme 'dracula t)
;(load-theme 'odersky t)
;(load-theme 'hickey t)

;(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
;(load-theme 'material t)
;(load-theme 'monokai t)

;;;; mode-compile
(autoload 'mode-compile "mode-compile"
  "Command to compile current buffer file based on the major mode" t)
(global-set-key "\C-cc" 'mode-compile)
(autoload 'mode-compile-kill "mode-compile"
  "Command to kill a compilation launched by `mode-compile'" t)
(global-set-key "\C-ck" 'mode-compile-kill)

;; all buffers saved automatically.
(setq mode-compile-always-save-buffer-p t)
;; not check command.
(setq mode-compile-never-edit-command-p t)
;; control output messages.
(setq mode-compile-expert-p t)
;; wait for reading messages
(setq mode-compile-reading-time 0)

;; close the window at compiling complete
(defun compile-autoclose (buffer string)
  (cond ((string-match "finished" string)
         (message "Build maybe successful: closing window.")
         (run-with-timer 0.3 nil
                         'delete-window
                         (get-buffer-window buffer t)))
        (t (message "Compilation exited abnormally: %s" string))))
(setq compilation-finish-functions 'compile-autoclose)

;; setting of editing
;; not create a backup file
(setq make-backup-files nil)
(setq auto-save-default nil)

; set tab width
(setq default-tab-width 4)

;; setting of japanese
(set-language-environment "Japanese")
(prefer-coding-system 'utf-8)
(set-default-coding-systems 'utf-8)
(set-terminal-coding-system 'utf-8)
(set-keyboard-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(setq default-buffer-file-coding-system 'utf-8)
(set-buffer-file-coding-system 'utf-8)
(set-clipboard-coding-system 'utf-8)


;; share the clipboard of mac os
(defun copy-from-osx ()
  (shell-command-to-string "pbpaste"))

(defun paste-to-osx (text &optional push)
  (let ((process-connection-type nil))
    (let ((proc (start-process "pbcopy" "*Messages*" "pbcopy")))
      (process-send-string proc text)
      (process-send-eof proc))))

(setq interprogram-cut-function 'paste-to-osx)
(setq interprogram-paste-function 'copy-from-osx)


;; golang
;; run gofmt automatically at saving the go file.
(add-hook 'before-save-hook 'gofmt-before-save)

;; Racket
(setq geiser-racket-binary "/opt/homebrew-cask/Caskroom/racket/6.5/Racket v6.5/bin/racket")
(setq geiser-active-implementations '(racket))


;; scala-mode2
(add-to-list 'load-path "~/.emacs.d/elisp/scala-mode2/")
(require 'scala-mode2)

;; ensime
(require 'ensime)
(add-hook 'scala-mode-hook 'ensime-scala-mode-hook)

; use auto-complete instead of complement of ensime.
(setq ensime-completion-style 'auto-complete)

;; sql indent
(eval-after-load "sql"
  '(load-library "sql-indent"))

;; markdown mode
(autoload 'markdown-mode "markdown-mode.el" "Major mode for editing Markdown files" t)
(setq auto-mode-alist (cons '("\\.md" . markdown-mode) auto-mode-alist))

;; use auto complete in emacs ipython notebook.
(setq ein:use-auto-complete t)
;; Or, to enable "superpack" (a little bit hacky improvements):
;; (setq ein:use-auto-complete-superpack t)

;; don't insert magic encoding commet on ruby file.
(setq ruby-insert-encoding-magic-comment nil)

;; quickrun short cut key.
(global-set-key "\C-xr" 'quickrun)
(global-set-key "\C-xy" 'quickrun-with-arg)
(global-set-key "\C-cc" 'quickrun-compile-only)

;; split horizontally.
(setq split-width-threshold nil)

;; yaml-mode
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(define-key yaml-mode-map "\C-m" 'newline-and-indent)


;; eproject
(defun ep-dirtree ()
  (interactive)
  (dirtree-in-buffer eproject-root t))

; pyflakes
(add-hook 'find-file-hook 'flymake-find-file-hook)
(when (load "flymake" t)
  (defun flymake-pyflakes-init ()
    (let* ((temp-file (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-inplace))
           (local-file (file-relative-name
                        temp-file
                        (file-name-directory buffer-file-name))))
      (list "~/.pyenv/shims/pyflakes"  (list local-file))))
  (add-to-list 'flymake-allowed-file-name-masks
               '("\\.py\\'" flymake-pyflakes-init)))
; show message on mini-buffer
(defun flymake-show-help ()
  (when (get-char-property (point) 'flymake-overlay)
    (let ((help (get-char-property (point) 'help-echo)))
      (if help (message "%s" help)))))
(add-hook 'post-command-hook 'flymake-show-help)

; autopep8
(add-to-list 'load-path "~/.emacs.d/elisp/pep8")
(require 'py-autopep8)
(add-hook 'before-save-hook 'py-autopep8-before-save)

;; change max line length to 160.
(setq py-autopep8-options '("--max-line-length=160"))

;; python mode.
(require 'python-mode)
(setq auto-mode-alist (cons '("\\.py\\'" . python-mode) auto-mode-alist))

(require 'jedi)
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:complete-on-dot t)
(setq ac-sources
      (delete 'ac-source-words-in-same-mode-buffers ac-sources)) ;; only use auto-completion of jedi.
(add-to-list 'ac-sources 'ac-source-filename)
(add-to-list 'ac-sources 'ac-source-jedi-direct)
(define-key python-mode-map "\C-cj" 'jedi:goto-definition)

(require 'virtualenvwrapper)
(require 'auto-virtualenvwrapper)
(add-hook 'python-mode-hook #'auto-virtualenvwrapper-activate)

;; python jedi
(add-hook 'python-mode-hook 'jedi:setup)
(setq jedi:setup-keys t)
(setq jedi:complete-on-dot t)
(setq jedi:server-args
      '("--sys-path" "~/.pyenv/versions/3.6.0/envs/default36/lib/python3.6/site-package"))

; insert encoding to python file at first line.
;(defun my-short-buffer-file-coding-system (&optional default-coding)
;  (let ((coding-str (format "%S" buffer-file-coding-system)))
;    (cond ((string-match "shift-jis" coding-str) 'shift_jis)
;          ((string-match "euc-jp" coding-str) 'euc-jp)
;          ((string-match "utf-8" coding-str) 'utf-8)
;      (t (or default-coding 'utf-8)))))


; python import sort.
(require 'pyimpsort)
(eval-after-load 'python
  '(define-key python-mode-map "\C-c\C-u" #'pyimpsort-buffer))


(defun my-insert-file-local-coding ()
  (interactive)
  (save-excursion
    (goto-line 2) (end-of-line) ; ２行目の行末の移動
    (let ((limit (point)))
      (goto-char (point-min))
      (unless (search-forward "coding:" limit t)
        (goto-char (point-min))
        ;; #!で始まる場合２行目に記述
        (when (and (< (+ 2 (point-min)) (point-max))
                   (string= (buffer-substring (point-min) (+ 2 (point-min))) "#!"))
          (unless (search-forward "\n" nil t)
            (insert "\n")))
        (let ((st (point)))
          (insert (format "-*- coding: %S -*-\n" (my-short-buffer-file-coding-system)))
          (comment-region st (point)))))))

; docker file mode
(add-to-list 'load-path "~/.emacs.d/elisp/docker/")
(require 'dockerfile-mode)
(add-to-list 'auto-mode-alist '("Dockerfile\\'" . dockerfile-mode))

;; flymake for haskell.
(require 'flymake-haskell-multi) ;; not needed if installed via package
(add-hook 'haskell-mode-hook 'flymake-haskell-multi-load)

;; braket pair.'
(electric-pair-mode 1)

;; c++
(require 'cc-mode)
(setq c-default-style "k&r")
(add-hook 'c-mode-common-hook
     	  '(lambda ()
             (progn
               (c-toggle-hungry-state 1)
               (setq c-basic-offset 4 indent-tabs-mode nil))))

(setq auto-mode-alist
      (append
       '(("\\.hpp$" . c++-mode)
         ("\\.h$"   . c++-mode)
         ) auto-mode-alist))


;; ac-php
(require 'cl)
(add-hook 'php-mode-hook
            '(lambda ()
               (auto-complete-mode t)
               (require 'ac-php)
               (setq ac-sources  '(ac-source-php ) )
               (yas-global-mode 1)
               (define-key php-mode-map  (kbd "C-]") 'ac-php-find-symbol-at-point)   ;goto define
               (define-key php-mode-map  (kbd "C-t") 'ac-php-location-stack-back   ) ;go back
               ))

;; golang flymake
(add-to-list 'load-path "~/go/src/github.com/dougm/goflymake")
(require 'go-flymake)


;; direx and popwin
(require 'popwin)
(popwin-mode 1)

(require 'direx)
(push '(direx:direx-mode :position left :width 25 :dedicated t)
      popwin:special-display-config)
(global-set-key (kbd "C-x C-k") 'direx:jump-to-directory-other-window)


;; use space for auto indent.
(setq-default indent-tabs-mode nil)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   (quote
    (dracula-theme auto-virtualenvwrapper virtualenvwrapper yaml-mode sql-indent quickrun python-mode pyimpsort py-autopep8 protobuf-mode powerline popwin neotree monokai-theme markdown-mode helm haskell-mode geiser flymake-haskell-multi ensime dirtree direx cython-mode color-theme-sanityinc-tomorrow cl-generic ac-php))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )


(require 'neotree)
(global-set-key [f8] 'neotree-toggle)

;; flymake for java.
(require 'flymake)
(add-hook 'java-mode-hook 'flymake-mode-on)

(defun my-java-flymake-init ()
  (list "javac" (list (flymake-init-create-temp-buffer-copy
                       'flymake-create-temp-with-folder-structure))))

(add-to-list 'flymake-allowed-file-name-masks '("\\.java$" my-java-flymake-init flymake-simple-cleanup))
