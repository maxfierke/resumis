WickedPdf.config = {
  wkhtmltopdf: ENV['WKHTMLTOPDF_PATH'].presence || [
    '/opt/homebrew/bin/wkhtmltopdf',
    '/usr/local/bin/wkhtmltopdf',
    '/usr/bin/wkhtmltopdf'
  ].find { |path| File.exist?(path) }
  #:layout => "pdf.html",
  #:exe_path => Gem.bin_path('wkhtmltopdf-binary', 'wkhtmltopdf')
}
