;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-
;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.

(require 'window-purpose)
(purpose-mode)
(minimap-mode)
(toggle-frame-fullscreen)

(use-package centaur-tabs
  :hook
  (after-init . centaur-tabs-mode)
  (dashboard-mode . centaur-tabs-local-mode)
  :config
  (setq centaur-tabs-style "bar"
        centaur-tabs-height 24
        centaur-tabs-set-icons t
        centaur-tabs-gray-out-icons 'buffer
        centaur-tabs-set-bar 'upper
        centaur-tabs-set-close-button nil
        centaur-tabs-set-modified-marker t
        centaur-tabs-modified-marker "●"
        centaur-tabs-cycle-scope 'tabs)

  (set-face-foreground 'centaur-tabs-selected "white")
  (set-face-background 'centaur-tabs-selected "#86a8b3")
  (set-face-foreground 'centaur-tabs-selected-modified "white")
  (set-face-background 'centaur-tabs-selected-modified "#8698b3")

  (set-face-foreground 'centaur-tabs-unselected "white")
  (set-face-background 'centaur-tabs-unselected "#739099")
  (set-face-foreground 'centaur-tabs-unselected-modified "white")
  (set-face-background 'centaur-tabs-unselected-modified "#738199")

  (set-face-background 'centaur-tabs-modified-marker-selected "#8698b3")
  (set-face-background 'centaur-tabs-modified-marker-unselected "#738199")

  (defun centaur-tabs-hide-tab (x)
  "Do no to show buffer X in tabs."
  (let ((name (format "%s" x)))
    (or
     ;; Current window is not dedicated window.
     (window-dedicated-p (selected-window))

     ;; Buffer name not match below blacklist.
     (string-prefix-p "*epc" name)
     (string-prefix-p "*vterm*" name)
     (string-prefix-p "*tide-server*" name)
     (string-prefix-p "*scratch*" name)
     (string-prefix-p "*helm" name)
     (string-prefix-p "*Helm" name)
     (string-prefix-p "*Compile-Log*" name)
     (string-prefix-p "*lsp" name)
     (string-prefix-p "*company" name)
     (string-prefix-p "*Flycheck" name)
     (string-prefix-p "*tramp" name)
     (string-prefix-p " *Mini" name)
     (string-prefix-p "*help" name)
     (string-prefix-p "*straight" name)
     (string-prefix-p " *temp" name)
     (string-prefix-p "*Help" name)
     (string-prefix-p "*mybuf" name)

     ;; Is not magit buffer.
     (and (string-prefix-p "magit" name)
          (not (file-name-extension name)))
     )))


  :bind
  ("C-x <C-right>" . centaur-tabs-forward)
  ("C-x <right>"   . centaur-tabs-forward)
  ("C-x <C-left>"  . centaur-tabs-backward)
  ("C-x <left>"    . centaur-tabs-backward)
)

(set-face-attribute 'default nil :height 135)

(setq user-full-name "Furkan Mudanyali"
      user-mail-address "fmudanyali@icloud.com")

(setq doom-theme 'light-blue
      doom-font (font-spec :family "Fantasque Sans Mono" :size 26 :weight 'light)
      doom-variable-pitch-font (font-spec :family "Helvetica Neue" :size 32))

(evil-ex-define-cmd "wq" 'save-and-kill-this-buffer)
(evil-ex-define-cmd "x" 'save-and-kill-this-buffer)
(defun save-and-kill-this-buffer()(interactive)(save-buffer)(kill-current-buffer))

(load-theme 'light-blue)

(defun open-terminal-and-buffer ()
  (split-window-vertically (floor (* 0.9 (window-height))))
  (other-window 1)
  (vterm)
  (purpose-toggle-window-buffer-dedicated)
  (add-hook 'dired-mode-hook 'centaur-tabs-local-mode)
  (other-window 1))

(add-hook 'emacs-startup-hook #'open-terminal-and-buffer)

(add-hook 'window-setup-hook #'+treemacs/toggle 'append)

(global-set-key (kbd "C-S-<left>") 'previous-buffer)
(global-set-key (kbd "C-S-<right>") 'next-buffer)
(global-set-key (kbd "C-x b") 'counsel-switch-buffer)
(global-set-key (kbd "C-x C-b") 'ibuffer)

(setq display-line-numbers-type t)
(setq org-directory "~/org/")
