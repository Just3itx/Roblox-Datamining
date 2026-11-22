-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T15:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ServerTriggeredModalsParent = script:FindFirstAncestor("ServerTriggeredModals").Parent

local React = require(ServerTriggeredModalsParent.React)
local SharedFlags = require(ServerTriggeredModalsParent.SharedFlags)

local PromptsHandler = require(script.Parent.PromptsHandler).PromptsHandler
local PromptsEntryPoint = require(script.Parent.PromptsEntryPoint)
local PromptStyle = require(script.Parent.PromptStyle)

local FFlagPromptsEdpOpenReplaceOnFetch = SharedFlags.FFlagPromptsEdpOpenReplaceOnFetch

local function StreamPromptsHandler(tbl1)
    if tbl1.clientAttributes == nil then
        return nil
    end

    return React.createElement(PromptsHandler, {
        entryPoint = PromptsEntryPoint.NotificationStreamOpen,
        promptStyle = PromptStyle.InlineBanner,
        clientAttributes = tbl1.clientAttributes,
        bottomPadding = tbl1.bottomPadding,
        replaceOnFetch = if FFlagPromptsEdpOpenReplaceOnFetch then true else nil
    })
end

return StreamPromptsHandler
