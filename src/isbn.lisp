(in-package :cl-user)
(defpackage :isbn.search
  (:use :cl :arrow-macros)
  (:local-nicknames (:ascii-table :ascii-table)
                    (:cl-cookie   :cookie)
                    (:cl-ppcre    :ppcre)
                    (:clingon     :clingon)
                    (:dex         :dexador)
                    (:lquery      :lquery)
                    (:plump       :plump))
  (:export #:main))
(in-package :isbn.search)

(defun top-level/options ()
  "Returns the options for the top-level command"
  (list
   (clingon:make-option
    :string
    :description "Data to pass in the Cookie header. Data should be in the format `NAME1=VALUE1; NAME2=VALUE2' or a single filename."
    :short-name #\b
    :long-name "cookie"
    :key :cookie)))

(defun top-level/handler (cmd)
  "Top-level handler"
  (let* ((args (clingon:command-arguments cmd))
         (isbn (car args))
         (cookie (clingon:getopt cmd :cookie))
         (url (concatenate 'string "https://isbnsearch.org/isbn/" isbn))
         (headers `(("User-Agent" . "Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:132.0) Gecko/20100101 Firefox/132.0")
                    ("Accept-Encoding" . "deflate, gzip, br, zstd")
                    ("Cookie" . ,cookie)))
         (req (dex:get url :headers headers))
         (parsed (lquery:$ (lquery:initialize req)))
         (attrs (mapcar (lambda (s) (cl-ppcre:split ":\\s" s))
                        (coerce (lquery:$ parsed ".bookinfo p" (text))
                                'list)))
         (title (pushnew `("Title" ,@(-> (lquery:$ parsed ".bookinfo h1" (text))
                                       (coerce 'list)))
                         attrs))
         (names (mapcar #'car attrs))
         (vals (mapcar #'second attrs))
         (rows (-> (mapcar #'list names vals) reverse cdr reverse))
         (tbl (ascii-table:make-table '("ATTRIBUTE" "VALUE"))))
    (loop for row in rows
          do (eval `(ascii-table:add-row ,tbl ',row))
          finally (ascii-table:display tbl))))

(defun top-level/command ()
  "Creates and returns the top-level command"
  (clingon:make-command
   :name "isbn.search"
   :description "Search for an ISBN on `isbnsearch.org'."
   :usage "[-b <DATA|FILENAME>] <ISBN>"
   :options (top-level/options)
   :handler #'top-level/handler))

(defun main ()
  (let ((app (top-level/command)))
    (clingon:run app)))
