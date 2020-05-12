;;; package --- Summary

;;; Commentary:


;;; Code:
(setq gnutls-algorithm-priority "NORMAL:-VERS-TLS1.3")

(setq
 user-name "Sergey Makarov"
 user-mail-address "setser200018@gmail.com"
 mml-secure-openpgp-signers '("93B7064B")
 gnus-select-method
 '(nnimap "gmail"
          (nnimap-address "imap.gmail.com")
          (nnimap-server-port 993)
          (nnimap-stream ssl)
          (nnir-search-engine imap)
          (nnmail-expiry-target "nnimap+gmail:[Gmail]/Trash"))
 smtpmail-smtp-server "smtp.gmail.com"
 smtpmail-smtp-service 587
 message-send-mail-function 'smtpmail-send-it
 gnus-ignored-newsgroups "^to\\.\\|^[0-9. ]+\\( \\|$\\)\\|^[\"]\"[#'()]"
 gnus-agent nil
 gnus-message-archive-group nil)

(add-to-list 'gnus-secondary-select-methods
             '(nnimap "ispras"
                      (nnimap-address "mail.ispras.ru")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)))
(add-to-list 'gnus-secondary-select-methods
             '(nnimap "MSU"
                      (nnimap-address "stud.cs.msu.ru")
                      (nnimap-server-port 993)
                      (nnimap-stream ssl)))