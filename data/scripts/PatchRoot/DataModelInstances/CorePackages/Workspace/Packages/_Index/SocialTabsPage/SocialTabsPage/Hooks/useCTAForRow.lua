-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T21:01:25Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialTabsPage = script:FindFirstAncestor("SocialTabsPage")
local SocialTabsPageParent = SocialTabsPage.Parent

local React = require(SocialTabsPageParent.React)
local useSignalState = require(SocialTabsPageParent.SignalsReact).useSignalState
local DataStatus = require(SocialTabsPageParent.DataHydration).DataStatus

local ButtonTypes = require(SocialTabsPageParent.UserList).Enums.ButtonTypes

local mapProfileCTAToRowCTA = require(SocialTabsPage.Utils.mapProfileCTAToRowCTA)
local _Types = require(SocialTabsPage.Common.Types)

local function func1()
    return nil
end

local function useCTAForRow(arg1, str1: string, str2: string, tbl1)
    local var1 = if arg1 then arg1.data else func1
    local var2 = if arg1 then arg1.status else func1
    local var3 = useSignalState(var1)
    local var4 = useSignalState(var2)

    return React.useMemo(function()
        if var4 == DataStatus.NotReady then
            return nil
        end

        local var5 = mapProfileCTAToRowCTA(var3, str1, str2)

        if not var5 or var5.type ~= ButtonTypes.Join or not tbl1 then
            return var5
        end

        local onActivated = var5.onActivated
        return {
            type = var5.type,
            onActivated = function()
                if onActivated then
                    onActivated()
                end
                tbl1.joinExperience()
            end,
            isDisabled = not tbl1.isInExperience,
            isLoading = tbl1.isLoading
        }
    end, {
        var3,
        var4,
        str1,
        str2,
        tbl1
    })
end
return useCTAForRow
