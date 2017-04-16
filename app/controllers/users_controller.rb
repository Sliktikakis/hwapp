class UsersController < ApplicationController
  def index
  	@users = User.all.order('name ASC')

  	dlim = DateTime.now.beginning_of_day - 30
  	labels = []
  	d = []
  	for i in 1..31
  		if i%2 != 0
  			labels.push("#{(dlim + i).strftime('%d/%m')}")
  		else
  			labels.push("")
  		end
  		d.push(0)
  	end

  	@data = {
  		labels: labels,
  		datasets: [
    		{
        		label: "Sent emails",
        		backgroundColor: "rgba(220,220,220,0.2)",
        		borderColor: "rgba(220,220,220,1)",
        		lineTension: 0.3,
        		data: d
    		},
    		{
        		label: "Received emails",
        		backgroundColor: "rgba(151,187,205,0.2)",
        		borderColor: "rgba(151,187,205,1)",
        		lineTension: 0.3,
        		data: d
    		}
  		]
	}
  end

  def select_user
  	@user = User.find(params[:user][:id])

  	now = DateTime.now
  	dlim = DateTime.now.beginning_of_day - 30
  	@sent_mails = SentMail.where(sender_address: @user.email).
  						   where("created_at <= ?", now).
  						   where("created_at >= ?", dlim).
  						   order('created_at DESC')
  	@received_mails = SentMail.where(recipient_address: @user.email).
  							   where("created_at <= ?", now).
  						   	   where("created_at >= ?", dlim).
  						   	   order('created_at DESC')
  	
  	labels = []
  	@sent_data = []
  	@rec_data = []
  	tot_sent = 0
  	tot_rec = 0
  	for i in 1..31
  		if i%2 != 0
  			labels.push("#{(dlim + i).strftime('%d/%m')}")
  		else
  			labels.push("")
  		end
  		c = @sent_mails.where("created_at <= ?", dlim + i).count - tot_sent
  		d = @received_mails.where("created_at <= ?", dlim + i).count - tot_rec
  		tot_sent += c
  		tot_rec += d
  		@sent_data.push(c)
  		@rec_data.push(d)
  	end

	respond_to do |format|
  		format.html { redirect_to root_url }
  		format.js
  	end
  end
end
