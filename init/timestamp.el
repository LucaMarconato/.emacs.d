;--------TIMESTAMP--------
(require 'calendar)
 (defun insdate-insert-current-date (&optional omit-day-of-week-p)
    "Insert today's date using the current locale.
  With a prefix argument, the date is inserted without the day of
  the week."
    (interactive "P*")
    (insert (calendar-date-string (calendar-current-date) nil
                                  omit-day-of-week-p)))
(defun timestamp ()
  (interactive)
  (insert (format-time-string "%Y-%m-%d")))
;   (insert (format-time-string "%Y-%m-%d,%H:%M:%S")))

(defun month_timestamp ()
   (interactive)
   (insert (format-time-string "%Y-%m")))
(global-set-key "\C-x\M-d" `month_timestamp)
