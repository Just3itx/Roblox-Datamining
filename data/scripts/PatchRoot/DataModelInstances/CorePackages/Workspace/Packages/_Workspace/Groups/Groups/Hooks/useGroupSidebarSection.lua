-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T17:50:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Groups = script:FindFirstAncestor("Groups")
local GroupsParent = Groups.Parent
local React = require(GroupsParent.React)
local SignalsReact = require(GroupsParent.SignalsReact)
local _SduiCoreSystem = require(GroupsParent.SduiCoreSystem)
local SduiSharedUtilities = require(GroupsParent.SduiSharedUtilities)
local DataHydration = require(GroupsParent.DataHydration)
local useGroupsWrapperContext = require(Groups.Contexts.useGroupsWrapperContext)
local GroupSidebarContext = require(Groups.Contexts.GroupSidebarContext)
local constants = require(Groups.Common.constants)
local getGroupSduiPageConfig = require(Groups.Common.getGroupSduiPageConfig)
local fetchGroupSduiPage = require(Groups.Common.fetchGroupSduiPage)

local function isFresh(num1: number?): boolean -- Luacid: Inlined by compiler; 1 call site recovered
    return not (num1 == nil) and os.clock() - num1 < constants.SIDEBAR_STALE_TIME_SEC
end

local function noRefreshes(): number
    return 0
end

local function useGroupSidebarSection(arg1, groupId: string)
    local var1 = useGroupsWrapperContext()
    local var2 = React.useContext(GroupSidebarContext)
    local configKey = arg1.configKey
    local var3 = React.useMemo(function()
        return getGroupSduiPageConfig("sidebarSection", var1.userId, groupId)
    end, { var1.userId, groupId })
    local var4 = if var3 then var3.configKey else ""

    local var5 = React.useCallback(function(arg2)
        if not configKey then
            return nil
        end
        local sduiApiStore = SduiSharedUtilities.getSduiApiStore()

        sduiApiStore.getData(configKey).data(arg2)
        local inputData = sduiApiStore.getInputData(configKey, "groupSidebarSection", arg2)
        if not inputData or inputData.group_id ~= groupId then
            return nil
        end
        return sduiApiStore.getRootConfig(configKey, arg2, `{configKey}_groupSidebarSection`)
    end, { configKey, groupId })
    local var6 = SignalsReact.useSignalState(var5)
    local var7 = React.useCallback(function(arg2)
        return SduiSharedUtilities.getSduiApiStore().getRootConfig(var4, arg2, nil)
    end, { var4 })
    local var8 = SignalsReact.useSignalState(var7)

    local var9 = React.useCallback(function(arg2)
        if not configKey or var5(arg2) == nil then
            return nil
        end
        return SduiSharedUtilities.getSduiApiStore().getDataUpdatedTimestamp(
            configKey,
            arg2,
            `{configKey}_groupSidebarSection`
        )
    end, { configKey, var5 })
    local var10 = React.useCallback(function(arg2): boolean
        local var10 = var9(arg2)
        local var11 = SduiSharedUtilities.getSduiApiStore().getDataUpdatedTimestamp(var4, arg2, nil)
        return not (var10 == nil) and (var11 == nil or var11 < var10)
    end, { var9, var4 })
    local var11 = SignalsReact.useSignalState(var10)

    local var12 = React.useRef(0)
    local var13 = React.useCallback(function(arg2)
        return SduiSharedUtilities.getSduiApiStore().getData(var4).status(arg2)
    end, { var4 })
    local status = SignalsReact.useSignalState(var13)

    local var15 = React.useCallback(function(bool1: boolean)
        if var3 then
            local loadTimer = SduiSharedUtilities.SduiLoadTimer.createLoadTimer(var3.surfaceKey)
            fetchGroupSduiPage(var3, loadTimer, bool1, constants.SIDEBAR_STALE_TIME_SEC)
        end
    end, { var3 })
    React.useEffect(function()
        if not var3 then
            return
        end
        var12.current = os.clock()
        local sduiApiStore = SduiSharedUtilities.getSduiApiStore()
        local dataUpdatedTimestamp = if configKey then sduiApiStore.getDataUpdatedTimestamp(configKey, false, `{configKey}_groupSidebarSection`) else nil

        if var5(false) ~= nil and isFresh(dataUpdatedTimestamp) then
            return
        end
        var15(false)
    end, {
        var3,
        var15,
        var5,
        configKey
    })

    local current = SignalsReact.useSignalState(if var2 then var2.sectionRefreshCount else noRefreshes)
    local var17 = React.useRef(current)
    React.useEffect(function()
        if current == var17.current then
            return
        end

        var17.current = current
        local var18 = var9(false)
        local bool1 = not (var18 == nil) and var12.current < var18
        var12.current = os.clock()
        if not bool1 then
            var15(true)
        end
    end, { current, var15, var9 })
    local retry = React.useCallback(function()
        var15(true)
    end, { var15 })

    local var19 = if var11 then var6 or var8 or var6 else var8 or var6
    local var20 = React.useRef(nil)
    if var19 then
        var20.current = { groupId = groupId, root = var19 }
    elseif status ~= DataHydration.DataHydrationTypes.DataStatus.Ready and var20.current and var20.current.groupId == groupId then
        var19 = var20.current.root
    end
    return { root = var19, status = status, retry = retry }
end

return useGroupSidebarSection
