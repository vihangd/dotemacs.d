;;; custom --- Custom functions
;;; Commentary:
;;; Custom code
;;; Code:
(require 'projectile)

(defun appengine-server-start ()
  "Start appengine python server."
  (interactive)
  (projectile-with-default-dir (projectile-project-root)
    (async-shell-command "dev_appserver.py .")))

(provide 'custom-functions)
;;; custom-functions ends here
