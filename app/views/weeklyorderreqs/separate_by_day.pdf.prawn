@days.each do |i|
date = @date + i.days
    pdf.font("Courier", :size => 12)
    pdf.text \
"Anaheim Union High School District                                       Generated: #{Time.now}
Weekly Food Center Order For Week of: #{@date.strftime('%b %d, %Y')}"
    pdf.font("Courier", :style=> :bold, :size => 12)
    pdf.text "#{(date).strftime("%A %b %d, %Y")}"
    for type in @data[i].keys.reject{|k| k == :grand_totals}.sort
        pdf.font("Courier", :style=> :bold, :size => 12)
        pdf.text "\n#{type.name}\n"
        
        pdf.font("Courier", :size => 12)
        ReportDrawer.item_table(pdf, @data[i][type])
    end
    pdf.font("Courier", :style=> :bold, :size => 12)
    pdf.text "\n\nGrand Totals: Quantity: #{@data[i][:grand_totals][:total_quantity]}    Value: #{@data[i][:grand_totals][:total_price]}"
    pdf.start_new_page if i < @days.last
end
