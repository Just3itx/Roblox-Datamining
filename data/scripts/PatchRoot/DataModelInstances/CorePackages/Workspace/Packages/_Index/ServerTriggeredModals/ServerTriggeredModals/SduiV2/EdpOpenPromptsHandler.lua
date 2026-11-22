-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local PromptsHandler = require(script.Parent.PromptsHandler).PromptsHandler
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)

local FFlagPromptsEdpOpenReplaceOnFetch = SharedFlags.FFlagPromptsEdpOpenReplaceOnFetch

local function EdpOpenPromptsHandler(tbl1)
    local clientAttributes = React.useMemo(function(): {universeId: any}?
        return if tbl1.universeId == nil then nil else {
            universeId = tbl1.universeId
        }
    end, { tbl1.universeId })

    if clientAttributes == nil then
        return nil
    end

    return React.createElement(PromptsHandler, {
        entryPoint = PromptsEntryPoint.ExperienceDetailsPageOpen,
        clientAttributes = clientAttributes,
        replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then true else nil
    })
end

return EdpOpenPromptsHandler
