-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:31:00Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable
local Constants = require(ShareGame.Constants)
local OpenPage = require(ShareGame.Actions.OpenPage)
local ClosePage = require(ShareGame.Actions.ClosePage)

return function(arg1, arg2)
    arg1 = arg1 or {
        IsOpen = false,
        Route = Constants.PageRoute.NONE
    }

    if arg2.type == OpenPage.name then
        return (Immutable.JoinDictionaries(arg1, { IsOpen = true, Route = arg2.route or Constants.PageRoute.NONE }))
    end
    if arg2.type == ClosePage.name then
        arg1 = Immutable.JoinDictionaries(arg1, { IsOpen = false, Route = arg2.route or Constants.PageRoute.NONE })
    end

    return arg1
end
