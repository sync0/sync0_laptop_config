(package-initialize)
(require 'org)
(org-babel-load-file
 (expand-file-name "emacs_settings.org"
                   user-emacs-directory))
