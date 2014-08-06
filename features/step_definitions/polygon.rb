require 'chunky_png'

Given(/^I view leaflet$/) do
  visit('http://leafletjs.com')
  sleep(2)
end

Then(/^I save a picture$/) do
  file = "tmpimg-#{Time.new.to_i}.png"
  save_screenshot(file, :selector => "#map")

  image = ChunkyPNG::Image.from_file(file)

  puts image.pixels


  red_r = 255
  red_g = 0
  red_b = 0

  found_colour_red = false

  for i in 0..(1000 - 1)
    r = ChunkyPNG::Color.r(image.pixels[i]).to_s
    g = ChunkyPNG::Color.g(image.pixels[i]).to_s
    b = ChunkyPNG::Color.b(image.pixels[i]).to_s

    puts r.to_s + ' ' + g.to_s + ' ' + b.to_s
    if ((r == red_r) && (g == red_g) && (b == red_b)) then
      found_colour_red = true
    end

  end

  File.delete(file)

  if (found_colour_red == false) then
    raise "No colour Red found"
  end

end
