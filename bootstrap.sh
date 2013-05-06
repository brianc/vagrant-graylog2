sudo apt-key adv --keyserver keyserver.ubuntu.com --recv 7F0CEB10
echo 'deb http://downloads-distro.mongodb.org/repo/debian-sysvinit dist 10gen' | sudo tee /etc/apt/sources.list.d/10gen.list
sudo apt-get update
#sudo apt-get upgrade -y
sudo apt-get --no-install-recommends install build-essential openssl libreadline6 mongodb-10gen libreadline6-dev curl git-core zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt-dev autoconf libc6-dev libcurl4-openssl-dev libgdbm-dev ncurses-dev automake libtool bison pkg-config vim libffi-dev openjdk-6-jre -y
cd /home/vagrant
git clone git://github.com/brianc/vim-config --recursive
ln -s vim-config/.vim
ln -s vim-config/.vimrc
sudo apt-get install tmux -y
git clone git://github.com/brianc/myiptables
ln -s myiptables/.tmux.conf
wget http://download.graylog2.org/graylog2-server/graylog2-server-0.11.0.tar.gz
tar xzvf graylog2-server-0.11.0.tar.gz
wget https://download.elasticsearch.org/elasticsearch/elasticsearch/elasticsearch-0.20.4.tar.gz
tar xzvf elasticsearch-0.20.4.tar.gz
cd /home/vagrant
cd graylog2-server-0.11.0
cp elasticsearch.yml.example /etc/graylog2-elasticsearch.yml
cd /home/vagrant/elasticsearch-0.20.4
echo "cluster.name: graylog2" >> /home/vagrant/elasticsearch-0.20.4/config/elasticsearch.yml

cd /home/vagrant
wget http://download.graylog2.org/graylog2-web-interface/graylog2-web-interface-0.11.0.tar.gz
tar xzvf graylog2-web-interface-0.11.0.tar.gz
# ruby & graylog2-web-server
echo "now, brave soldier, you install ruby yourself."
wget ftp://ftp.ruby-lang.org/pub/ruby/1.9/ruby-1.9.3-p392.tar.gz
tar xzvf ruby-1.9.3-p392.tar.gz
rm *.gz
cd ruby-1.9.3-p392
./configure --disable-install-rdoc
make -j 2
make install
gem update --system
gem install bundler --no-ri --no-rdoc
gem install passenger --no-ri --no-rdoc
cd /home/vagrant/graylog2-web-interface-0.11.0
bundle install
passenger package-runtime
cd /home/vagrant
chown -R vagrant:vagrant .
