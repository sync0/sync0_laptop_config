;; Variables
(setq sync0-bibtex-types '("Manual" "Patent" "Report" "Thesis" "Article" "Paper"))

(setq sync0-bibtex-simon-arkseries '("Personal Pappers (1929-1979)" "Schoolwork and Early Career (1929-1943)" "Illinois Institute of Technology (1942-1949)" "RAND Corporation (1949-1973)" "Carnegie Mellon University (1948-2001)" "Consulting (1942-2000)" "Lectures and Talks (1951-2000)" "Publications (1949-2000)" "Correspondence (1940-2001)" "Dissertations (1956-1999)" "Awards (1958-1998)" "Miscellaneous (1942-2003)"))

;; Functions
(defun sync0-print-bibtex-key ()
  "Print the bibtex key of the document"
  (if  (save-excursion 
               (goto-char (point-min))
        (re-search-forward "#\\+ROAM_KEY: cite:\\([[:graph:]]+\\)" nil t 1))
      (match-string 1)
    (save-excursion
             (when 
                 (or (re-search-backward "cite:\\([[:graph:]]+\\)\\]\\[[[:digit:]]+\\]\\]" nil t 1)
                 (re-search-backward "cite\\[[[:digit:]]+\\]{\\([[:graph:]]+\\)}" nil t 1))
               (match-string 1)))))

(defun sync0-org-roam-notetaking-headline-function ()
  "Print an org headline with the bibtex key and some information"
(concat (sync0-print-bibtex-key) "_" (format-time-string "%Y%m%d%H%M")))


(defun sync0-last-cited-page ()
  "Search for the page cited in the last quote environment"
  (save-excursion
    (cond
      ((re-search-backward "\\[\\[[[:graph:]]+\\]\\[\\([[:digit:]]+\\)\\]\\]" nil t 1)
             (match-string 1))
            ((re-search-backward "cite\\[\\([[:digit:]]+\\)\\]{[[:graph:]]+}}\\]" nil t 1)
              (match-string 1)))))

(defun sync0-last-cited-author ()
  "Search for the page cited in the last quote environment"
  (save-excursion
    (when 
        (re-search-backward "cite\\[.*\\]{\\(.+\\)}" nil t 1)
      (match-string 1))))

(defun sync0-bibtex-extract-editors ()
  "Extract the author or editor from entry as string"
  (interactive)
  (save-excursion
    (re-search-backward "^editor")
    (search-forward "= ")
    (let* ((authorstring (progn (looking-at "{.+}")(match-string 0)))
           (firstlast (substring authorstring 1 -1)))
      (if  (string-match "and" firstlast)
          (let* ((authors (split-string firstlast "and"))
                 (f_lastname (let* ((first (nth 0 authors))
                                    (twoparts (split-string first ",")))
                               (nth 0 twoparts)))
                 (s_lastname (let* ((first (nth 1 authors))
                                    (twoparts (split-string first ",")))
                               (nth 0 twoparts))))
            (format "%s,%s" f_lastname s_lastname))
        (let* ((twoparts (split-string firstlast ","))
               (lastname  (elt twoparts 0)))
          (format "%s" lastname))))))

(defun sync0-bibtex-extract-lastnames ()
  "Extract the author or editor from entry as string"
  (interactive)
  (save-excursion
    (re-search-backward "^author")
    (search-forward "= ")
    (let* ((authorstring (progn (looking-at "{.+}")(match-string 0)))
           (firstlast (substring authorstring 1 -1)))
      (if  (string-match "and" firstlast)
          (let* ((authors (split-string firstlast "and"))
                 (f_lastname (let* ((first (nth 0 authors))
                                    (twoparts (split-string first ",")))
                               (nth 0 twoparts)))
                 (s_lastname (let* ((first (nth 1 authors))
                                    (twoparts (split-string first ",")))
                               (nth 0 twoparts))))
            (format "%s,%s" f_lastname s_lastname))
        (let* ((twoparts (split-string firstlast ","))
               (lastname  (elt twoparts 0)))
          (format "%s" lastname))))))

(defun sync0-bibtex-extract-editors-lowercase ()
  "Extract the author or editor from entry as string"
  (interactive)
  (save-excursion
    (re-search-backward "^editor")
    (search-forward "= ")
    (let* ((authorstring (progn (looking-at "{.+}")(match-string 0)))
           (firstlast (substring authorstring 1 -1)))
      (if  (string-match "and" firstlast)
          (let* ((authors (split-string firstlast "and"))
                 (f_author (let* ((first (nth 0 authors))
                                  (twoparts (split-string first ","))
                                  (lastname (nth 0 twoparts))
                                  (firstnamespace (nth 1 twoparts))
                                  (firstname (substring firstnamespace 1 -1))
                                  (downlastname  (downcase lastname))
                                  (downfirstname  (downcase firstname)))
                             (format "%s-%s" downlastname downfirstname)))
                 (s_author (let* ((first (nth 1 authors))
                                  (twoparts (split-string first ","))
                                  (lastnamespace (nth 0 twoparts))
                                  (firstnamespace (nth 1 twoparts))
                                  (lastname (substring lastnamespace 1))
                                  (firstname (substring firstnamespace 1))
                                  (downlastname  (downcase lastname))
                                  (downfirstname  (downcase firstname)))
                             (format "%s-%s" downlastname downfirstname))))
            (format "%s, %s" f_author s_author))
        (let* ((twoparts (split-string firstlast ","))
               (lastname  (elt twoparts 0))
               (firstnamespace  (elt twoparts 1))
               (firstname (substring firstnamespace 1))
               (downlastname  (downcase lastname))
               (downfirstname  (downcase firstname)))
          (format "%s-%s" downlastname downfirstname))))))

(defun sync0-bibtex-extract-lastnames-lowercase ()
  "Extract the author or editor from entry as string"
  (interactive)
  (save-excursion
    (re-search-backward "^author")
    (search-forward "= ")
    (let* ((authorstring (progn (looking-at "{.+}")(match-string 0)))
           (firstlast (substring authorstring 1 -1)))
      (if  (string-match "and" firstlast)
          (let* ((authors (split-string firstlast "and"))
                 (f_author (let* ((first (nth 0 authors))
                                  (twoparts (split-string first ","))
                                  (lastname (nth 0 twoparts))
                                  (firstnamespace (nth 1 twoparts))
                                  (firstname (substring firstnamespace 1 -1))
                                  (downlastname  (downcase lastname))
                                  (downfirstname  (downcase firstname)))
                             (format "%s-%s" downlastname downfirstname)))
                 (s_author (let* ((first (nth 1 authors))
                                  (twoparts (split-string first ","))
                                  (lastnamespace (nth 0 twoparts))
                                  (firstnamespace (nth 1 twoparts))
                                  (lastname (substring lastnamespace 1))
                                  (firstname (substring firstnamespace 1))
                                  (downlastname  (downcase lastname))
                                  (downfirstname  (downcase firstname)))
                             (format "%s-%s" downlastname downfirstname))))
            (format "%s, %s" f_author s_author))
        (let* ((twoparts (split-string firstlast ","))
               (lastname  (elt twoparts 0))
               (firstnamespace  (elt twoparts 1))
               (firstname (substring firstnamespace 1))
               (downlastname  (downcase lastname))
               (downfirstname  (downcase firstname)))
          (format "%s-%s" downlastname downfirstname))))))

(yas-reload-all)

(provide 'sync0-yasnippet-bibtex)
