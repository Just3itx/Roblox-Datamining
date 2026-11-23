-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T20:51:18Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent
local Style = require(BuildExperienceParent.Style)
local getVisibleLineCount = require(script.Parent.getVisibleLineCount)
local chatTextAreaDebug = require(script.Parent.chatTextAreaDebug)

local function measureTextLineCount(tbl1)
    local newlineLineCount = getVisibleLineCount(tbl1.text, tbl1.maxLines)
    local num1 = 1
    if tbl1.text ~= "" then
        for _ in string.gmatch(tbl1.text, "\n") do
            num1 += 1
        end
    end
    local layoutWidth = tbl1.layoutWidth or 0
    local textSizeY = nil
    local var1 = nil

    if tbl1.text == "" then
        chatTextAreaDebug.log("measure", `empty -> lineCount=1 layoutWidth={layoutWidth}`)
        return {
            lineCount = 1,
            newlineLineCount = 1,
            wrappedLineCount = nil,
            layoutWidth = layoutWidth,
            boundsY = nil
        }
    end

    local var2

    if layoutWidth > 0 then
        local textSizeY2 = Style.GetTextSize("M", tbl1.fontSize, tbl1.font, Vector2.new(layoutWidth, 100000), { addTemporaryPadding = false }).Y

        textSizeY = Style.GetTextSize(
            tbl1.text,
            tbl1.fontSize,
            tbl1.font,
            Vector2.new(layoutWidth, 100000),
            { addTemporaryPadding = false }
        ).Y

        if textSizeY > 0 and textSizeY2 > 0 then
            var1 = math.ceil(textSizeY / textSizeY2)
            local num2 = math.max(num1, var1)

            var2 = math.clamp(num2, 1, tbl1.maxLines)
            textSizeY = num2 * tbl1.singleLineHeight
        else
            var2 = newlineLineCount
        end
    else
        var2 = newlineLineCount
    end

    chatTextAreaDebug.log(
        "measure",
        `lineCount={var2} newlines={newlineLineCount} wrapped={var1 or "nil"} boundsY={textSizeY or "nil"} layoutWidth={layoutWidth} textLen={utf8.len(tbl1.text) or #tbl1.text}`
    )
    return {
        lineCount = var2,
        newlineLineCount = newlineLineCount,
        wrappedLineCount = var1,
        layoutWidth = layoutWidth,
        boundsY = textSizeY
    }
end
return measureTextLineCount
