#!/bin/bash
touch /var/log/mail.log && service postfix start && tail -f /var/log/mail.log
