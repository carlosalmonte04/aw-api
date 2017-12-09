class Api::V1::CsvParsersController < ApplicationController

  def index
    byebug
  end

  def create
    byebug
    kit = PDFKit.new(<<-HTML)
      <p>Hello Envato!</p>
    HTML
    render json: {name: 'hello', kit: kit}
  end

  private

  def csv_params
    params.require(:csv_parser).permit(:name, :data)
  end
end
