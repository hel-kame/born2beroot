# CONFIGURE THE NETWORK
Hostname : login42

# SET UP USERS AND PASSWORDS
root $PASSWORD : Gallieni-42
user $(hel-kame) $PASSWORD : Zohra-75018

# PARTITIONS DISK
Manual > sda
sda1 > 500M > Mount to /boot
sda2 > MAXSIZE > Mount to none
Encrypted volume > $PASSWORD : Hithemleplusbeau-42!
Create logical volume group > Create volume group > "LVMGroup" > Add LVMGroup-$NAME
Give logical volume "Ext4 journaling file system" and his mount point, /!\ exception for swap, give him "swap area" type

# COMMAND MEMO

	## APPARMOR
		Check AppArmor status => "sudo aa-status"

	## USERS & GROUPS
		Create user => "sudo adduser $USERNAME"
		Create group => "addgroup $GROUP"
		Give user a group => "sudo usermod -aG $GROUP $USER"
		Show group => "getent group $GROUP" or "cat /etc/group | grep $GROUP"
		Change hostname => "/etc/hostname" or "hostnamectl set-hostname $NAME"

	## UFW
		Show netfilter => "sudo ufw status"
		Allow/deny port => "sudo ufw allow/deny $PORT"
		Delete action => "sudo ufw delete allow/deny $PORT"

	## PASSWORD POLICY
		Tools use => "libpam-pwquality"
		File to edit for passwords quality => "/etc/pam.d/common-password"
		File to edit for passwords duration => "/etc/login.defs"
		### PASSWORD OPTIONS
			Minimum 10 lines => "minlen=10"
			Minimun 1 uppercase char => "ucredit=-1"
			Minimum 1 digit => "dcredit=-1"
			Maximum 3 repeated char => "maxrepeat=3"
			Contains the username => "usercheck=1"
			Maximum 7 char from old password => "difok=7"
			Same root password policy (except for difok) => "enforce_for_root"

	## SUDO POLICY
		Maximum 3 attemps for password => "Defaults	passwd_tries=3"
		Custom bad password message => "Defaults	badpass_message=$MESSAGE"
		Archive sudo action => "Defaults	logfile="$JOURNAL_PATH""
		Archive input and output action => "Defaults	log_input, log_output"
		Active TTY for security reason => "Defaults	requiretty"

# BONUS

	## WORDPRESS
		MariaDB? => "A open-source MySQL Database server because Wordpress need it."
		Lightthpd? => "A web server for hosting website like Wordpress."
		PHP? => "A back-end langage used for Wordpress."

	## GIT SERVER
		Being git user => "su - git"
		$PASSWORD => "Monservice-42"
