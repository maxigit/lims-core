directory_map = {
  :aliquot => :laboratory,
  :barcode_2d => :laboratory,
  :ean13_barcode => :laboratory,
  :flowcell => :laboratory,
  :gel => :laboratory,
  :labellable => :laboratory,
  :oligo => :laboratory,
  :plate => :laboratory,
  :receptacle => :laboratory,
  :sample => :laboratory,
  :sanger_barcode => :laboratory,
  :spin_column => :laboratory,
  :tag_group => :laboratory,
  :tube => :laboratory,
  :tube_rack => :laboratory,
  :batch => :organization,
  :order => :organization,
  :order => :organization,
  :project => :organization,
  :releasable => :organization,
  :study => :organization,
  :user => :organization,
  :uuid_resource => :uuids
}

resource_reg = /#{directory_map.keys.map { |d| "\\b#{d}" }.join('|')}/
old_module = nil
new_module = nil
new_class = nil
old_class = nil
resource = nil
resource_class = nil
tabs = nil
ARGF.each do |line|
  case line
  when  /^(filename.*)\/(actions|persistence)\/(\w+\/)?((#{resource_reg}).*).rb/
    resource = $5
    if new_directory=directory_map[resource.to_sym]
      old_module = $2.capitalize
      current_directory = new_directory
      new_module = current_directory.to_s.capitalize
      filename =$4
      if $2 == "persistence"
        filename += "_#{$3[0...-1]}" if $3
        filename += "_persistor"
      end
      new_class = filename.split('_').map(&:capitalize).join
      old_class = $4.split('_').map(&:capitalize).join
      resource_class = resource.split('_').map(&:capitalize).join
      
      line =  "#{$1}/#{current_directory}/#{resource}/#{filename}.rb"
    else # normal file
      old_module = nil
      current_directory = nil
    end
  when /module\s+#{old_module || '<>'}/
      line =  line.sub(old_module, new_module)
  when /(class|module)\s+#{old_class || '<>'}/
      line =  line.sub(old_class, "#{resource_class}::#{new_class}").sub("Persistence::#{old_class}", "#{old_class}Persistor")
  when  /^(\s+require.*)\/(actions|persistence)\/(\w+\/)?((#{resource_reg}).*)'/
    resource = $5
    if new_directory=directory_map[resource.to_sym]
      filename =$4
      if $2 == "persistence"
        filename += "_#{$3[0...-1]}" if $3
        filename += "_persistor"
      end
      line = "#{$1}/#{new_directory}/#{resource}/#{filename}'"
    end
  when /^(\s*)module\sSequel/
    tabs = $1
    line = nil
  when /^#{tabs || 'nothingtomatch'}end/
    line = nil
    tabs = nil
  end

  # unindent if we are in module block which is being deleted
  line = $1 if (tabs && line =~ /^  (.*)/)
  puts line if line

end
