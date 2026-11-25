-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T03:01:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent

local GuiService = game:GetService("GuiService")
local Players = game:GetService("Players")
local Signals = require(scriptParentParentParent.Signals)
local resolveDisplayName = require(scriptParentParent.Common.resolveDisplayName)
local getHeadshotThumbnail = require(scriptParentParent.Common.getHeadshotThumbnail)
local _PlayerListContextMenuTelemetryAction = require(script.Parent.PlayerListContextMenuTelemetryAction)

local PlayerListContextMenuTelemetry = nil
local function getContextMenuTelemetry() -- Luacid: Inlined by compiler; 5 call sites recovered
    if PlayerListContextMenuTelemetry == nil then
        PlayerListContextMenuTelemetry = require(script.Parent.PlayerListContextMenuTelemetry)
    end
    return PlayerListContextMenuTelemetry
end

local var1, var2 = Signals.createSignal(nil)
local getMenuData = var1
local var4 = var2

local var5, var6 = Signals.createSignal(nil)
local getPendingConfirmKey = var5
local var8 = var6

local tbl1 = ({})
local num1 = 0

local function consumeOnceGroup(onceGroup: string) -- Luacid: Inlined by compiler; 2 call sites recovered
    num1 += 1
    local num2 = num1
    tbl1[onceGroup] = num2
    task.delay(5, function()
        if tbl1[onceGroup] == num2 then
            tbl1[onceGroup] = nil
        end
    end)
end

local function setMenuData(arg1)
    local bool1 = not (arg1 == nil) and getMenuData(false) == nil
    var8(nil)
    table.clear(tbl1)
    var4(arg1)
    if bool1 then
        getContextMenuTelemetry().logAction("menu_open", arg1.telemetry)
    end
end

local var9 = nil
local var10 = nil
local bool1 = false

local num2 = 0

local function closeContextMenu()
    local var11 = getMenuData(false)
    num2 += 1
    var8(nil)
    if var11 == nil then
        return
    end
    getContextMenuTelemetry().logAction("menu_close", var11.telemetry)
    var8(nil)
    table.clear(tbl1)
    var4(nil)

    if var10 then
        var10()
    end
end

local function setOnDismiss(func1: ((...any) -> (...any))?)
    var10 = func1
end

local function setSuppressNextDismissRestore(bool2: boolean)
    bool1 = bool2
end

local function takeSuppressNextDismissRestore(): boolean
    local bool2 = bool1
    bool1 = false
    return bool2
end

local function setMenuDataIfCurrent(arg1, num3: number): boolean
    if num3 ~= num2 then
        return false
    end
    setMenuData(arg1)
    return true
end

local function buildMenuHeader(arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    return {
        displayName = resolveDisplayName(arg1),
        username = `@{arg1.Name}`,
        thumbnail = getHeadshotThumbnail(arg1.UserId)
    }
end

local function fallbackMenuData(player, vector2: Vector2?)
    local items = {}
    if GuiService:GetInspectMenuEnabled() then
        table.insert(items, {
            key = "examine",
            label = "Examine avatar",
            telemetryAction = "avatar_examine",
            onActivated = function()
                GuiService:InspectPlayerFromUserIdWithCtx(player.UserId, "leaderBoard")
                closeContextMenu()
            end
        })
    end
    local localPlayer = Players.LocalPlayer
    return {
        player = player,
        header = buildMenuHeader(player),
        items = items,
        anchorPosition = vector2,
        telemetry = {
            isSelf = not (localPlayer == nil) and player == localPlayer
        }
    }
end

local function openContextMenu(player, vector2: Vector2?, arg1) -- Luacid: Inlined by compiler; 1 call site recovered
    num2 += 1

    var8(nil)
    if var9 then
        var9(player, vector2, num2, arg1)
        return
    end

    setMenuData((fallbackMenuData(player, vector2)))
end

local var11 = nil
local currentPlayer = nil

local function logItemActivated(tbl2) -- Luacid: Inlined by compiler; 2 call sites recovered
    if tbl2.telemetryAction ~= nil then
        local var12 = getMenuData(false)
        getContextMenuTelemetry().logAction(tbl2.telemetryAction, var12 and var12.telemetry)
    end
end

return {
    getMenuData = getMenuData,
    setMenuData = setMenuData,
    setMenuDataIfCurrent = setMenuDataIfCurrent,
    openContextMenu = openContextMenu,
    toggleContextMenu = function(player, vector2: Vector2?, arg1)
        local var12 = getMenuData(false)
        if var12 ~= nil and var12.player == player then
            closeContextMenu()
            return
        end
        currentPlayer = player
        var11 = arg1
        openContextMenu(player, vector2, nil)
    end,
    getAnchorRow = function()
        local var12 = getMenuData(false)
        return if var12 == nil or var12.player ~= currentPlayer then nil else var11
    end,
    closeContextMenu = closeContextMenu,
    setContextMenuOpener = function(func1: ((...any) -> (...any))?)
        var9 = func1
    end,
    setOnDismiss = setOnDismiss,
    setSuppressNextDismissRestore = setSuppressNextDismissRestore,
    takeSuppressNextDismissRestore = takeSuppressNextDismissRestore,
    buildMenuHeader = buildMenuHeader,
    reset = function()
        num2 += 1
        var8(nil)
        table.clear(tbl1)
        var4(nil)

        var8(nil)
        var9 = nil
        var10 = nil
        bool1 = false
        var11 = nil
        currentPlayer = nil
    end,
    getPendingConfirmKey = getPendingConfirmKey,
    activateMenuItem = function(tbl2)
        if tbl2.onceGroup ~= nil and tbl1[tbl2.onceGroup] ~= nil then
            return
        end

        if tbl2.requiresConfirm then
            if getPendingConfirmKey() == tbl2.key then
                if tbl2.onceGroup ~= nil then
                    consumeOnceGroup(tbl2.onceGroup)
                end
                var8(nil)
                logItemActivated(tbl2)

                if tbl2.onActivated then
                    tbl2.onActivated()
                end
            else
                var8(tbl2.key)
            end
        else
            if getPendingConfirmKey() ~= nil then
                var8(nil)
            end
            if tbl2.onceGroup ~= nil then
                consumeOnceGroup(tbl2.onceGroup)
            end

            logItemActivated(tbl2)

            if tbl2.onActivated then
                tbl2.onActivated()
            end
        end
    end
}
