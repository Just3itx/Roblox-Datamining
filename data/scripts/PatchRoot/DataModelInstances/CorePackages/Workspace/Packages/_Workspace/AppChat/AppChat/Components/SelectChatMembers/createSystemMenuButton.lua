-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:31:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local ArgCheck = require(AppChatParent.ArgCheck)
local React = require(AppChatParent.React)
local Roact = require(AppChatParent.Roact)
local Foundation = require(AppChatParent.Foundation)

local TextButton = require(AppChatParent.UIBlox).App.Button.TextButton

local FFlagAppChatDomLocatorFoundationMigration = require(AppChat.Flags.FFlagAppChatDomLocatorFoundationMigration)

return function(arg1)
    local localizedStrings = arg1.localizedStrings
    local isDisabled = arg1.isDisabled
    local onActivated = arg1.onActivated
    ArgCheck.isNotNil(localizedStrings, "props.localizedStrings")

    local button = Roact.createElement(TextButton, {
        text = localizedStrings.systemButtonText,
        isDisabled = isDisabled,
        onActivated = function()
            if isDisabled then
                return
            end

            if onActivated then
                onActivated(localizedStrings)
            end
        end
    })

    if not (FFlagAppChatDomLocatorFoundationMigration and arg1.testId) then
        return button
    end

    return React.createElement(Foundation.View, { tag = "auto-xy", testId = arg1.testId }, { button = button })
end
