(defpackage :isbn-search-system
  (:use :cl :asdf))
(in-package #:isbn-search-system)

(asdf:defsystem "isbn.search"
  :name "isbn.search"
  :long-name "isbn.search"
  :description "Search for ISBN on `isbsearch.org'."
  :version "0.1"
  :depends-on (:arrow-macros
               :cl-ascii-table
               :cl-cookie
               :cl-ppcre
               :clingon
               :dexador
               :lquery)
  :components ((:module "search"
                :pathname #P"src/"
                :components ((:file "isbn"))))
  :build-operation "program-op"
  :entry-point "isbn.search:main")
