-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:54Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CoreGui = game:GetService("CoreGui")
local CorePackages = game:GetService("CorePackages")

local ShareGame = CoreGui.RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable

local ClosePage = require(ShareGame.Actions.ClosePage)
local SetSearchAreaActive = require(ShareGame.Actions.SetSearchAreaActive)
local SetSearchText = require(ShareGame.Actions.SetSearchText)

local tbl1 = { SearchAreaActive = false, SearchText = "" }

return function(arg1, arg2)
    arg1 = arg1 or tbl1

    if arg2.type == SetSearchAreaActive.name then
        return (Immutable.Set(arg1, "SearchAreaActive", arg2.isActive))
    end

    if arg2.type == SetSearchText.name then
        return (Immutable.Set(arg1, "SearchText", arg2.searchText))
    end

    if arg2.type == ClosePage.name then
        arg1 = tbl1
    end

    return arg1
end
