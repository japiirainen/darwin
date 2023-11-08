;;; theme/tweaks ---  -*- lexical-binding: t; -*-

;;; Commentary:
;; UI tweaks that don't really belong anywhere else

;;; Code:

(set-face-attribute 'default nil :family "DejaVUSansM Nerd Font" :height 140)

;; `hl-todo' allows us to nicely highlight things like
(use-package hl-todo
  :straight t
  :config
  (global-hl-todo-mode))

(provide 'theme/tweaks)
;;; theme.el ends here
