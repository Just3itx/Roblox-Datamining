-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)
local ChatCardEmphasisPositionContext = require(script.Parent.ChatCardEmphasisPositionContext)

local function ChatCardEmphasisPositionProvider(tbl1)
    local var1 = React.useContext(ChatCardEmphasisPositionContext)
    local value = React.useMemo(function()
        return {
            messageOrder = tbl1.messageOrder or (if var1 then var1.messageOrder else 0),
            segmentOrder = tbl1.segmentOrder or (if var1 then var1.segmentOrder else 0),
            childOrder = tbl1.childOrder or 0
        }
    end, {
        var1,
        tbl1.messageOrder,
        tbl1.segmentOrder,
        tbl1.childOrder
    })
    return React.createElement(ChatCardEmphasisPositionContext.Provider, { value = value }, tbl1.children)
end

return ChatCardEmphasisPositionProvider
