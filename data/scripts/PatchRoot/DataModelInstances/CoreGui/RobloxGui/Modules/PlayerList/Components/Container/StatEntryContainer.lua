-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T22:50:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local CoreGui = game:GetService("CoreGui")
local RobloxGui = CoreGui:WaitForChild("RobloxGui")

local GameTranslator = require(RobloxGui.Modules.GameTranslator)
local React = require(CorePackages.Packages.React)
local Cryo = require(CorePackages.Packages.Cryo)
local Signals = require(CorePackages.Packages.Signals)
local SignalsReact = require(CorePackages.Packages.SignalsReact)
local PlayerList = require(CorePackages.Workspace.Packages.PlayerList)
local _LeaderboardStore = require(CorePackages.Workspace.Packages.LeaderboardStore)

local useLeaderboardStore = PlayerList.Hooks.useLeaderboardStore

local StatEntryView = PlayerList.Presentation.StatEntryView

return React.memo(function(tbl1) -- name: StatEntryContainer
    local var1 = useLeaderboardStore().getGameStatsList().getData(tbl1.statName, false)

    local tbl2 = {
        statName = React.useMemo(function()
            return GameTranslator:TranslateGameText(CoreGui, tbl1.statName)
        end, { tbl1.statName }),
        statValue = SignalsReact.useSignalBinding(Signals.createComputed(function(arg1)
            if tbl1.stat then
                return (tbl1.stat(arg1))
            end

            return "-"
        end)),
        layoutOrder = SignalsReact.useSignalBinding(Signals.createComputed(function(arg1)
            if var1 then
                return (var1.order(arg1))
            end

            return math.huge
        end))
    }
    local var2 = Cryo.Dictionary.join(tbl2, tbl1)

    return React.createElement(StatEntryView, var2)
end)
