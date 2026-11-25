-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T11:01:14Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SduiSharedContentParent = script:FindFirstAncestor("SduiSharedContent").Parent

local React = require(SduiSharedContentParent.React)
local Cryo = require(SduiSharedContentParent.Cryo)

local SduiText = require(script.Parent.SduiText)
local useRevealText = require(script.Parent.useRevealText)

local function SduiRevealText(arg1)
    local text = useRevealText({
        delimiter = arg1.delimiter,
        removeDelimiter = arg1.removeDelimiter,
        revealInterval = arg1.revealInterval,
        richText = arg1.richText,
        text = arg1.text
    })
    local var2 = React.useMemo(function()
        return Cryo.Dictionary.join(
            arg1,
            {
                delimiter = Cryo.None,
                removeDelimiter = Cryo.None,
                revealInterval = Cryo.None,
                text = text
            }
        )
    end, { arg1, text })

    return React.createElement(SduiText, var2)
end

return SduiRevealText
