# shoes_mandelbrot.rb
# Imporved Gallery 13 in the Shoes Tutorial Note.

W, H, MAX = 300, 300, 200

Shoes.app :width => W + 3, :height => H + 90, :title => 'Mandelbrot v0.3' do
  def mandelbrot a, b
    x, y = 0.0, 0.0
    MAX.times do |i|
      x, y = x * x - y * y - a, 2.0 * x * y - b
      return [x, y, i] if (x * x + y * y) > 4.0
    end
    [x, y, false]  
  end
  
  x0, y0, w0 = 0.0, 0.0, 4.0
  MSG = "x: %s\ny: %s\nw: %s\n"
  msg = para MSG % [x0, y0, w0], :left => 10, :top => 310
  bg = rect 0, 0, 300, 300, :fill => white
 
  nostroke
  @mono = true
  button('m/c', :left => 240, :top => 330){@mono = !@mono}
  
  button 'cal', :left => 240, :top => 360 do
    arr = msg.text.split
    x0, y0, w0 = arr[1].to_f, arr[3].to_f, arr[5].to_f
    a0, a1 = x0 - w0/2, x0 + w0/2
    b0, b1 = y0 - w0/2, y0 + w0/2
    @img.remove if @img
    @img = image :width => W, :height => H do
      H.times do |j|
        W.times do |i|
          x, y, diverged = mandelbrot(a0 + i * (a1 - a0) / W, b0 + j * (b1 - b0) / H)
          if @mono
            oval(i, j, 1) unless diverged
          else
            oval i, j, 1, :fill => diverged ? rgb(255 - diverged, x.abs, y.abs) : black
          end
        end
      end
    end
  end
  
  flag = false
  bg.click{flag = !flag; @l, @t = mouse[1], mouse[2]}
  
  click{@r.remove if @r and mouse[2] > 300}
  
  motion do |mx, |
     begin
      @r.remove if @r
      @r = rect @l, @t, (@l-mx).abs, :fill => rgb(0, 191, 255, 0.5)
      x, y, w = x0+(@l-W/2)*w0/W, y0+(@t-H/2)*w0/H, (@l-mx).abs*w0/W
      msg.text = MSG % [x + w/2, y + w/2, w]
    end if flag
  end
end
