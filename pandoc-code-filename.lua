-- Pandoc Lua filter to handle code blocks with filenames
-- Syntax: ```lang filename
-- Converts to Typst code-block function with filename parameter

function CodeBlock(block)
  -- Check if the code block has classes (language identifier)
  if block.classes and #block.classes > 0 then
    local lang = block.classes[1]
    local filename = nil

    -- Check if there's a filename attribute
    if block.attributes and block.attributes.filename then
      filename = block.attributes.filename
    end

    -- Also check for 'caption' attribute which some tools use
    if not filename and block.attributes and block.attributes.caption then
      filename = block.attributes.caption
    end

    -- If we found a filename, create custom Typst code
    if filename then
      local typst_code = string.format(
        "#code-block(\n  filename: [%s],\n  language: [%s],\n  ```%s\n%s\n```\n)",
        filename,
        lang,
        lang,
        block.text
      )
      return pandoc.RawBlock('typst', typst_code)
    end
  end

  -- Return the original block if no filename
  return nil
end
