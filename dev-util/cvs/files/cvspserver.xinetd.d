service cvspserver
{
	disable		= yes
	socket_type	= stream
	wait		= no
	user		= cvs
	group		= cvs
	log_type	= FILE /var/log/cvspserver
	protocol	= tcp
	env		= HOME=/usr/local/cvsroot
	log_on_failure	+= USERID
	port		= 2401
	server		= /usr/bin/cvs
	server_args	= -f --allow-root=/usr/local/cvsroot pserver
}
