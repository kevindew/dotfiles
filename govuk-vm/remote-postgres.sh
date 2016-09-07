# running this multiple times will add this line multiple times
sudo sh -c 'echo "host  all     all 10.0.2.2/32 trust" >> /etc/postgresql/9.3/main/pg_hba.conf'
sudo service postgresql restart
