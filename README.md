Mandelbrot Set Plotter with Shoes 
=================================

[Mandelbrot Set](http://en.wikipedia.org/wiki/Mandelbrot_set)

What a mysterious pattern! Impossible drawing by hand.

**Note**: the following snippet is so heavy to run. Need big power of cpu.


**mandelbrot001.png**

![mandelbrot001.png](http://github.com/ashbb/shoes_mandelbrot/tree/master%2Fimg%2Fmandelbrot001.png?raw=true)

This is the most famous drawing.

**mandelbrot002.png**

![mandelbrot002.png](http://github.com/ashbb/shoes_mandelbrot/tree/master%2Fimg%2Fmandelbrot002.png?raw=true)

Select a small part (blue rectangle) by mouse. Click the button `cal` to enlarge it.

**mandelbrot003.png**

![mandelbrot003.png](http://github.com/ashbb/shoes_mandelbrot/tree/master%2Fimg%2Fmandelbrot003.png?raw=true)

Enlarge again.

**mandelbrot004.png**

![mandelbrot004.png](http://github.com/ashbb/shoes_mandelbrot/tree/master%2Fimg%2Fmandelbrot004.png?raw=true)

Enlarge several times and add some colors.


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


This code is based on Gallery 13.

References
----------
- [Gallery 13](http://shoes-tutorial-note.heroku.com/html/01130_Fancy_Gallery_11-15.html) in the Shoes Tutorial Note
- [Mandelbrot Set](http://www.asahi-net.or.jp/~uc3k-ymd/Sketch/Mandelbrot/mandel01.html) (in Japanese)
