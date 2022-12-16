class DemoPrawPdfsController < ApplicationController
  def index
    pdf = DemosPrawPdf.new(datas: "as").render
    send_data(pdf, filename: "praw_pdf.pdf", type: "application/pdf", disposition: "inline")
  end
end
