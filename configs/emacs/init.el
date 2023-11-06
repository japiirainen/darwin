;;; init -- The main init file -*- lexical-binding: t; -*-

;;; Commentary:


;;; Code:

;; Make sure that everything inside of our modules folder can actually
;; be loaded by Emacs.
(add-to-list 'load-path "~/.emacs.d/modules")

;; Core:
;; This loads the core functionality required to bootstrap the
;; rest of the configuration. This mostly involves bootstrapping `straight.el',
;; and getting `evil' + `general' all configured.
(require 'core/straight)
(require 'core/tweaks)
(require 'core/keys)

(require 'theme/modus)

(provide 'init)

;;; init.el ends here
