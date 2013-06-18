pdf.font("Courier", :size => 12)
  pdf.text "Anaheim Union High School District
Generated: #{Time.now}
"
  pdf.font("Courier", :style=> :bold, :size => 12)
  pdf.text "Weekly Food Center Order For Week of: #{@date.strftime('%b %d, %Y')}

"
  
for type in @data.keys.sort
  pdf.font("Courier", :style=> :bold, :size => 12)
  pdf.text "\n#{type.name}\n"
  
  pdf.font("Courier", :size => 12)
  ReportDrawer.item_table(pdf, @data[type])
end
