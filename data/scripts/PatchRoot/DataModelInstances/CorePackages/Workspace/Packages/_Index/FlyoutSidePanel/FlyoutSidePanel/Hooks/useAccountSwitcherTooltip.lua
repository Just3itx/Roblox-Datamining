-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-21T13:41:21Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local FlyoutSidePanel = script:FindFirstAncestor("FlyoutSidePanel")
local FlyoutSidePanelParent = FlyoutSidePanel.Parent

local React = require(FlyoutSidePanelParent.React)
local useDrawerVisible = require(FlyoutSidePanelParent.Drawer).Hooks.useDrawerVisible
local AppStorageJsonCacheUtils = require(FlyoutSidePanelParent.AppCommonLib).Utils.AppStorageJsonCacheUtils

local FFlagFixFlyoutAccountSwitcherTooltipEmptyString = require(FlyoutSidePanel.Flags.FFlagFixFlyoutAccountSwitcherTooltipEmptyString)

local AppStorageService = game:GetService("AppStorageService")
local HttpService = game:GetService("HttpService")

local num1 = game:DefineFastInt("FlyoutAccountSwitcherTooltipMaxShows", 1)

local function readShowCount(arg1, bool1: boolean?, arg2)
    local cachedJsonForKey = arg1:getCachedJsonForKey("FlyoutSidePanelAccountSwitcherTooltipSeen", bool1)
    if typeof(cachedJsonForKey) == "number" then
        return cachedJsonForKey
    end
    if FFlagFixFlyoutAccountSwitcherTooltipEmptyString and arg2 ~= nil then
        local success, result = pcall(function()
            return arg2:GetItem("FlyoutSidePanelAccountSwitcherTooltipSeen")
        end)
        if success and result == "" then
            return 0
        end
    end
    return nil
end

local function writeShowCount(arg1, arg2, input: number) -- Luacid: Inlined by compiler; 2 call sites recovered
    if pcall(function()
        arg1:SetItem("FlyoutSidePanelAccountSwitcherTooltipSeen", HttpService:JSONEncode(input))
        arg1:Flush()
    end) then
        arg2:getCachedJsonForKey("FlyoutSidePanelAccountSwitcherTooltipSeen", true)
    end
end

local function useAccountSwitcherTooltip(tbl1, bool1: boolean, arg1, tbl2)
    local var1 = if arg1 == nil then AppStorageService else arg1

    local var2 = React.useMemo(function()
        if arg1 == nil then
            return AppStorageJsonCacheUtils.default
        end
        return AppStorageJsonCacheUtils.new(var1)
    end, { arg1, var1 })
    local var3 = useDrawerVisible()
    local var4, var5 = React.useState(function()
        return (readShowCount(var2, nil, if FFlagFixFlyoutAccountSwitcherTooltipEmptyString then var1 else nil))
    end)
    local var6, var7 = React.useState(false)
    local var8, var9 = React.useState(false)

    React.useEffect(function()
        var9(tbl1.current ~= nil)
    end, { tbl1, var3, bool1 })

    local bool2 = bool1 and var3 and var8 and not var6

    if bool2 then
        if var4 == nil then
            bool2 = false
        else
            bool2 = var4 < num1
        end
    end

    React.useEffect(function()
        if bool2 and var4 ~= nil then
            writeShowCount(var1, var2, var4 + 1)
        end
    end, {
        bool2,
        var4,
        var1,
        var2
    })
    local useEffect = React.useEffect
    local function func1()
        if not var3 then
            var7(false)
            var5((readShowCount(var2, true, if FFlagFixFlyoutAccountSwitcherTooltipEmptyString then var1 else nil)))
        end
    end

    local var10 = if FFlagFixFlyoutAccountSwitcherTooltipEmptyString then var1 else nil
    useEffect(func1, { var3, var2, var10 })

    local var11 = React.useCallback(function()
        var7(true)
    end, {})

    local current = React.useCallback(function()
        var7(true)
        writeShowCount(var1, var2, num1)
    end, { var1, var2 })

    if tbl2 ~= nil then
        tbl2.current = current
    end

    return bool2, current, var11
end

return useAccountSwitcherTooltip
