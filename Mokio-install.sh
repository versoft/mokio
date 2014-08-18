#!/bin/bash

DEVELOPMENT_MODE=true       # true for mokio in development
LOGFILE="mokio-install.log" # Simple user does not need to see all standard output informations
ADAPTERS=(mysql2 sqlite3)   # Database adapters
RAILS_VERSION="=4.1.1"      # Currently used rails version with Mokio gem is 4.1.1 (may change still in development)


#
# arguments to use, aka flags
#
case $1 in
  -h|--help )
    echo  "
      General options:
      (-h) --help               You are here [ help c(: ]
      (-i) --info               Installator informations

      Installation options:
      (-l) --lib                Install only libraries
      (-a) --app                Install only application
      (-r) --rails \"version\"    Install with other rails version than specified in Mokio gem (not recommended)"
    exit
  ;;

  -i|--info )
    echo "
      1. Libraries installed with rvm:
        gawk g++ libreadline6-dev zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev
        sqlite3 autoconf libgdbm-dev libcurses5-dev automake libtool bison libffi-dev

      2. Libraries installed with nodejs
        libc-ares2 libv8-3.14.5

      3. Installing ruby 2.1.1
        There are no binary rubies available for ubuntu/13.10/x86_64/ruby-2.1.1 so it has to be compiled.
        Installing with rvm you can read 'rvm help mount' to get more information on binary rubies.
        Low performance computer downoloading, installation, compiling time - +/- 15min

      4. Libraries installed with libmagickwand-dev for rmagick
        gir1.2-rsvg-2.0 imagemagick-common libbz2-dev libcairo-script-interpreter2 libcairo2-dev
        libcdt4 libcgraph5 libdjvulibre-dev libexif-dev libexpat1-dev libfftw3-double3
        libfontconfig1-dev libfreetype6-dev libgdk-pixbuf2.0-dev libglib2.0-dev libgraph4
        libgraphviz-dev libgvc5 libgvpr1 libice-dev libilmbase-dev libilmbase6 libjasper-dev
        libjbig-dev libjpeg-dev libjpeg-turbo8-dev libjpeg8-dev libjs-jquery liblcms2-dev
        liblqr-1-0 liblqr-1-0-dev libltdl-dev liblzma-dev libmagickcore-dev libmagickcore5
        libmagickcore5-extra libmagickwand-dev libmagickwand5 libopenexr-dev libopenexr6
        libpathplan4 libpcre3-dev libpcrecpp0 libpixman-1-dev libpng12-dev libpthread-stubs0
        libpthread-stubs0-dev librsvg2-dev libsm-dev libtiff5-dev libtiffxx5 libwmf-dev
        libx11-dev libx11-doc libxau-dev libxcb-render0-dev libxcb-shm0-dev libxcb1-dev
        libxdmcp-dev libxdot4 libxext-dev libxml2-dev libxrender-dev libxt-dev x11proto-core-dev
        x11proto-input-dev x11proto-kb-dev x11proto-render-dev x11proto-xext-dev
        xorg-sgml-doctools xtrans-dev

      5. Libraries for Nokogiri
        libxslt-dev libxml2-dev libxslt1-dev

      6. Mokio gem dependicies (may change still in development)
        'rake',                        '>= 10.3.1'
        'rails',                       '>= 4.0.3'

        'sass-rails',                  '~> 4.0.0', '>= 4.0.2'
        'coffee-rails',                '~> 4.0.0'
        'haml-rails',                  '>= 0.5.3'
        'fancybox2-rails',             '>= 0.2.8'
        'sunspot_rails',               '>= 2.1.0'

        'jquery-rails',                '>= 3.1.0'
        'jquery-ui-rails',             '>= 4.2.1'
        'jquery-fileupload-rails',     '>= 0.4.1'
        'jquery-datatables-rails',     '>= 1.12.2'

        'bootstrap-wysihtml5-rails',   '~> 0.3.1.23'
        'bootstrap-switch-rails',      '2.0.0' # TODO problems with > 2.0.0

        'uglifier',                    '>= 1.3.0'
        'cancancan',                   '~> 1.7'  
        'simple_form',                 '>= 3.0.2'
        'ckeditor',                    '>= 4.0.8'
        'carrierwave',                 '>= 0.10.0'
        'rmagick',                     '>= 2.13.2'
        'mini_magick',                 '>= 3.7.0'
        'amoeba',                      '>= 2.0.0'           
        'youtube_it',                  '>= 2.1.4'
        'ancestry',                    '>= 2.1.0'
        'acts_as_list',                '>= 0.4.0'
        'will_paginate',               '>= 3.0.5'
        'faraday',                     '>= 0.7.6'
        'validates',                   '>= 0.0.8'
        'friendly_id',                 '>= 5.0.3'            
        'video_info',                  '>= 2.3.1'
        'disqus',                      '>= 1.0.4'
        'devise',                      '>= 3.2.4'
        'role_model',                  '>= 0.8.1'
        'deface',                      '>= 1.0.0'"
    exit
  ;;

  -a|--app )
    INSTALL_TYPE="app"
  ;;

  -l|--lib )
    INSTALL_TYPE="lib"
  ;;

  -r|--rails )
    RAILS_VERSION="=$2"
  ;;

  *)
    INSTALL_TYPE="full"
  ;;
esac


#
# ================================ Callbacks =========================================
#
  function beforeScript() {
    # Null for now. May be useful in future updates
    :
  }

  function afterScript() {
    # Null for now. May be useful in future updates
    :
  }

  function beforeInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function afterInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function beforeLibInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function afterLibInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function beforeAppInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function afterAppInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function beforeBundleInstall() {
    # Null for now. May be useful in future updates
    :
  }

  function afterBundleInstall() {
    # Null for now. May be useful in future updates
    :
  }
#
# ================================ Main ==============================================
#
  function __main__() {
    beforeInstall
    check_and_install
    afterInstall
  }
#
# =========================== Core Installation ======================================
#
  function check_and_install() {
    if [[ $INSTALL_TYPE != "app" ]]; then
      beforeLibInstall
      install_libraries
      afterLibInstall
    fi

    if [[ $INSTALL_TYPE != "lib" ]]; then
      beforeAppInstall
      install_application
      afterAppInstall
    fi
  }

  function install_libraries() {
    local libs="libmagickwand-dev libxslt1-dev libxml2-dev nodejs curl imagemagick"

    if [[ $(getOS) =~ "Ubuntu" || $(getOS) =~ "Debian" ]]; then
      apt_get_install $libs
    else
      echo "Unknown OS. Cannot specify method to download required libraries."
      exit
    fi

    get_and_install_rails_with_rvm
  }

  function install_application() {
    read_app_name
    generate_app_files
    create_gemfile
    create_db_config

    mv $LOGFILE $APP_NAME
    cd $APP_NAME
    GEMFILE="Gemfile"

    run_bundle_install
    run_mokio_install
  }
#
# ========================= Get Os type from /etc/*-release ==========================
#
  function getOS() {
    echo $(cat /etc/*-release | sed -e 's/DISTRIB_ID=//g' | sed ':a;N;$!ba;s/\n/ /g' | sed -e 's/DISTRIB_RELEASE.*$//')
  }
#
# =============================== Ubuntu & Debian =====================================
#
  function apt_get_install() {
    local libs=$@
    local missing_libs=$(chose_libs_to_install $libs)

    apt_get_update   

    if [[ ! -z $missing_libs ]]; then
      sudo apt-get install $missing_libs
    fi

    get_rvm_with_curl
    reaload_bash_profile
  }

  function chose_libs_to_install() {
    local libs=$@
    local not_installed_libs=()

    for i in $libs; do
      if [[ $(apt_get_package_status $i) != "installed" ]]; then
        not_installed_libs+="$i "
      fi
    done 

    echo ${not_installed_libs[@]}
  }

  function apt_get_package_status() {
    local package=$1
    local status=$( dpkg -s $package | grep Status | sed -e 's/Status://g' )

    if [[ $status =~ "install ok installed" ]]; then
      echo "installed"
    else
      echo "not_installed"
    fi
  }

  function apt_get_update() {
    sudo apt-get update
  }

  function get_rvm_with_curl() {
    \curl -sSL https://get.rvm.io | bash
  }

  function reaload_bash_profile() {
    source ~/.bash_profile
    . ~/.bash_profile
    /bin/bash -c 'source ~/.bash_profile'
  }
#
# ============================== RVM & Ruby & Rails ==================================
#
  function get_and_install_rails_with_rvm() {
    get_rvm
    get_ruby
    use_ruby
    get_rails
  }

  function get_rvm() {
    rvm get stable --autolibs=enable
  }

  function get_ruby() {
    rvm install 2.1.1
  }

  function use_ruby() {
    rvm use ruby-2.1.1
  }

  function get_rails() {
    gem install rails --version "$RAILS_VERSION"
  }
#
# ============================ Creating Application ==================================
#
  function read_app_name() {
    echo -e '\nName your application: '
    read APP_NAME

    check_app_name
    specify_file_paths
  }

  function check_app_name() {
    while [[ -z $APP_NAME ]]; do
      echo 'Cannot be blank!'
      read APP_NAME
    done
    APP_NAME=$(echo "$APP_NAME" | tr '[:upper:]' '[:lower:]')
  }

  function specify_file_paths() {
    GEMFILE="$APP_NAME/Gemfile"
    DATABASE_YML="$APP_NAME/config/database.yml"
  }

  function generate_app_files() {
    echo -e 'Generating application files...\n'
    rails new $APP_NAME --skip-bundle > $LOGFILE
    check_generating_app_files
  }

  function check_generating_app_files() {
    while read line; do
      if [[ ! $line =~ "create" ]]; then
        echo 'Error while generating application files check' $LOGFILE
        exit
      fi
    done < $LOGFILE
  }
#
# ============================ Creating Gemfile ======================================
#
  function create_gemfile() {
    rubygems_source
    create_default_gemfile
    choose_db_adapter
    add_gem $DATABASE
    add_mokio_gem
  }

  function rubygems_source() {
    echo "source 'https://rubygems.org'" > $GEMFILE
  }

  function create_default_gemfile() {
    echo "
  # Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
  gem 'jbuilder', '~> 1.2'

  # Use ActiveModel has_secure_password
  # gem 'bcrypt-ruby', '~> 3.1.2'

  # Use unicorn as the app server
  # gem 'unicorn'

  # Use Capistrano for deployment
  # gem 'capistrano', group: :development

  # Use debugger
  # gem 'debugger', group: [:development, :test]

  # See https://github.com/sstephenson/execjs#readme for more supported runtimes
  # gem 'therubyracer', platforms: :ruby

  group :doc do
     # bundle exec rake doc:rails generates the API under doc/api.
    gem 'sdoc', require: false
  end" >> $GEMFILE
  }

  function add_mokio_gem() {
    if [[ $DEVELOPMENT_MODE = true ]]; then
      echo -e "\ngem 'mokio', :git => 'git@kura.goodone.pl:ruby/mokio.git'" >> $GEMFILE
    else
      echo -e "\ngem 'mokio'" >> $GEMFILE
    fi 
  }

  function add_gem() {
    echo -e "\ngem '$1'" >> $GEMFILE
  }

#
# ============================ Database config ====================================
#
  function choose_db_adapter() {
    echo "Database adapter (${ADAPTERS[@]}):"
    read DATABASE
    check_db_adapter
  }

  function check_db_adapter() {
    is_adapter=false

    while [[ $is_adapter = false ]]; do
      for item in ${ADAPTERS[@]}; do
        if [[ $item = $DATABASE ]]; then
          is_adapter=true
        fi
      done

      if [[ $is_adapter = false ]]; then
        echo 'Wrong value choose another adapter'
        read DATABASE
      fi
    done   
  }

  function create_db_config() {
    if [[ $DATABASE = "mysql2" ]]; then
      if [[ $(check_msql2_server) != "not_installed" ]]; then
        devname=$APP_NAME"_dev"

        echo -e "development:
      adapter: mysql2
      encoding: utf8
      database: $devname
      pool: 5
      username: $devname
      password: $devname
      socket: /var/run/mysqld/mysqld.sock" > $DATABASE_YML
      fi
    fi
  }
#
# ======================= Mysql2 ==============================================
# 
  function check_msql2_server() {
    if [[ $(getOS) =~ "Ubuntu" || $(getOS) =~ "Debian" ]]; then
      if [[ $(apt_get_package_status mysql-server) != "installed" ]]; then
        echo "mysql-server packages are not installed. Install now? (y/n)"
        read install_myslq

        if [[ $install_myslq = "y" ]]; then
          apt_get_install_mysql_server
        else
          echo "not_installed"
        fi
      fi

      if [[ $(apt_get_package_status libmysql-ruby) != "installed" ]]; then
        echo "mysql-server packages are not installed. Install now? (y/n)"
        read install_myslq

        if [[ $install_myslq = "y" ]]; then
          apt_get_install_mysql_server
        else
          echo "not_installed"
        fi
      fi

      if [[ $(apt_get_package_status libmysqlclient-dev) != "installed" ]]; then
        echo "mysql-server packages are not installed. Install now? (y/n)"
        read install_myslq

        if [[ $install_myslq = "y" ]]; then
          apt_get_install_mysql_server
        else
          echo "not_installed"
        fi
      fi
    fi
  }

  function apt_get_install_mysql_server() {
    sudo apt-get install mysql-server libmysqlclient-dev libmysql-ruby
  }
#
# ======================= After creating application =========================
#
  function run_bundle_install() {
    beforeBundleInstall

    echo -e '\nInstalling gems dependencies...'
    bundle install >> $LOGFILE

    if [[ $(checkBundleInstall) = false ]]; then
      echo 'Error while installing gems, check' $LOGFILE
      exit
    else
      echo -e '\nGems installed.'
    fi

    afterBundleInstall
  }

  function checkBundleInstall() {
    local installed=false

    while read line; do
      if [[ $line =~ "complete" ]]; then
        installed=true
      fi
    done < $LOGFILE

    echo $installed
  }

  function run_mokio_install() {
    echo -e "\nRunning Mokio built-in installer"
    rake mokio:install
  }
#
# ==============================================================================
#

# ------------------ #
beforeScript
# ------------------ #



# ================================== #
#         Calling __main__           #
# ================================== #
__main__




# ------------------ #
afterScript
# ------------------ #