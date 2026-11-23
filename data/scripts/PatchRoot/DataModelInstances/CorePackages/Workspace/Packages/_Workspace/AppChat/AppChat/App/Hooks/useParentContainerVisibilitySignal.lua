-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T07:01:08Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local React = require(AppChatParent.React)
local RoactUtils = require(AppChatParent.RoactUtils)

local EnteredChatFromEntryPoint = require(AppChat.Actions.EnteredChatFromEntryPoint)
local setAppChatVisible = require(AppChat.App.AppChatVisible).setAppChatVisible
local ParentContainerContext = require(AppChat.Contexts.ParentContainer.ParentContainerContext)

local useDispatch = RoactUtils.Hooks.RoactRodux.useDispatch

return function()
    local var1 = React.useContext(ParentContainerContext)
    local visibilitySignal = var1.visibilitySignal
    local getShouldSetAppChatVisible = var1.getShouldSetAppChatVisible
    local entryPoint = var1.entryPoint
    local var2 = useDispatch()

    React.useEffect(function()
        local connection = visibilitySignal:connect(function(arg1, arg2)
            if getShouldSetAppChatVisible(arg1) then
                setAppChatVisible(true)
                var2(EnteredChatFromEntryPoint(arg2 or entryPoint))
                return
            end
            setAppChatVisible(false)
        end)

        return function()
            if connection then
                connection:disconnect()
            end
        end
    end, {
        setAppChatVisible,
        var2,
        visibilitySignal,
        getShouldSetAppChatVisible,
        entryPoint
    })
end
