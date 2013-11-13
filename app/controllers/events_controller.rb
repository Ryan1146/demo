class EventsController < ApplicationController
	def index
		flash[:debug] = params[:page]
		@events = Event.page(params[:page]).per(5)

		respond_to do |format|    
		  format.html # index.html.erb    
		  format.xml { render :xml => @events.to_xml }    
		  format.json { render :json => @events.to_json }    
		  format.atom { @feed_title = "My event list" } 
		  # index.atom.builder
		end

	end


	def update  
		@event = Event.find(params[:id])  

		puts @event.name
		@event.update_attributes(event_params)  
		#redirect_to :action => :show, :id => @event
		#redirect_to :action => :index
		redirect_to event_url(@event)
		#redirect_to events_url
	end



	def new  
		@event = Event.new
	end



	def show 
		@event = Event.find(params[:id])
		@page_title = @event.name

		  respond_to do |format|    
		  	format.html { @page_title = @event.name } # show.html.erb    
		  	format.xml # show.xml.builder    
		  	format.json { render :json => { id: @event.id, name: @event.name }.to_json }  
		  end
	end

	def edit  
		@event = Event.find(params[:id])
	end



	def create

		@event = Event.new(event_params)

        if @event.save
            flash[:notice] = "event was successfully created"
            #redirect_to :action => :index
            redirect_to events_url
        else
        	flash[:notice] = "fuck you"
            render :action => :new
        end

	end

	def destroy  
		@event = Event.find(params[:id])  
		@event.destroy  
		#redirect_to :action => :index
		redirect_to events_url
	end



  	private
    
    def event_params
        params.require(:event).permit(:name, :description)
    end

end
