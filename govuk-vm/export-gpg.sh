# This would need to be run from vagrant directory
gpg --export --armor 0284252C078C3F92 | vagrant ssh -c 'gpg --import'
gpg --export-secret-key --armor 0284252C078C3F92 | vagrant ssh -c 'gpg --import --allow-secret-key-import'

# Don't forget to create a ~/.gnupg/gpg.conf file with use-agent in it to allow gpg to use the agent with git
