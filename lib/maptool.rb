require 'json'

class Maptool
  def initialize(c,r,e,p,b = false,v = false, vv = false)
    @verbose = v
    @superverbose = vv
    @border = b
    @tile_w = 12
    @tile_h = 9
    @precision = p
    @cols = c - 1
    @rows = r - 1
    @map = Hash.new
    @map.default = 0
    @items = Hash.new
    @items = load_items
    @items_weight = Hash.new
    (1..@items.length - 1).each do |i|
      @items_weight[i] = ((1.0 - e) * (1.0 / @items.length)).round(@precision)
    end
    @empty_weight = (1.0 - @items_weight.values.sum).round(@precision)
    @items_weight[0] = @empty_weight
  end

  def run!
    puts "generating new map {cols: #{@cols + 1} rows: #{@rows + 1}, empty_weight: #{@empty_weight}, precision: #{@precision}}" if @verbose || @superverbose
    (0..@rows).each do |r|
      @map[r] = Hash.new
      (0..@cols).each do |c|
        if r == 0 and c == 0
          suitable = true
        else
          suitable = false
        end
        loop do
          new_item = weighted_rand(@items_weight)
          puts "me:    #{@items[new_item.to_s][:meta]}" if @superverbose
          if r == 0 && c == 0
            cand_c = true
            cand_r = true
          else

            if c > 0
              if @items[new_item.to_s][:meta]['w'] == @items[@map[r][c - 1].to_s][:meta]['e']
                puts "left:  #{@items[@map[r][c-1].to_s][:meta]}" if @superverbose
                cand_c = true
              else
                cand_c = false
              end
            else
              cand_c = true
            end

            if r > 0
              if @items[new_item.to_s][:meta]['n'] == @items[@map[r - 1][c].to_s][:meta]['s']
                puts "above: #{@items[@map[r - 1][c].to_s][:meta]}" if @superverbose
                cand_r = true
              else
                cand_r = false
              end
            else
              cand_r = true
            end
          end

          if cand_c && cand_r
            puts "-----------------done" if @superverbose
            @map[r][c] = new_item
            break
          else
            puts "++++++++++++++++again" if @superverbose
          end
        end

      end
    end
  end

  def print_debug_map
    (0..@rows).each do |r|
      (0..@cols).each do |c|
        print "#{@map[r][c].to_s.rjust(3," ")} "
      end
      puts
    end
  end

  def print_map
    print_debug_map if @verbose || @superverbose
    if @border
      (0..(@tile_w*(@cols+1))+@cols).each do |d| print "." end
      puts
    end
    (0..@rows).each do |r|
      (0..@tile_h).each do |th|
        print "." if @border
        (0..@cols).each do |c|
          if @border
            print "#{@items[@map[r][c].to_s][:data][th].to_s.ljust(@tile_w, "\ ")}."
          else
            print "#{@items[@map[r][c].to_s][:data][th].to_s.ljust(@tile_w, "\ ")}"
          end
        end
        puts
      end
      if @border
        (0..(@tile_w * (@cols + 1)) + @cols + 1).each do |d| print "." end
        puts
      end
    end
  end

  def print_web_map
    map_string = ''
    if @border
      (0..(@tile_w * (@cols + 1)) + @cols + 1).each { |_d| map_string.concat('.') }
      map_string.concat("\n")
    end
    (0..@rows).each do |r|
      (0..@tile_h).each do |th|
        map_string.concat('.') if @border
        (0..@cols).each do |c|
          if @border
            map_string.concat("#{@items[@map[r][c].to_s][:data][th].to_s.ljust(@tile_w, "\ ")}.")
          else
            map_string.concat("#{@items[@map[r][c].to_s][:data][th].to_s.ljust(@tile_w, "\ ")}")
          end
        end
        map_string.concat("\n")
      end
      if @border
        (0..(@tile_w * (@cols + 1)) + @cols + 1).each { |_d| map_string.concat('.') }
        map_string.concat("\n")
      end
    end
    map_string
  end

  # Code credited to https://stackoverflow.com/users/1288687/knugie from https://stackoverflow.com/questions/4463561/weighted-random-selection-from-array
  def weighted_rand(weights = {})
    raise 'Probabilities must sum up to 1' unless weights.values.sum == 1.0
    raise 'Probabilities must not be negative' unless weights.values.all? { |p| p >= 0 }
    # Do more sanity checks depending on the amount of trust in the software component using this method
    # E.g. don't allow duplicates, don't allow non-numeric values, etc.

    # Ignore elements with probability 0
    weights = weights.reject { |k, v| v == 0.0 }   # e.g. => {"a"=>0.4, "b"=>0.4, "c"=>0.2}

    # Accumulate probabilities and map them to a value
    u = 0.0
    ranges = weights.map { |v, p| [u += p, v] }   # e.g. => [[0.4, "a"], [0.8, "b"], [1.0, "c"]]

    # Generate a (pseudo-)random floating point number between 0.0(included) and 1.0(excluded)
    u = rand   # e.g. => 0.4651073966724186

    # Find the first value that has an accumulated probability greater than the random number u
    ranges.find { |p, v| p > u }.last   # e.g. => "b"
  end

  def load_items
    items = Hash.new
    Dir.glob("lib/assets/ascii/*.tile").sort.each do |file|
      itemname = File.basename(file, '.tile')
      items[itemname] = Hash.new
      data = File.read(file).split("\n")
      items[itemname][:meta] = JSON.parse(data[0])
      data.delete_at(0)
      items[itemname][:data] = data
    end
    return items
  end
end
