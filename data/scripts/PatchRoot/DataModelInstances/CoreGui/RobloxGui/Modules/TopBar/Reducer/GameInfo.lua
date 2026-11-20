-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T01:11:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")

local Rodux = require(CorePackages.Packages.Rodux)

local RobloxTranslator = require(CorePackages.Workspace.Packages.RobloxTranslator)

local Actions = script.Parent.Parent.Actions

local SetGameName = require(Actions.SetGameName)

local scriptParentParent = script.Parent.Parent
if require(scriptParentParent.Flags.FFlagTopBarDeprecateGameInfoRodux) then
    return nil
end

local createReducer = Rodux.createReducer
local tbl1 = {
    name = RobloxTranslator:FormatByKey("CoreScripts.TopBar.GameNamePlaceHolder")
}
local tbl2 = {}
tbl2[SetGameName.name] = function(_, arg1)
    return {
        name = arg1.gameName
    }
end

return createReducer(tbl1, tbl2)
