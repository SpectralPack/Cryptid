import sys
from PIL import Image
import os
import time
import math

CARD_SIZE = (69, 93)
CARD_MARGIN = 1  # Between the image border and cards there's a 1px space
CARD_COLS = 9


def is_selection_transparent(image: Image.Image, box: tuple) -> bool:
    """
    Check if a rectangular selection in an image is completely transparent.

    Parameters:
        image (PIL.Image.Image): The input image (must have an alpha channel).
        box (tuple): (left, upper, right, lower) defining the selection region.

    Returns:
        bool: True if the entire selection is transparent, False otherwise.
    """

    # Ensure the image has an alpha channel
    if image.mode not in ("RGBA", "LA"):
        raise ValueError("Image must have an alpha channel (RGBA or LA).")

    # Crop the selection
    cropped = image.crop(box)

    # Extract alpha channel
    alpha_channel = cropped.getchannel("A")

    # Get all alpha values
    alpha_data = alpha_channel.getdata()

    # Entire region is transparent if all alpha values are 0
    return all(pixel == 0 for pixel in alpha_data)


def upscale_pixel_art(input_image, output_directory):
    """
    Upscale the pixel art to 2x
    Parameters:
        input_image (Image.Image): The input image
        output_directory (str): The directory to save the resized image
    Returns:
        None
    """
    # Double the size
    new_size = (input_image.width * 2, input_image.height * 2)
    # NEAREST resampling preserves pixelation
    resized_image = input_image.resize(new_size, Image.NEAREST)

    # Save the resized image
    filename = os.path.basename(input_image.filename)
    output_image_path = os.path.join(output_directory, filename)
    resized_image.save(output_image_path)


def extract_from_1x(input_png, output_directory, card_type="joker"):
    """
    Extract the 1x image cards into individual png card images
    Parameters:
        input_png (str): The path to the 1x image cards
        output_directory (str): The directory to save the extracted card images
        card_type (str): The type of card to extract
    Returns:
        None
    """
    input_image = Image.open(input_png)
    for i in range(CARD_MARGIN, input_image.width, CARD_SIZE[0] + CARD_MARGIN*2):
        for j in range(CARD_MARGIN, input_image.height, CARD_SIZE[1] + CARD_MARGIN*2):
            # If the extracted card area is transparent, skip it
            if is_selection_transparent(input_image, (i, j, i + CARD_SIZE[0], j + CARD_SIZE[1])):
                continue
            card_image = input_image.crop(
                (i, j, i + CARD_SIZE[0], j + CARD_SIZE[1]))
            card_image.save(os.path.join(output_directory,
                            f"card_{card_type}_{i}_{j}.png"))


def build_base_cards(input_directory, output_png, output_lua, type="deck"):
    """
    Builds a sprite sheet from card PNGs and generates a Lua table
    describing their (col,row) positions.

    input_directory: folder containing .png card images
    output_png: path to save the final atlas png
    output_lua: path to save the Lua metadata file
    """

    files = sorted([f for f in os.listdir(
        input_directory) if f.endswith(".png")])
    count = len(files)

    # Compute number of rows
    rows = math.ceil(count / CARD_COLS)

    # Each card cell = card size + 2*margin
    cell_w = CARD_SIZE[0] + CARD_MARGIN * 2
    cell_h = CARD_SIZE[1] + CARD_MARGIN * 2

    # Atlas size = columns * cell size + 1 extra margin at right/bottom (already included)
    atlas_width = CARD_COLS * cell_w
    atlas_height = rows * cell_h

    output_image = Image.new("RGBA", (atlas_width, atlas_height), (0, 0, 0, 0))

    atlas_name = os.path.splitext(os.path.basename(output_png))[0]
    lua_entries = []

    index = 0
    for file in files:
        card = Image.open(os.path.join(input_directory, file)).convert("RGBA")

        col = index % CARD_COLS
        row = index // CARD_COLS

        # Place card inside its cell: 1px margin inset
        x = col * cell_w + CARD_MARGIN
        y = row * cell_h + CARD_MARGIN

        output_image.paste(card, (x, y))

        card_name = os.path.splitext(file)[0]
        lua_entries.append((card_name, atlas_name, col, row))

        index += 1

    # Save atlas
    output_image.save(output_png)

    # Save Lua table
    with open(output_lua, "w", encoding="utf-8") as lua:
        lua.write(f"-- Auto-generated card atlas for '{atlas_name}'\n")
        lua.write("return {\n")
        for name, atlas, col, row in lua_entries:
            lua.write(
                f"    [\"{name}\"] = {{ atlas = \"{atlas}\", x = {col}, y = {row} }},\n")
        lua.write("}\n")


if __name__ == "__main__":
    if len(sys.argv) < 2:
        print("Usage: py build.py <action> <input_png> <output_directory> <card_type>")
        print("""Actions:
        extract - Extract the 1x image cards into individual png card images
        upscale - Upscale the pixel art to 2x
        build - Build the base cards into a single png in 1x resolution
                and generates a sprite_coordinates.lua file containing a table with the coordinates of each card, their name and type of card
        """)
        sys.exit(0)
    action = sys.argv[1]

    if action == "upscale":
        input_image = Image.open(sys.argv[2])
        output_directory = sys.argv[3]
        upscale_pixel_art(input_image, output_directory)
    elif action == "build":
        input_directory = sys.argv[2]
        output_png = sys.argv[3]
        output_lua = sys.argv[4]
        type = sys.argv[5]
        build_base_cards(input_directory, output_png, output_lua, type)
    elif action == "extract":
        input_png = sys.argv[2]
        output_directory = sys.argv[3]
        card_type = sys.argv[4]
        extract_from_1x(input_png, output_directory, card_type)

    # Some tests I made
    # build_base_cards(
    #     "/Users/fuckingmac/Library/Application Support/Balatro/Mods/Cryptid-2/assets/base/decks/",
    #     "/Users/fuckingmac/Library/Application Support/Balatro/Mods/Cryptid-2/assets/base/base_cards.png",
    #     "/Users/fuckingmac/Library/Application Support/Balatro/Mods/Cryptid-2/lib/deck_coordinates.lua",
    #     "deck"
    # )

    # upscale_pixel_art(
    #     Image.open("/Users/fuckingmac/Library/Application Support/Balatro/Mods/Cryptid-2/assets/1x/deck.png"),
    #     "/Users/fuckingmac/Library/Application Support/Balatro/Mods/Cryptid-2/assets/2x/"
    # )
