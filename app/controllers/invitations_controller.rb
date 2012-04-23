class InvitationsController < ApplicationController
    # GET /invitations
    # GET /invitations.json
    def index
        @invitations = Invitation.all

        respond_to do |format|
            format.html # index.html.erb
            format.json { render json: @invitations }
        end
    end

    # GET /invitations/1
    # GET /invitations/1.json
    def show
        @invitation = Invitation.find(params[:id])
        @message = Message.new(:conversation => @invitation.conversation)
        respond_to do |format|
            format.html # show.html.erb
            format.json { render json: @invitation }
        end
    end

    # GET /invitations/new
    # GET /invitations/new.json
    def new
        @invitation = Invitation.new
        @invitation.from_user = self.current_user
        unless params[:user].nil?
            @invitation.to_user = User.find_by_id(params[:user])
        end
        respond_to do |format|
            format.html # new.html.erb
            format.json { render json: @invitation }
        end
    end

    # GET /invitations/1/edit
    def edit
        @invitation = Invitation.find(params[:id])
    end

    # POST /invitations
    # POST /invitations.json
    def create
    params[:invitation][:to_user] = User.find_by_name(params[:invitation][:to_user])
    params[:invitation][:from_user] = User.find_by_name(params[:invitation][:from_user])
    @invitation = Invitation.new(params[:invitation])
    conversation = Conversation.create
    @invitation.update_attribute(:conversation, conversation)
    Notification.create(:user => @invitation.to_user, :notification_type => NotificationType.find_by_name("NewInvitation"))
        respond_to do |format|
        if @invitation.save
            format.html { redirect_to @invitation, success: 'Invitation was successfully created.' }
            format.json { render json: @invitation, status: :created, location: @invitation }
        else
            format.html { render action: "new" }
            format.json { render json: @invitation.errors, status: :unprocessable_entity }
        end
        end
    end

    # PUT /invitations/1
    # PUT /invitations/1.json
    def update
        @invitation = Invitation.find(params[:id])

        respond_to do |format|
            if @invitation.update_attributes(params[:invitation])
                format.html { redirect_to @invitation, success: 'Invitation was successfully updated.' }
                format.json { head :no_content }
            else
                format.html { render action: "edit" }
                format.json { render json: @invitation.errors, status: :unprocessable_entity }
            end
        end
    end

    # DELETE /invitations/1
    # DELETE /invitations/1.json
    def destroy
        @invitation = Invitation.find(params[:id])
        @invitation.destroy

        respond_to do |format|
            format.html { redirect_to invitations_url }
            format.json { head :no_content }
        end
    end
end
