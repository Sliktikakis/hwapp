class UsersController < ApplicationController
  def index
  	@users = User.all
  end

  def show
  	@user = User.find(params[:id])
  	now = DateTime.now
  	td = DateTime.now.beginning_of_day
  	@sent_mails = SentMail.where(sender_address: @user.email).
  						   where("created_at <= ?", now).
  						   where("created_at >= ?", td - 30).
  						   order('created_at DESC')
  	@received_mails = SentMail.where(recipient_address: @user.email).
  							   where("created_at <= ?", now).
  						   	   where("created_at >= ?", td - 30).
  						   	   order('created_at DESC')
  	
  	datelim = td - 30
  	labels = []
  	sent_data = []
  	rec_data = []
  	tot_sent = 0
  	tot_rec = 0
  	for i in 1..31
  		if i%2 != 0
  			labels.push("#{(datelim + i).strftime('%d/%m')}")
  		else
  			labels.push("")
  		end
  		c = @sent_mails.where("created_at <= ?", datelim + i).count - tot_sent
  		d = @received_mails.where("created_at <= ?", datelim + i).count - tot_rec
  		tot_sent += c
  		tot_rec += d
  		sent_data.push(c)
  		rec_data.push(d)
  	end

  	@data = {
  		labels: labels,
  		datasets: [
    		{
        		label: "Sent emails",
        		backgroundColor: "rgba(220,220,220,0.2)",
        		borderColor: "rgba(220,220,220,1)",
        		data: sent_data
    		},
    		{
        		label: "Received emails",
        		backgroundColor: "rgba(151,187,205,0.2)",
        		borderColor: "rgba(151,187,205,1)",
        		data: rec_data
    		}
  		]
	}
  end
end
