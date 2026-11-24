-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:31:42Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")
local InExperienceSideSheetParent = InExperienceSideSheet.Parent

local _Signals = require(InExperienceSideSheetParent.Signals)

local GetSideSheetConfigStore = require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)

return function(arg1)
    return GetSideSheetConfigStore(arg1).getDidSideSheetOpenWithPeoplePage(arg1)
end
