;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(setq doom-font (font-spec :family "Mononoki Nerd Font" :size 22)
     doom-variable-pitch-font (font-spec :family "Mononoki Nerd Font" :size 22))

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-unicode-font' -- for unicode glyphs
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:

;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-moonlight)
;;(setq doom-theme 'doom-henna)
;;(setq doom-theme 'doom-horizon)
(setq doom-theme 'doom-palenight)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org-notes/"
      org-startup-folded "fold")



;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;;------------------------------ My Config -----------------------------------------

;; exit insert mode using jk

(use-package! evil-escape

:init
(setq evil-escape-key-sequence "jj"))

;;-----------------------------------------------------------------------
;; Heading font size
 

(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.2))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.15))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.09))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.0))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.0))))
)

;;-----------------------------------------------------------------------

;; lsp enable in src block org mode

(cl-defmacro lsp-org-babel-enable (lang)
  "Support LANG in org source code block."
  (setq centaur-lsp 'lsp-mode)
  (cl-check-type lang stringp)
  (let* ((edit-pre (intern (format "org-babel-edit-prep:%s" lang)))
         (intern-pre (intern (format "lsp--%s" (symbol-name edit-pre)))))
    `(progn
       (defun ,intern-pre (info)
         (let ((file-name (->> info caddr (alist-get :file))))
           (unless file-name
             (setq file-name (make-temp-file "babel-lsp-")))
           (setq buffer-file-name file-name)
           (lsp-deferred)))
       (put ',intern-pre 'function-documentation
            (format "Enable lsp-mode in the buffer of org source block (%s)."
                    (upcase ,lang)))
       (if (fboundp ',edit-pre)
           (advice-add ',edit-pre :after ',intern-pre)
         (progn
           (defun ,edit-pre (info)
             (,intern-pre info))
           (put ',edit-pre 'function-documentation
                (format "Prepare local buffer environment for org source block (%s)."
                        (upcase ,lang))))))))
(defvar org-babel-lang-list
  '("go" "python" "ipython" "bash" "sh"))
(dolist (lang org-babel-lang-list)
  (eval `(lsp-org-babel-enable ,lang)))

;;-----------------------------------------------------------------------
;; abbrev-mode settings
 
(setq-default abbrev-mode t)
(setq save-abbrevs t)

;; Cursor postion in abbrevs file 
   (defadvice expand-abbrev (after my-expand-abbrev activate)
   ;; if there was an expansion
   (if ad-return-value
       ;; start idle timer to ensure insertion of abbrev activator
       ;; character (e.g. space) is finished
       (run-with-idle-timer 0 nil
                            (lambda ()
                              ;; if there is the string "@@" in the
                              ;; expansion then move cursor there and
                              ;; delete the string
                              (let ((cursor "@@"))
                                (if (search-backward cursor last-abbrev-location t)
                                    (delete-char (length cursor))))))))

;;-----------------------------------------------------------------------

;; Workspace management  M-7 will open private config files

;; Workspace number 7
(defun switch-to-private-config-workspace ()
  "Switch to the 'Private-config' workspace if it exists, otherwise create a new 'Private-config' workspace and switch to it."
  (interactive)
  (let ((workspace-name "7. Private-config"))
    (if (+workspace-exists-p workspace-name)
        (+workspace/switch-to workspace-name)
      (progn
        (+workspace/new workspace-name)
        (+workspace/switch-to workspace-name)
        (find-file "~/.doom.d/")))))  ;; here you can put your function

;; Key binding
(map! :g "M-7" #'switch-to-private-config-workspace)

;; Workspace number 2
(defun switch-to-org-roam-workspace ()
  "Switch to the 'Private-config' workspace if it exists, otherwise create a new 'Private-config' workspace and switch to it."
  (interactive)
  (let ((workspace-name "2. Org-roam"))
    (if (+workspace-exists-p workspace-name)
        (+workspace/switch-to workspace-name)
      (progn
        (+workspace/new workspace-name)
        (+workspace/switch-to workspace-name)
        (org-roam-node-find)))))  ;; here you can put your function

;; Key binding
(map! :g "M-2" #'switch-to-org-roam-workspace)


;;-----------------------------------------------------------------------

;; press 'g o' and go to another line without commenting it out

(defun append-line-comment-block ()
  "Appends a new line after a comment block without expanding it.
Calls `evil-append-line` and `+default/newline` in sequence."
  (interactive)
  (call-interactively 'evil-append-line)
  (call-interactively '+default/newline)
  )

(map!
  (:prefix "g"
    :desc "New line after comment block" :n "o" #'append-line-comment-block
   ))

;;-----------------------------------------------------------------------
;; yassnippet config
(after! yasnippet
  (yas-global-mode 1))

;;-----------------------------------------------------------------------

;; Tab jump out
(setq yas-fallback-behavior '(apply tab-jump-out 1))

;;-----------------------------------------------------------------------

;; Dired file manager new key bindings copied from dt
(map! :leader
      (:prefix ("d" . "dired")
       :desc "Open dired" "d" #'dired
       :desc "Dired jump to current" "j" #'dired-jump)
      (:after dired
       (:map dired-mode-map
        :desc "Peep-dired image previews" "d p" #'peep-dired
        :desc "Create empty file" "d c" #'dired-create-empty-file
        :desc "Dired view file"           "d v" #'dired-view-file)))

(evil-define-key 'normal dired-mode-map
  (kbd "M-RET") 'dired-display-file
  (kbd "h") 'dired-up-directory
  (kbd "l") 'dired-find-file 
  (kbd "m") 'dired-mark
  (kbd "t") 'dired-toggle-marks
  (kbd "u") 'dired-unmark
  (kbd "C") 'dired-do-copy
  (kbd "D") 'dired-do-delete
  (kbd "J") 'dired-goto-file
  (kbd "M") 'dired-do-chmod
  (kbd "O") 'dired-do-chown
  (kbd "P") 'dired-do-print
  (kbd "R") 'dired-do-rename
  (kbd "T") 'dired-do-touch
  (kbd "Y") 'dired-copy-filenamecopy-filename-as-kill ; copies filename to kill ring.
  (kbd "Z") 'dired-do-compress
  (kbd "+") 'dired-create-directory
  (kbd "-") 'dired-do-kill-lines
  (kbd "% l") 'dired-downcase
  (kbd "% m") 'dired-mark-files-regexp
  (kbd "% u") 'dired-upcase
  (kbd "* %") 'dired-mark-files-regexp
  (kbd "* .") 'dired-mark-extension
  (kbd "* /") 'dired-mark-directories
  (kbd "; d") 'epa-dired-do-decrypt
  (kbd "; e") 'epa-dired-do-encrypt)
;; Get file icons in dired
(add-hook 'dired-mode-hook 'all-the-icons-dired-mode)
;; With dired-open plugin, you can launch external programs for certain extensions
;; For example, I set all .png files to open in 'sxiv' and all .mp4 files to open in 'mpv'
(setq dired-open-extensions '(("gif" . "sxiv")
                              ("jpg" . "sxiv")
                              ("png" . "sxiv")
                              ("mkv" . "mpv")
                              ("mp4" . "mpv")))
;;-----------------------------------------------------------------------

 ;; Python setup

(after! python
  (setq python-shell-interpreter "python3") ; Set your preferred Python interpreter here
)

;; Enable auto-completion using Company mode
(add-hook 'python-mode-hook 'company-mode)

;; Enable LSP with Python language server
(use-package! lsp-python-ms :ensure t :hook (python-mode . lsp) :config (setq lsp-python-ms-auto-install-server t) ; Auto-install the language server if not found) Use Black for automatic code formatting (after! python (setq python-black-on-save-mode t)
)

;; ~/.doom.d/config.el
(setq +python-ipython-repl-args '("-i" "--simple-prompt" "--no-color-info"))
(setq +python-jupyter-repl-args '("--simple-prompt"))

;;-----------------------------------------------------------------------

;; org-roam-ui

(use-package! websocket
    :after org-roam)

(use-package! org-roam-ui
    :after org-roam ;; or :after org
;;         normally we'd recommend hooking orui after org-roam, but since org-roam does not have
;;         a hookable mode anymore, you're advised to pick something yourself
;;         if you don't care about startup time, use
;;  :hook (after-init . org-roam-ui-mode)
    :config
    (setq org-roam-ui-sync-theme t
          org-roam-ui-follow t
          org-roam-ui-update-on-save t
          org-roam-ui-open-on-start t))
;;-----------------------------------------------------------------------

;; org-remark settings

(org-remark-global-tracking-mode +1)

;; Optional if you would like to highlight websites via eww-mode
(with-eval-after-load 'eww
  (org-remark-eww-mode +1))

;; Optional if you would like to highlight EPUB books via nov.el
(with-eval-after-load 'nov
  (org-remark-nov-mode +1))
;; Key-bind `org-remark-mark' to global-map so that you can call it
;; globally before the library is loaded.

(define-key global-map (kbd "C-c n m") #'org-remark-mark)

;; The rest of keybidings are done only on loading `org-remark'
(with-eval-after-load 'org-remark
  (define-key org-remark-mode-map (kbd "C-c n o") #'org-remark-open)
  (define-key org-remark-mode-map (kbd "C-c n ]") #'org-remark-view-next)
  (define-key org-remark-mode-map (kbd "C-c n [") #'org-remark-view-prev)
  (define-key org-remark-mode-map (kbd "C-c n r") #'org-remark-remove))

;;-----------------------------------------------------------------------

;; org-journal mode settings

(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "* "
      org-journal-date-format "%a, %d-%m-%Y"
      org-journal-file-format "%d-%m-%Y.org"
)

;;-----------------------------------------------------------------------

;; org-roam mode
(after! org
(setq org-roam-directory "~/org-notes/roam/"
      org-roam-graph-viewer "/usr/bin/google-chrome"))

 (use-package org-roam
 :config
   (require 'org-roam-dailies) ;; Ensure the keymap is available
   (org-roam-db-autosync-mode))


 (map! :leader
       (:prefix ("n r" . "org-roam")
       :desc "Completion at point" "c" #'completion-at-point
 ;;       :desc "Find node"           "f" #'org-roam-node-find
 ;;       :desc "Show graph"          "g" #'org-roam-graph
 ;;       :desc "Insert node"         "i" #'org-roam-node-insert
 ;;       :desc "Capture to node"     "n" #'org-roam-capture
       :desc "journal"             "j" #'org-roam-dailies-map))

;; org-journal
 (setq org-roam-dailies-capture-templates
       '(("d" "default" entry "* %<%I:%M %p>: %?"
          :if-new (file+head "%<%d-%m-%Y>.org" "#+title: %<%d-%m-%Y>\n"))))


;;-----------------------------------------------------------------------

;; Rainbow mode
;;(define-globalized-minor-mode global-rainbow-mode rainbow-mode
;;  (lambda ()
;;  (when (not (memq major-mode
;;               (list 'org-agenda-mode)))
;;     (rainbow-mode 1))))
;;(global-rainbow-mode 1 )

;;-----------------------------------------------------------------------

;; emojis
 (use-package emojify
 :hook (after-init . global-emojify-mode))
;;-----------------------------------------------------------------------

;; org auto tangle

(use-package! org-auto-tangle
  :defer t
  :hook (org-mode . org-auto-tangle-mode)
  :config
  (setq org-auto-tangle-default t))

(defun dt/insert-auto-tangle-tag ()
  "Insert auto-tangle tag in a literate config."
  (interactive)
  (evil-org-open-below 1)
  (insert "#+auto_tangle: t ")
  (evil-force-normal-state))

(map! :leader
      :desc "Insert auto_tangle tag" "i a" #'dt/insert-auto-tangle-tag)

;;-----------------------------------------------------------------------
