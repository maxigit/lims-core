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
resource = nil
resource_class = nil
ARGF.each do |line|
  case line
  when  /^(filename.*)\/(actions|persistence)\/((#{resource_reg}).*).rb/
    resource = $4
    if new_directory=directory_map[resource.to_sym]
      old_module = $2.capitalize
      current_directory = new_directory
      new_module = current_directory.to_s.capitalize
      new_class = $3.split('_').map(&:capitalize).join
      resource_class = resource.split('_').map(&:capitalize).join
      
      puts "#{$1}/#{current_directory}/#{resource}/#{$3}.rb"
    else # normal file
      old_module = nil
      current_directory = nil
      puts line
    end
  when /module\s+#{old_module || '<>'}/
      puts line.sub(old_module, new_module)
  when /(class|module)\s+#{new_class || '<>'}/
      puts line.sub(new_class, "#{resource_class}::#{new_class}")
  when  /^(\s+require.*)\/(actions|persistence)\/((#{resource_reg}).*)/
    puts ">> #{line}"
    resource = $4
    if new_directory=directory_map[resource.to_sym]
      puts "#{$1}/#{new_directory}/#{$resource}/#{$3}"
    else
      puts line
    end
  else
    
  end

end
