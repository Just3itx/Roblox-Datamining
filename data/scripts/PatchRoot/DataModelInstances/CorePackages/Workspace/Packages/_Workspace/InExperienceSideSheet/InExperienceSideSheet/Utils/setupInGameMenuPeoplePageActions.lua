-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T21:41:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local InExperienceSideSheet = script:FindFirstAncestor("InExperienceSideSheet")

local registerInGameMenuPeoplePageActions = require(InExperienceSideSheet.Utils.registerInGameMenuPeoplePageActions)

return function(tbl1)
    registerInGameMenuPeoplePageActions.registerOpenPeoplePage(function()
        local playersPage = tbl1.PlayersPage
        if playersPage == nil then
            return
        end

        if tbl1:GetVisibility() then
            tbl1:SwitchToPage(playersPage, true, 1)
        else
            tbl1:SetVisibility(true, false, playersPage)
        end
    end)

    registerInGameMenuPeoplePageActions.registerClosePeoplePage(function()
        local playersPage = tbl1.PlayersPage
        local pages = tbl1.Pages
        if tbl1:GetVisibility() and playersPage ~= nil and pages ~= nil and pages.CurrentPage == playersPage then
            tbl1:SetVisibility(false)
        end
    end)
end
