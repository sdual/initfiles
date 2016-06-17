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
(add-to-list 'load-path "~/.go/src/github.com/nsf/gocode/emacs")
(require 'go-autocomplete)
(require 'auto-complete-config)
(ac-config-default)

;compile a program if you type the meta-key and 'p'
(global-set-key "\M-p" 'compile)


;; remove white scapse when save the file
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;; setting of keys
;; use ctr-h as backspace key
(global-set-key "\C-h" 'delete-backward-char)


;; setting of display
;; display line number
(global-linum-mode t)

;; dirtree
(require 'dirtree)

;; completion of brackets
(global-set-key (kbd "(") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "{") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "[") 'skeleton-pair-insert-maybe)
(global-set-key (kbd "\"") 'skeleton-pair-insert-maybe)
(setq skeleton-pair 1)

;; pair brackets
(show-paren-mode 1)


;; set themes 'monokai'
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(load-theme 'monokai t)

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


;; el-get sync
(add-to-list 'load-path "~/.emacs.d/el-get/el-get")

(unless (require 'el-get nil 'noerror)
  (with-current-buffer
      (url-retrieve-synchronously
       "https://raw.github.com/dimitri/el-get/master/el-get-install.el")
    (goto-char (point-max))
    (eval-print-last-sexp)))

(el-get 'sync)



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
