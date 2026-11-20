-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:30:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local ShareGame = game:GetService("CoreGui").RobloxGui.Modules.Settings.Pages.ShareGame

local Immutable = require(CorePackages.Workspace.Packages.AppCommonLib).Immutable

local SetGameInfoCreated = require(ShareGame.Actions.SetGameInfoCreated)

return function(arg1, arg2)
    arg1 = arg1 or { Created = nil }

    if arg2.type == SetGameInfoCreated.name then
        arg1 = Immutable.Set(arg1, "Created", arg2.Created)
    end

    return arg1
end
