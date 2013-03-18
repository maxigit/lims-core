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
ARGF.each do |line|
  case line
  when  /^(filename.*)\/(actions|persistence)\/(\w\+\/)?((#{resource_reg}).*).rb/
    resource = $5
    if new_directory=directory_map[resource.to_sym]
      old_module = $2.capitalize
      current_directory = new_directory
      new_module = current_directory.to_s.capitalize
      filename =$4
      if $2 == "persistence"
        filename += "_#{$3}" if $3
        filename += "_persistor"
      end
      new_class = filename.split('_').map(&:capitalize).join
      old_class = $4.split('_').map(&:capitalize).join
      resource_class = resource.split('_').map(&:capitalize).join
      
      puts "#{$1}/#{current_directory}/#{resource}/#{filename}.rb"
    else # normal file
      old_module = nil
      current_directory = nil
      puts line
    end
  when /module\s+#{old_module || '<>'}/
      puts line.sub(old_module, new_module)
  when /(class|module)\s+#{old_class || '<>'}/
      puts line.sub(old_class, "#{resource_class}::#{new_class}")
  when  /^(\s+require.*)\/(actions|persistence)\/((#{resource_reg}).*)/
    resource = $4
    if new_directory=directory_map[resource.to_sym]
      if $2 == "persistence"
        resource += "_persistor"
      end
      puts "#{$1}/#{new_directory}/#{$resource}/#{$3}"
    else
      puts line
    end
  else
    puts line
    
  end

end
