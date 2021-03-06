class InvoicesController < ApplicationController
  before_action :set_invoice, only: %i[ show edit update destroy ]

  # GET /invoices or /invoices.json
  def index
    @invoices = Invoice.all
  end

  # GET /invoices/1 or /invoices/1.json
  def show
    @invoice_details = @invoice.invoice_details.includes(:invoice).all.order(sort: "asc")
    # @invoice_details = InvoiceDetail.all
  end

  # GET /invoices/new
  def new
    @invoice = Invoice.new
  end

  # GET /invoices/1/edit
  def edit
    @invoice_details = @invoice.invoice_details.includes(:invoice).all.order(sort: "asc")
    @invoice_detail = InvoiceDetail.new
  end

  # POST /invoices or /invoices.json
  def create
    @group = Group.find_by(owner_id: current_user.id)
    @invoice = Invoice.new(invoice_params)

    @invoice.invoice_id = SecureRandom.uuid
    @invoice.group_id = @group.group_id

    respond_to do |format|
      if @invoice.save
        format.html { redirect_to '/groups/' + @group.group_id, notice: "Invoice was successfully created." }
        format.json { render :show, status: :created, location: @invoice }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /invoices/1 or /invoices/1.json
  def update
    respond_to do |format|
      if @invoice.update(invoice_params)
        format.html { render :edit, notice: "Invoice was successfully updated." }
        format.json { render :show, status: :ok, location: @invoice }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @invoice.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /invoices/1 or /invoices/1.json
  def destroy
    @invoice = Invoice.find_by(invoice_id: params[:invoice_id])
    @invoice.destroy
    respond_to do |format|
      format.html { redirect_to invoices_url, notice: "Invoice was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_invoice
      @invoice = Invoice.find_by(invoice_id: params[:invoice_id])
      # member = Member.find_by(name: ???Kei???)
    end

    # Only allow a list of trusted parameters through.
    def invoice_params
      params.require(:invoice).permit(:title, :company_name, :zip, :pref, :address, :tel, :subtotal, :tax_rate, :tax, :amount, :sub1)
    end
end
