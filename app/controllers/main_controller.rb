class MainController < ApplicationController
	before_filter :authenticate_user!

	def new
    	@master = Main.new
	end

	def create
	    @master = Main.create(conf_params) 
	end

	def update
    	@master.update_attributes(conf_params)
	end

	def destroy
	    @master.destroy
	end

	def index
		@user = current_user
	end

	def guide
		@user = current_user
	end

	def config_files
		@user = current_user
	end

	def activities
		@user = current_user
		@activities = @user.log.all()
	end

	def admin_users
		@user = current_user
		if @user.email != ENV['ADMIN_EMAIL']
			redirect_to action: "index"
		else
			@users = User.order("id DESC").all()
		end
	end

	def download_config
		@filename ="#{Rails.root}/downloads/client.ovpn"
		send_file(@filename ,
		  :type => 'application/ovpn',
		  :disposition => 'attachment',
		  :x_sendfile=>true)    
	end

	def download_win_32
		@filename ="#{Rails.root}/downloads/Shadowsocks-win-2.3.zip"
		send_file(@filename ,
		  :type => 'application/exe',
		  :disposition => 'attachment',
		  :x_sendfile=>true)    
	end

	def download_win_64
		@filename ="#{Rails.root}/downloads/openvpn-install-2.3.7-I602-x86_64.exe"
		send_file(@filename ,
		  :type => 'application/exe',
		  :disposition => 'attachment',
		  :x_sendfile=>true)    
	end

	def download_mac
		@filename ="#{Rails.root}/downloads/ShadowsocksX-2.6.1.dmg"
		send_file(@filename ,
		  :type => 'application/dmg',
		  :disposition => 'attachment',
		  :x_sendfile=>true)    
	end
end
