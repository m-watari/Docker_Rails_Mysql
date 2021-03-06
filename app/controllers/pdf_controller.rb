class PdfController < ApplicationController
    
    def download
        @id = params[:id]
        @invoice = Invoice.find(@id)
            respond_to do |format|
            # format.html
            format.pdf do
                render pdf: "pdf_download_test",   # PDFのファイル名
                        encording: 'UTF-8',         # エンコード指定
                        layout: 'layouts/pdf.html', # PDF用の共通レイアウト
                        # trueを指定すると、HTML画面として確認ができる
                        show_as_html: params[:show_as_html].present?
            end
        end
    end
    def show
        @id = params[:id]
        # format.html
        format.pdf do
            render pdf: "pdf_show_test",   # PDFのファイル名
                    encording: 'UTF-8',         # エンコード指定
                    layout: 'layouts/pdf.html', # PDF用の共通レイアウト
                    # trueを指定すると、HTML画面として確認ができる
                    show_as_html: params[:show_as_html].present?
        end
    end
  end