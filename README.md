# TermuXBlacK
it is unofficial repository maintained by me @hax4us. you can check available packages in README

### List Of Available Packages
1. beef-xss
2. trape
3. ssh-honeypot
4. pdfcrack

#### How To Add x11-stable Repo (for gui packages)
1. Add new sources list file `mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://hax4us.github.io/termux-x/ x11-stable main" > $PREFIX/etc/apt/sources.list.d/hax4us_x11_stable.list`
2. enable x11 repo `apt install x11-repo`
3. add public key `wget https://hax4us.github.io/termux-x/hax4us.key && apt-key add hax4us.key`
3. Update `apt update`

#### Add pentesting repo (for pentesting packages)
1. Add new sources list file `mkdir -p $PREFIX/etc/apt/sources.list.d && printf "deb https://hax4us.github.io/termux-x/ pentesting main" > $PREFIX/etc/apt/sources.list.d/hax4us_pentesting.list`
2. add public key (same as above step 3)
3. Now update `apt update`

#### Inatall Any Package 
`apt install pkg_name`

#### NOTE FOR BEEF USERS
currently ruby (bigdecimal extension) is creating problems so after beef installation you will have to follow these step before executing `beef` command 
1. download the script `wget https://hax4us.github.io/files/fix-ruby-bigdecimal.sh`
2. run script `chmod +x fix-ruby-bigdecimal.sh && ./fix-ruby-bigdecimal.sh`

#### Packages Will Be Add As Per Your Demand Guys :) (Just Open Issue As A Package Request)
