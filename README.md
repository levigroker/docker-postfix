docker-postfix
==============

Run [Postfix](http://www.postfix.org) with SMTP authentication (sasldb) in a docker container.
TLS and OpenDKIM support are optional.

### Requirement
+ [Docker](https://www.docker.com) 1.0

### Installation
1. Build image

	```bash
	$ sudo docker pull levigroker/postfix
	```

### Usage
1. Create postfix container with smtp authentication

	```bash
	$ docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			--name postfix -d levigroker/postfix
	# Set multiple user credentials: -e smtp_user=user1:pwd1,user2:pwd2,...,userN:pwdN
	```
2. Enable OpenDKIM: save your domain key ```.private``` in ```/path/to/domainkeys```

	```bash
	$ docker run -p 25:25 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-v /path/to/domainkeys:/etc/opendkim/domainkeys \
			--name postfix -d levigroker/postfix
	```
3. Enable TLS(587): save your SSL certificates ```.key``` and ```.crt``` to  ```/path/to/certs```

	```bash
	$ docker run -p 587:587 \
			-e maildomain=mail.example.com -e smtp_user=user:pwd \
			-v /path/to/certs:/etc/postfix/certs \
			--name postfix -d levigroker/postfix
	```

#### Note
+ Login credentials should be set to (`username@mail.example.com`, `password`) in SMTP client
+ You can assign the port of MTA on the host machine to one other than 25 ([postfix how-to](http://www.postfix.org/MULTI_INSTANCE_README.html))
+ Read the reference below to find out how to generate domain keys and add public key to the domain's DNS records

#### Reference
+ [Postfix SASL How To](http://www.postfix.org/SASL_README.html)
+ [How To Install and Configure DKIM with Postfix on Debian Wheezy](https://www.digitalocean.com/community/articles/how-to-install-and-configure-dkim-with-postfix-on-debian-wheezy)

#### Disclaimer and Licence

* Forked from (https://github.com/catatnight/docker-postfix)[https://github.com/catatnight/docker-postfix]
* This work is licensed the MIT license.
  Please see the included LICENSE.txt for complete details.

#### About
A professional iOS engineer by day, my name is Levi Brown. Authoring a blog
[grokin.gs](http://grokin.gs), I am reachable via:

Twitter [@levigroker](https://twitter.com/levigroker)  
Email [levigroker@gmail.com](mailto:levigroker@gmail.com)  

Your constructive comments and feedback are always welcome.

