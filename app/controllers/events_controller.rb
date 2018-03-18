class EventsController < ApplicationController
  before_action :set_event, :only => [ :show, :edit, :update, :destroy]
	def index
  if params[:keyword]
    @events = Event.where( [ "name like ?", "%#{params[:keyword]}%" ] )
  else
    @events = Event.all
  end

  @events = @events.page(params[:page]).per(5)
end

    def new
  @event = Event.new
end
    def create
  @event = Event.new(event_params)
  if @event.save
    redirect_to events_url
  else
    render :action => :new
  end
  flash[:notice] = "event was successfully created"
end
    def show
    @page_title = @event.name
end
    def edit
  
end
    def update
  if @event.update(event_params)
    redirect_to event_url(@event)
  else
    render :action => :edit
  end
  flash[:notice] = "event was successfully updated"
end
   def destroy
    @event.destroy

  redirect_to events_url
  flash[:alert] = "event was successfully deleted"
end
   def latest
  @events = Event.order("id DESC").limit(3)
end

def bulk_update
  ids = Array(params[:ids])
  events = ids.map{ |i| Event.find_by_id(i) }.compact

  if params[:commit] == "Publish"
    events.each{ |e| e.update( :status => "published" ) }
  elsif params[:commit] == "Delete"
    events.each{ |e| e.destroy }
  end

  redirect_to events_url
end

def dashboard
    @event = Event.find(params[:id])
end


private

    def event_params
  params.require(:event).permit(:name, :description, :category_id, :location_attributes => [:id, :name, :_destroy], :group_ids => [] )
end
    def set_event
  @event = Event.find(params[:id])
end
end
