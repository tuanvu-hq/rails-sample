class NotesController < ApplicationController
  def show
  end

  def new
    @note = Note.new
  end

  def create
    @note = Note.new(note_params)
    reassign_tags(@note, note_tags)

    if @note.save
      create_history(@note, "#{@note.title} has been created.")
      # flash[:success] = "Note #{@note.title} has been successfully created!"
      respond_to do |format|
        format.html { redirect_to dashboard_notes_path }
        format.turbo_stream { render turbo_stream: turbo_stream.prepend("turbo_notes", partial: "dashboard/custom_note", locals: { note: @note }) }
      end
    else
      # flash[:error] = "Something went wrong."
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @note = Note.find(params[:id])
  end

  def update
    @note = Note.find(params[:id])
    reassign_tags(@note, note_tags)

    if @note.update(note_params)
      create_history(@note, "#{@note.title} has been updated.")
      # flash[:success] = "Note #{@note.title} has been successfully updated!"
      respond_to do |format|
        format.html { redirect_to dashboard_notes_path }
        format.turbo_stream { render turbo_stream: turbo_stream.replace(@note, partial: "dashboard/custom_note", locals: { note: @note }) }
      end
    else
      # flash[:error] = "Something went wrong."
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @note = Note.find(params[:id])

    if @note.destroy!
      create_history(@note, "#{@note.title} has been deleted.")
      # flash[:success] = "Note #{@note.title} has been successfully deleted!"
      respond_to do |format|
        format.html { redirect_to dashboard_notes_path }
        format.turbo_stream { render turbo_stream: turbo_stream.remove(@note) }
      end
    end
  end


  private

  def create_history(note, action)
    history = History.create(note_id: note.id, note_title: note.title, action: action)
    # puts "MAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAN #{history.inspect}"
  end

  def reassign_tags(note, tags)
    note.note_tags.destroy_all
    new_tags = tags.strip.split(",")

    new_tags.each do |tag|
      tag_obj = Tag.find_or_create_by(title: tag.strip)
      note.tags << tag_obj unless note.tags.include?(tag_obj)
    end
  end

  def note_params
    params.require(:note).permit(:title, :description, :body, tags: []).tap do |note_params|
      note_params[:user_id] = auth_get_current_user.id if auth_get_current_user
    end
  end

  def note_tags
    return params[:note][:tags]
  end
end
