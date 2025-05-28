(defpackage :isbn-search-system
  (:use :cl :asdf))
(in-package #:isbn-search-system)

#+sb-core-compression
(defmethod asdf:perform ((o asdf:image-op) (c asdf:system))
  (uiop:dump-image (asdf:output-file o c) :executable t :compression t))

(asdf:defsystem "isbn.search"
  :name "isbn.search"
  :long-name "isbn.search"
  :description "Search for ISBN on `isbsearch.org'."
  :version "0.1"
  :depends-on (:arrow-macros
               :cl-ascii-table
               :cl-cookie
               :clingon
               :dexador
               :lquery
               :uiop)
  :components ((:module "search"
                :pathname #P"src/"
                :components ((:file "isbn"))))
  :build-operation "program-op"
  :entry-point "isbn.search:main")
