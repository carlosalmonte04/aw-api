class Api::V1::CsvParsersController < ApplicationController

  def create
    selected_format = csv_params[:selected_format]
    rows       = csv_params[:file_to_parse].split("\r\n")
    headers    = rows[0].split(",")
    pk         = csv_params[:pk]
    pk_index   = headers.index(pk || headers[0])


    if selected_format == 'raw_json'
      final_json = {}
      rows.each_with_index do |row, i|
        row_cells = row.split(",")
        next if i == 0
        
        final_json[row_cells[pk_index]] = {}

        row_cells.each_with_index do |cell, j|
          final_json[row_cells[pk_index]][headers[j]] = cell 
        end
      end
      render :json => final_json.to_json
      return 
    end

    ac = ActionController::Base.new()
    html = ac.render_to_string(
      :template => "formats/#{selected_format}", 
      :locals => {rows: rows, pk_index: pk_index, headers: headers}
    )

    kit = PDFKit.new(html, 
      :footer_center => "Agency Within © 2017",
      :footer_line => true,
      :footer_spacing => 10,
      :margin_bottom => 20
    )

    send_data kit.to_file('report.pdf'), :type => 'application/pdf', :filename => 'AW Report'
  end

  private

  def csv_params
    params.require(:csv_parser).permit(:file_to_parse, :selected_format)
  end

end
