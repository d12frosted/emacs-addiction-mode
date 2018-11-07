;;; emacs-addiction-mode.el --- M-x doctor instead of C-x C-c
;;
;; Copyright (c) 2016-2018 Boris Buliga
;;
;; Author: Boris Buliga <boris@d12frosted.io>
;; URL: https://github.com/d12frosted/emacs-addiction-mode
;; Package-version: 0.5.0
;;
;; This file is not part of GNU Emacs.
;;
;;; License: GPLv3
;;
;;; Commentary:
;;
;; Keybinding for killing Emacs is an awful joke. It should not exist in the
;; first place. If I wanted to exit Emacs, I would call a doctor.
;;
;; `emacs-addiction-mode' comes into play. Quit killing Emacs. Raise your
;; addiction level and be happy about it.
;;
;; Call `emacs-addiction-mode' to turn it locally. Call
;; `global-emacs-addiction-mode' to turn it globally. Set your
;; `emacs-addiction-level' and conquer this Universe.
;;
;; Available levels:
;;
;; - neophyte - your addiction is new, so you are still unsure. You will be
;;   prompted if you really want to quit Emacs.
;;
;; - sane - On any attempt to kill Emacs you will be brought straight to the
;;   psychotherapist.
;;
;; - brian - you 'always look on the bright side of life'. So you don't need to
;;   kill Emacs.
;;
;;; Code:
;;

(define-minor-mode emacs-addiction-mode
  "Toggle Emacs addiction mode.

Interactively with no argument, this command toggles the mode. A
positive prefix argument enables the mode, any other prefix
argument disables it. From Lisp, argument omitted or nil enables
the mode, `toggle' toggles the state.

When Emacs addiction mode is enabled, you can't quit Emacs.

Literally. Depending on your `emacs-addiction-level'."
  :init-value nil
  :lighter " Addiction"
  :keymap '()
  :group 'emacs-addiction)

(define-key emacs-addiction-mode-map
  (kbd "C-x C-c")
  #'emacs-addiction-quit)

(define-globalized-minor-mode
  global-emacs-addiction-mode
  emacs-addiction-mode
  (lambda ()
    (emacs-addiction-mode 1)))

(define-minor-mode emacs-addiction-mode
  "Toggle Emacs addiction mode.

Interactively with no argument, this command toggles the mode. A
positive prefix argument enables the mode, any other prefix
argument disables it. From Lisp, argument omitted or nil enables
the mode, `toggle' toggles the state.

When Emacs addiction mode is enabled, you can't quit Emacs.

Literally. Based on your `emacs-addiction-level'."
  :init-value nil
  :lighter " Addiction"
  :keymap '())

(define-globalized-minor-mode
  global-emacs-addiction-mode
  emacs-addiction-mode
  (lambda ()
    (emacs-addiction-mode 1)))

(define-key emacs-addiction-mode-map
  (kbd "C-x C-c")
  #'emacs-addiction-kill)

(defgroup emacs-addiction nil
  "Stop killing Emacs."
  :prefix "emacs-addiction-"
  :group 'convenience)

(defcustom emacs-addiction-level 'neophyte
  "Defines the level of your Emacs addiction.

Available levels:

- neophyte - your addiction is new, so you are still unsure. You
  will be prompted if you really want to quit Emacs.

- sane - you are a sane person. Instead of killing Emacs you will
  be brought straight to the psychotherapist.

- brian - 'always look on the bright side of life'. You don't
  need to kill Emacs."
  :type '(choice
          (const :tag "Ask with y-or-n-p" neophyte)
          (const :tag "Call the doctor instead" sane)
          (const :tag "Always look on the bright side of life" brian)))

(defun emacs-addiction-kill ()
  "Kill Emacs depending on your `emacs-addiction-level'"
  (interactive)
  (pcase emacs-addiction-level
    ('barbarian (emacs-addiction-kill-as-barbarian))
    ('neophyte (emacs-addiction-kill-as-neophyte))
    ('brian (emacs-addiction-kill-as-brian))))

(defun emacs-addiction-kill-as-neophyte ()
  "Kill Emacs as a neophyte."
  (interactive)
  (when (y-or-n-p "Are you sure you want to betray your addiction and kill Emacs? ")
    (kill-emacs)))

(defun emacs-addiction-kill-as-sane ()
  "Kill Emacs as a sane person."
  (interactive)
  (call-interactively #'doctor))

(defun emacs-addiction-kill-as-brian ()
  "Kill Emacs as Brian."
  (interactive)
  (message "Always look on the bright side of life"))

(provide 'emacs-addiction-mode)

;;; emacs-addiction-mode.el ends here
