require 'open-uri'
require 'prawn/measurement_extensions'

class DemosPrawPdf < Prawn::Document
  def initialize datas
    super(
      page_size: "A4",
      page_layout: :portrait,
      top_margin: 20,
      bottom_margin: 15,
      left_margin: 30,
      right_margin: 30,
      # background: "#{Rails.root}/samples/praawn.png",
      # background_scale: 0.5

    ) # page_layout: :landscape,
    # Define Font
    font_families.update("JA" => { normal: "#{Rails.root}/font/ipaexg.ttf", bold: "#{Rails.root}/font/ipaexg.ttf" })
    font "JA", style: :bold

    main
  end

  private

  def main
    repeat (2..), :dynamic => true do
      # header
      # footer
    end
    origin

    start_new_page(layout: :landscape, bottom_margin: 20)
    com_cursor

    start_new_page
    unit_in_prawn

    start_new_page
    line_and_curves

    start_new_page(layout: :landscape, bottom_margin: 20)
    stroke_dash

    start_new_page
    com_rectangle

    start_new_page
    com_polygon

    start_new_page
    com_circle_and_ellipse

    start_new_page
    com_color

    start_new_page
    com_scale

    start_new_page
    com_text
    com_text_column

    start_new_page(layout: :portrait)
    com_table

    start_new_page
    com_images

    start_new_page
    drawn_house

    #security (Set password and permission)
    # encrypt_document(
    #   user_password: 'passwordpassword', owner_password: :random,
    #   permissions: {
    #     print_document: false,
    #     copy_contents: false,
    #     modify_contents: true
    #   }
    # )
  end

  def com_images
    section_page "Image"
    stroke_axis
    move_down 40
    bounding_box([0, cursor], width: 500, height: 700) do
      image "#{Rails.root}/samples/dog-1.jpg",
            width: 300,
            height: 200,
            scale: 0.4,
            fit: [400, 400],
            # at: [200, cursor],
            position: :center #left, right
      stroke_bounds
     end
  end

  def com_table
    section_page "Table"
    table_data = [["This row should have one color", "Column 2", "Column 3"],
                  ["And this row should have another" * 2, "Column 2", "Column 3"]]
    table_data += [["...", "Column 2", "Column 3"]] * 5
    table(
      table_data,
      position: :center,
      column_widths: [300, 100, 100],
      width: 500,
      row_colors: ["F0F0F0", "FFFFCC"],
      # background_color: "FFFFCC"
      cell_style: {
        borders: [:top, :left, :right, :bottom],
        border_color: "FF0000",
        border_width: 3
      }
    )

    # image = "#{Rails.root}/samples/praawn.png"

    # table [
    #   ["Standard image cell", {:image => image}],
    #   [":scale => 0.5", {:image => image, :scale => 0.5}],
    #   [":fit => [100, 200]", {:image => image, :fit => [100, 200]}],
    #   [":image_height => 50,
    #   :image_width => 100", {:image => image, :image_height => 50,
    #   :image_width => 100}],
    #   [":position => :center", {:image => image, :position => :center}],
    #   [":vposition => :center", {:image => image, :vposition => :center,
    #   :height => 200}]
    #  ], :width => bounds.width
  end

  def com_text_column
    column_box([0, cursor], columns: 2, width: bounds.width) do
      text((<<-TEXT.gsub(/\s+/, ' ') + "\n\n") * 3, align: :justify)
        All the States and Governments by which men are or ever have been ruled,
        have been and are either Republics or Princedoms. Princedoms are either
        hereditary, in which the sovereignty is derived through an ancient line
        of ancestors, or they are new. New Princedoms are either wholly new, as
        that of Milan to Francesco Sforza; or they are like limbs joined on to
        the hereditary possessions of the Prince who acquires them, as the
        Kingdom of Naples to the dominions of the King of Spain. The States thus
        acquired have either been used to live under a Prince or have been free;
        and he who acquires them does so either by his own arms or by the arms of
        others, and either by good fortune or by merit.
        the States and Governments by which men are or ever have been ruled,
        have been and are either Republics or Princedoms. Princedoms are either
        hereditary, in which the sovereignty is derived through an ancient line
        of ancestors, or they are new. New Princedoms are either wholly new, as
        that of Milan to Francesco Sforza; or they are like limbs joined on to
        the hereditary possessions of the Prince who acquires them, as the
        Kingdom of Naples to the dominions of the King of Spain. The States thus
        acquired have either been used to live under a Prince or have been free.
      TEXT
    end
  end

  def com_text
    section_page "com_text"
    font('Courier', style: :italic) do
      text 'This text will flow to the next page. ' * 20,
      size: 12,
      color: "FF0000",
      align: :justify, #left, center
      leading: 5,
      character_spacing: 1,
      indent_paragraphs: 60,
      valign: :top
    end
  end

  def com_scale
    section_page "Scale"
    fill_color "000000"
    stroke_axis
    width = 100
    height = 60
    x = 50
    y = 150
    stroke_rectangle [x, y], width, height
    text_box "rectangle scaled from upper-left corner", at: [x + 10, y - 10], width: width - 20
    scale(2, origin: [x, y]) do
      stroke_rectangle [x, y], width, height
    end

    x = 350
    stroke_rectangle [x, y], width, height
    text_box "rectangle scaled from center'", at: [x + 10, y - 10], width: width - 20
    scale(2, origin: [x + width / 2, y - height / 2]) do
      stroke_rectangle [x, y], width, height
    end

    # x = 350
    # stroke_circle [x, y], width - 50
    # scale(2, origin: [x, y]) do
    #   stroke_circle [x, y], width -50
    # end
  end

  def com_color
    section_page "Color"
    dash(1, space: 0, phase: 0)
    stroke_axis
    # Fill with Yellow using RGB (Unlike css, there is no leading #)
    fill_color "FFFFCC"
    fill_polygon [50, 150], [150, 200], [250, 150], [250, 50], [150, 0], [50, 50]
    # Stroke with Purple using CMYK
    stroke_color 0, 100, 100, 0
    stroke_rectangle [50, 300], 200, 100
    # Both together
    fill_and_stroke_circle [310, 200], 50

    #change color
    stroke_color "36d1dc"
    fill_color 0, 46, 93, 7
    # Both together
    fill_and_stroke_circle [310, 100], 50

    # Gradient
    # Linear Gradients
    fill_gradient [500, 400], [500, 100], "dd5e89", "f7bb97"
    fill_rectangle [500, 400], 300, 300
  end

  def stroke_dash
    section_page "stroke_dash"
    stroke_axis(step_length: 50)

    dash([10, 2, 3, 2, 1, 5], phase: 0)
    stroke_horizontal_line 50, 500, at: 230

    dash([8, 2])
    stroke_horizontal_line 50, 500, at: 220

    dash(5, space: 2, phase: 2.5)
    stroke_horizontal_line 50, 500, at: 210
  end

  def com_circle_and_ellipse
    section_page "circle_and_ellipse"
    stroke_axis
    # stroke_circle [x, y], r
    stroke_circle [100, 300], 100
    # fill_ellipse [x, y], r1, r2
    fill_ellipse [200, 100], 100, 50
    fill_ellipse [400, 100], 50
  end

  def com_polygon
    stroke_axis
    # Triangle
    stroke_polygon [50, 200], [50, 300], [150, 300]
    # Hexagon
    fill_polygon [50, 150], [150, 200], [250, 150], [250, 50], [150, 0], [50, 50]
    # Pentagram
    pentagon_points = [500, 100], [430, 5], [319, 41], [319, 159], [430, 195]
    pentagram_points = [0, 2, 4, 1, 3].map { |i| pentagon_points[i] }
    stroke_rounded_polygon(20, *pentagram_points)
  end

  def com_rectangle
    section_page "rectangle"
    stroke_axis
    stroke do
      rectangle [100, 300], 100, 200
      rounded_rectangle [300, 300], 100, 200, 20
    end
  end

  def line_and_curves
    section_page "line and curves"
    stroke_axis
    # line and curve
    stroke do
      # line [x1, y1], [x2, y2]
      line [100, 200], [200, 50]
      # curve [x1, y1], [x2, y2], bounds: []
      curve [300, 0], [200, 200], bounds: [[150, 50], [250, 180]]
      # vertical_line y1, y2, at: x
      vertical_line 100, 300, at: 50
      # horizontal_line x1, x2, at: y
      horizontal_line 50, 300, at: 300
    end
  end

  def com_cursor
    section_page "com_cursor"
    stroke_axis(at: [0, 0], step_length: 50, negative_axes_length: 10, color: '000000')
    text "Current cursor 1: #{cursor}", size: 10
    # text "Current cursor 2: #{cursor}", size: 10
    move_down 200
    text "on the first move the cursor went down to: #{cursor}", size: 10
    move_up 100
    text "on the second move the cursor went up to: #{cursor}", size: 10
    text "the cursor is here: #{cursor}", size: 10
    text "now it is here: #{cursor}", size: 10
    move_cursor_to 50
    text "on the last move the cursor went directly to: #{cursor}", size: 10
    start_new_page(layout: :portrait)
    # other_cursor_helpers
    move_down 40

    stroke_horizontal_rule
    pad(10) { text "Text padded both before and after 10pt" }

    stroke_horizontal_rule
    pad_top(20) { text "Text padded on the top 20pt" }

    stroke_horizontal_rule
    pad_bottom(30) { text "Text padded on the bottom 30pt" }

    stroke_horizontal_rule
    move_down 30

    #Float
    float do
      move_down 30
      bounding_box([0, cursor], width: 400) do
        pad(10) do
          indent(10, 15) do # left and right padding
            text 'This text will flow along this bounding box we created for it. ' * 5
          end
        end
        transparent(0.3) { stroke_bounds }
      end
    end

    # move_down 10
    # bounding_box([0, cursor], width: 500) do
    #   # Padding: top, bottom: 10,
    #   # pad(10) { text 'Text padded both before and after.', align: :center }
    #   # Padding left: 10, right: 15, top,bottom: 10
    #   pad(10) do
    #     indent(10, 15) do # left and right padding
    #       text 'This text will flow along this bounding box we created for it. ' * 5
    #     end
    #   end
    #   stroke_bounds
    # end

    # # move_down 10
    # bounding_box([0, cursor], width: 500) do
    #   # Padding: top, bottom: 10,
    #   # pad(10) { text 'Text padded both before and after.', align: :center }
    #   # Padding left: 10, right: 15, top,bottom: 10
    #   pad(10) do
    #     indent(10, 15) do # left and right padding
    #       text 'This text will flow along this bounding box we created for it. ' * 5
    #     end
    #   end
    #   stroke_bounds
    # end
  end

  def unit_in_prawn
    section_page "unit_in_prawn", "unit_in_prawn 1"
    # The base unit in Prawn is the PDF Point. One PDF Point is equal to 1/72 of
    # an inch.
    move_down 40
    %i[mm cm dm m in yd ft].each do |measurement|
      text "1 #{measurement} in PDF Points: #{1.send(measurement)} pt"
      move_down 5.mm
    end
  end

  def origin
    section_page "origin"
    stroke_axis(at: [0, 0], step_length: 50, negative_axes_length: 10, color: '000000')
    # stroke_circle [x, y], r
    stroke_circle [0, 0], 10
    bounding_box([100, 300], width: 300, height: 200) do
      stroke_bounds
      stroke_circle [0, 0], 10
    end
  end

  def drawn_house
    section_page "drawn_house"
    stroke_color "000000"
    bounding_box([0, 200], width: 500) do
      stroke_polygon [0, -10], [0, 10], [118, 10], [118, 65], [136, 65], [136, 10], [140, 10], [140, 159], [175, 205], [205, 166], [260, 150], [239, 189], [160, 223], [104, 147], [120, 147], [70, 100], [104, 100], [104, 0],
                     [300,0], [300, 120], [340, 190], [380, 97], [380, 10], [363, 10], [363, 70], [348,74], [348,10], [343, 10], [343, 76], [324,78], [324, 10], [276, 10], [276, 78], [240, 78], [240, 10], [216, 10],
                     [216, 156], [198, 155], [198, 116], [176, 115], [176, 150], [166, 149], [166, 112], [150, 111], [150, 144], [144, 144], [144, 10], [150, 10], [150, 74], [166, 75], [166, 10], [176, 10], [176, 76],
                     [198, 77], [198, 10], [209, 10], [209, 110], [315, 120], [360, 202], [250, 195], [364, 216], [404, 90], [385, 90], [385, 10], [500, 10], [500, -10]
    end
    # image "#{Rails.root}/samples/house1.png", fit: [500, 500], at: [0, 225]
  end

  def section_page section, _page = nil
    outline.section(section, destination: page_number) do
      if _page
        outline.page title: _page, destination: page_number
      end
    end
  end

  def header
    bounding_box [bounds.left, bounds.top], :width  => bounds.width do
      font "Helvetica"
      text "Prawn", align: :center, size: 25
      image "#{Rails.root}/samples/praawn.png", fit: [40, 40], at: [0, 40]
      stroke_horizontal_rule
    end
  end

  def footer
    bounding_box [bounds.left, bounds.bottom + 20], :width  => bounds.width do
      font "Courier"
      stroke_horizontal_rule
      move_down(5)
      text "Nguyen Van Hai", size: 12
    end
  end
end
