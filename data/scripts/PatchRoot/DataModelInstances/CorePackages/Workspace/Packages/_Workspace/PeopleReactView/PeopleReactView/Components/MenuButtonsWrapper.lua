-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T01:30:51Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local MenuButtons = game:GetService("CoreGui"):WaitForChild("RobloxGui"):WaitForChild("Modules"):WaitForChild("Settings"):WaitForChild(
    "Components"
):WaitForChild(
    "MenuButtons"
)

local PeopleReactViewParent = script:FindFirstAncestor("PeopleReactView").Parent

local Foundation = require(PeopleReactViewParent.Foundation)
local React = require(PeopleReactViewParent.React)
local PeopleService = require(PeopleReactViewParent.PeopleService)
local SignalsReact = require(PeopleReactViewParent.SignalsReact)

local View = Foundation.View

local useSignalState = SignalsReact.useSignalState

local MenuButtons2 = require(MenuButtons:WaitForChild("MenuButtons"))

return function()
    local var1 = React.useMemo(function()
        return PeopleService.getService("SettingsHubService")
    end, {})

    local var2 = useSignalState(var1.showMenuButtonsContainer)

    local var3 = React.useMemo(function()
        local var3 = var1.hubRef()
        if var3 then
            return var3:GetExperienceControlStore()
        end
        return nil
    end, {})

    if not (var3 and var2) then
        return nil
    end

    return React.createElement(View, { LayoutOrder = -1, tag = "size-full-1000" }, {
        MenuButtonsContainer = React.createElement(MenuButtons2, {
            onLeaveGame = var3.onLeaveGame,
            onRespawn = var3.onRespawn,
            onResume = var3.onResume,
            setAddMenuKeyBindings = function() end,
            setRemoveMenuKeyBindings = function() end,
            getVisibility = function(): boolean
                return true
            end,
            getCanRespawn = var3.getCanRespawn
        })
    })
end
