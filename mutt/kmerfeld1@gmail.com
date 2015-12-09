## Receive optionse
set imap_user=kmerfeld1@gmail.com
set imap_pass = `pass mutt/kmerfeld1@gmail.com`
set spoolfile = imaps://kmerfeld1@imap.gmail.com/
set postponed = +Drafts
set record = +Sent

## Send options.
set smtp_url=smtps://kmerfeld1@smtp.gmail.com
set realname='kmerfeld'
set from=kmerfeld1@gmail.com
set hostname="gmail.com"
set signature=""
# Connection options
set ssl_force_tls = yes
unset ssl_starttls

## Hook -- IMPORTANT!
account-hook $folder "set imap_user=kmerfeld1@gmail.com imap_pass=`pass mutt/kmerfeld1@gmail.com` "



