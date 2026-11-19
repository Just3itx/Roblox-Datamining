-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-19T19:51:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Immutable = require(script.Parent.Parent.Immutable)

local SetActiveTab = require(script.Parent.Parent.Actions.SetActiveTab)
local SetTabList = require(script.Parent.Parent.Actions.SetTabList)

local FFlagDevConsoleTabReselectKeepsClientView = require(script.Parent.Flags.FFlagDevConsoleTabReselectKeepsClientView)

return function(tbl1, tbl2)
    local var1 = tbl1 or {
        isDeveloperView = false,
        isClientView = true,
        tabList = {},
        currTabIndex = nil
    }

    if tbl2.type == SetActiveTab.name then
        if var1.tabList[tbl2.newTabIndex] then
            local tbl3 = {
                currTabIndex = tbl2.newTabIndex,
                isClientView = tbl2.isClientView
            }

            if var1.currTabIndex ~= tbl2.newTabIndex then
                tbl3.isClientView = true
            end

            if FFlagDevConsoleTabReselectKeepsClientView and tbl3.isClientView == nil then
                tbl3.isClientView = true
            end

            local var2 = Immutable.JoinDictionaries(var1, tbl3)

            if tbl3.isClientView == nil then
                var2 = Immutable.RemoveFromDictionary(var2, "isClientView")
            end
            return var2
        end
    elseif tbl2.type == SetTabList.name and tbl2.tabList[tbl2.initIndex] then
        local tbl3 = {
            currTabIndex = tbl2.initIndex,
            tabList = tbl2.tabList,
            isDeveloperView = tbl2.isDeveloperView,
            isClientView = true
        }

        return Immutable.JoinDictionaries(var1, tbl3)
    end

    return var1
end
