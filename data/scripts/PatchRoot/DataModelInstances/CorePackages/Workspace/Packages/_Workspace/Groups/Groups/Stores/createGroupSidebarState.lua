-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:51:07Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GroupsParent = script:FindFirstAncestor("Groups").Parent
local Signals = require(GroupsParent.Signals)

local function createGroupSidebarState(groupId: string?, tbl1)
    local function overview(groupId2: string?): {groupId: string, section: string}? -- Luacid: Inlined by compiler; 1 call site recovered
        return if groupId2 then { groupId = groupId2, section = "overview" } else nil
    end

    local activeDestination, var2 = Signals.createSignal(groupId and { groupId = groupId, section = "overview" } or nil)

    local expanded, var4 = Signals.createSignal(not tbl1 and {} or table.clone(tbl1))
    local var5, var6 = Signals.createSignal({})
    local sectionRefreshCount, var8 = Signals.createSignal(0)
    local tbl2 = ({})

    return {
        activeDestination = activeDestination,
        selectedGroupId = function(arg1)
            local var9 = activeDestination(arg1)
            return if var9 then var9.groupId else nil
        end,
        selectGroup = function(groupId2: string?)
            var2((overview(groupId2)))
        end,
        expanded = expanded,
        hasEntryExpansion = tbl1 ~= nil,
        setSectionFrame = function(str1: string, arg1)
            tbl2[str1] = arg1
        end,
        getSectionFrame = function(str1: string)
            return tbl2[str1]
        end,
        isVisiting = function(str1: string, arg1): boolean
            return var5(arg1)[str1] == true
        end,
        setVisitingGroups = function(tbl3)
            local tbl4 = ({})
            for _, value in tbl3 do
                tbl4[value] = true
            end
            var6(tbl4)
        end,
        sectionRefreshCount = sectionRefreshCount,
        refreshSections = function()
            var8(sectionRefreshCount(false) + 1)
        end,
        setExpanded = function(str1: string, bool1: boolean)
            local var9 = table.clone(expanded(false))
            var9[str1] = bool1
            var4(var9)
        end
    }
end

return createGroupSidebarState
