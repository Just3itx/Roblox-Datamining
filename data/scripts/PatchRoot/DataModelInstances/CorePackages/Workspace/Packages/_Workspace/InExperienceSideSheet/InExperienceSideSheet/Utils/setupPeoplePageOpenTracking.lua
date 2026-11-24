-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:04Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local GetSideSheetConfigStore = require(InExperienceSideSheet.Stores.GetSideSheetConfigStore)
local getDidSideSheetOpenWithPeoplePage = require(InExperienceSideSheet.Utils.getDidSideSheetOpenWithPeoplePage)
local toggleSideSheet = require(InExperienceSideSheet.Utils.toggleSideSheet)

local tbl1 = { Players = true, peoplepage = true }

local bool1 = false

return function(tbl2)
    if bool1 then
        return
    end
    bool1 = true

    local sideSheetConfigStore = GetSideSheetConfigStore(false)

    local function isPeoplePage(str1: string?): boolean -- Luacid: Inlined by compiler; 4 call sites recovered
        return tbl1[str1 or ""] == true
    end

    local function updateIsPeoplePageOpen(str1: string?) -- Luacid: Inlined by compiler; 2 call sites recovered
        sideSheetConfigStore.setIsPeoplePageOpen(tbl2:GetVisibility() and not not isPeoplePage(str1))
    end

    tbl2.CurrentPageSignal:connect(function(str1: string?)
        if not isPeoplePage(str1) and getDidSideSheetOpenWithPeoplePage() then
            toggleSideSheet(false)
        end

        updateIsPeoplePageOpen(str1)
    end)

    tbl2.SettingsShowSignal:connect(function(bool2: boolean)
        if not bool2 then
            sideSheetConfigStore.setIsPeoplePageOpen(false)
            return
        end

        local currentPage = if tbl2.Pages then tbl2.Pages.CurrentPage else nil
        local pageName = if currentPage then currentPage.Page.Name else nil
        updateIsPeoplePageOpen(pageName)
    end)
end
