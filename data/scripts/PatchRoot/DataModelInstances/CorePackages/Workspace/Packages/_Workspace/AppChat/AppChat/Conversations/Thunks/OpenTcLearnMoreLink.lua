-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:51:27Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local AppPage = require(AppChatParent.RobloxAppEnums).AppPage
local NavigateDown = require(AppChatParent.NavigationRodux).Thunks.NavigateDown
local FFlagSignalsNavP3Dispatch = require(AppChatParent.SharedFlags).FFlagSignalsNavP3Dispatch
local NavigationCommands = if FFlagSignalsNavP3Dispatch then require(AppChatParent.RobloxAppNavigation).NavigationCommands else nil
local detail = game:DefineFastString("AppChatTcLearnMoreUrl", "https://en.help.roblox.com/")

return function()
    return function(arg1)
        local tbl1 = {
            name = AppPage.GenericWebPage,
            detail = detail,
            extraProps = { title = "" }
        }

        if FFlagSignalsNavP3Dispatch then
            NavigationCommands.down(NavigationCommands.fromLegacyPage(tbl1))
            return
        end
        arg1:dispatch(NavigateDown(tbl1, nil))
    end
end
