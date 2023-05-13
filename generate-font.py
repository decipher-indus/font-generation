import os
import fontforge

# Set the directory containing the SVG files
svg_dir = 'svgs/'

# Create a new font in fontforge
font = fontforge.font()

# Set the font properties
font.fontname = 'IndusFont'
font.fullname = 'Indus Script Font'

# Loop through all the SVG files in the directory
for filename in sorted(os.listdir(svg_dir)):
    if filename.endswith('.svg'):
        # Extract the Unicode code point from the file name
        codepoint = int(filename.rpartition('.svg')[0].partition('S')[2]) + 0xE000
        
        # Load the SVG file into a glyph
        glyph = font.createChar(codepoint)
        glyph.importOutlines(os.path.join(svg_dir, filename))
        
        # Set the glyph's name to the Unicode code point
        glyph.glyphname = f'uni{codepoint:04X}'
        print(codepoint, filename, glyph.glyphname)
        
        # Set the glyph's Unicode code point
        glyph.unicode = codepoint

font.selection.all()
font.autoWidth(150, minBearing = 10, maxBearing = 300)

# Save the font
font.generate('myfont.ttf')

