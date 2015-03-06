require "rjb"
class_pdfreader     = Rjb::import('com.lowagie.text.pdf.PdfReader')

Dir.glob('tmp/output_*.pdf').each do |filename|
  pages = class_pdfreader.new(filename).getNumberOfPages
  puts "filename: #{filename} with pages: #{pages}"
end
