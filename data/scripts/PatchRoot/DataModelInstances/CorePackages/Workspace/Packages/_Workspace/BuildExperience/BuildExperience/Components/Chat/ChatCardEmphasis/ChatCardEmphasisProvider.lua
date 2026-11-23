-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T19:31:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local BuildExperienceParent = script:FindFirstAncestor("BuildExperience").Parent

local React = require(BuildExperienceParent.React)

local ChatCardEmphasisContext = require(script.Parent.ChatCardEmphasisContext)
local createChatCardEmphasisStore = require(script.Parent.createChatCardEmphasisStore)

local function ChatCardEmphasisProvider(tbl1)
    local value = React.useMemo(createChatCardEmphasisStore, {})

    return React.createElement(ChatCardEmphasisContext.Provider, { value = value }, tbl1.children)
end

return ChatCardEmphasisProvider
