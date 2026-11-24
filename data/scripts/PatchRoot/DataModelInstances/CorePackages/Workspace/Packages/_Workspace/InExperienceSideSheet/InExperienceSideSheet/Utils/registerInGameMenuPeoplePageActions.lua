-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:40:59Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 0
-- Luacid: preserve fresh closures and hash-only table allocation when recompiling.
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local var1 = nil
local var2 = nil

return {
    registerOpenPeoplePage = function(func1: (...any) -> (...any))
        var1 = func1
    end,
    registerClosePeoplePage = function(func1: (...any) -> (...any))
        var2 = func1
    end,
    openPeoplePage = function()
        if var1 then
            var1()
        end
    end,
    closePeoplePage = function(num1: number?)
        if num1 ~= nil
            and require(InExperienceSideSheet.Flags.FFlagClosePeoplePageWhenNoRoomBesideSideSheet)
            and not require(InExperienceSideSheet.Utils.getHasRoomForPeoplePage)(false, num1)
        then
            require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)(false).setDidSideSheetOpenWithPeoplePage(false)
        end
        if var2 then
            var2()
        end
    end
}
