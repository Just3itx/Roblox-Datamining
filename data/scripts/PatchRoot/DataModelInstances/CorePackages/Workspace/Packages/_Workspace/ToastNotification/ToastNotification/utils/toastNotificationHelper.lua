-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T19:40:57Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")
local scriptParentParent = script.Parent.Parent
local scriptParentParentParent = scriptParentParent.Parent
local type = require(scriptParentParent.type)
local constants = require(scriptParentParent.constants)
local dependencies = require(scriptParentParent.dependencies)
local Logger = require(scriptParentParent.Logger)
local Cryo = dependencies.Cryo
local TimeTrigger = dependencies.ToastNotificationProtocolEnums.TimeTrigger
local FFlagFriendshipNotifsUseSendrExperiment = require(scriptParentParentParent.SharedFlags).FFlagFriendshipNotifsUseSendrExperiment

local function _<T>(tbl1: {T}, arg1: T) -- Luacid: unused: defined but never referenced
    if not tbl1 then
        return { arg1 }
    end

    table.insert(tbl1, arg1)
    return tbl1
end

local function func1(arg1): string -- Luacid: Inlined by compiler; 1 call site recovered
    if arg1.button ~= nil then
        return "button"
    end

    if arg1.textBody ~= nil then
        return "textBody"
    end

    if arg1.thumbnail ~= nil then
        return "thumbnail"
    end

    if arg1.metaAction == nil then
        if arg1.singleMetaAction == nil then
            return "unknown"
        end

        return "singleMetaAction"
    end

    return "metaAction"
end

local function func2(arg1)
    if not arg1 then
        return nil
    end

    local visualItems = {
        button = nil,
        textBody = nil,
        thumbnail = nil,
        metaAction = nil,
        singleMetaAction = nil
    }

    for _, visualItem in ipairs(arg1.visualItems) do
        local str1 = func1(visualItem)

        if str1 == "unknown" then
            continue
        end

        local var1 = visualItems[str1]
        local var2 = visualItem[str1]

        if var1 then
            table.insert(var1, var2)
        else
            var1 = { var2 }
        end

        visualItems[str1] = var1
    end

    return {
        layoutKey = arg1.layoutKey,
        name = arg1.name,
        timeOnScreenMs = arg1.timeOnScreenMs,
        visualItems = visualItems
    }
end

local tbl1 = { positionX = 1, positionXOffset = -5, positionY = 0, anchorX = 1, anchorY = 0 }

local tbl2 = { positionX = 1, positionXOffset = 20, positionY = 0, anchorX = 0, anchorY = 0 }

local tbl3 = { positionX = 0.5, positionXOffset = 0, positionY = 0, anchorX = 0.5, anchorY = 0 }

local tbl4 = { positionX = 0.5, positionXOffset = 0, positionY = 0, anchorX = 0.5, anchorY = 1 }

local vector2 = Vector2.new(800, 600)

local function func3(vector2_2: Vector2) -- Luacid: Inlined by compiler; 2 call sites recovered
    local notificationRightInset = constants.FRRToastPosition.NotificationRightInset
    return vector2_2.Y * (constants.FRRToastPosition.NotificationFrameTopScale + constants.FRRToastPosition.NotificationFrameHeightScale) - notificationRightInset
end

local function func4(bool1: boolean, bool2: boolean?, vector2_2: Vector2): {anchorX: number, anchorY: number, positionX: number, positionXOffset: any, positionY: number, positionYOffset: any} | {anchorX: number, anchorY: number, positionX: number, positionXOffset: number, positionY: number, positionYOffset: any}
    local positionYOffset = func3(vector2_2) - vector2_2.Y
    local tbl5 = {
        positionX = 1,
        positionXOffset = -constants.FRRToastPosition.NotificationRightInset,
        positionY = 1,
        positionYOffset = positionYOffset,
        anchorX = 1,
        anchorY = 1
    }

    return if bool1 then tbl5 elseif bool2 then tbl5 else {
        positionX = 1,
        positionXOffset = 20,
        positionY = 1,
        positionYOffset = positionYOffset,
        anchorX = 0,
        anchorY = 1
    }
end

return {
    calculateToastPosition = function(bool1: boolean, bool2: boolean, positionYOffset: number, bool3: boolean?, str1: string?, vector2_2: Vector2?)
        if FFlagFriendshipNotifsUseSendrExperiment and str1 == "legacyBottomRight" then
            local var1 = vector2_2 or workspace.CurrentCamera and workspace.CurrentCamera.ViewportSize or vector2
            return (func4(bool1, bool3, var1))
        end

        local vector2_3 = if GuiService then GuiService:GetGuiInset() else Vector2.new(0, 0)
        local num1 = if GuiService then vector2_3.Y + 20 else 60

        if bool1 then
            if bool2 then
                return Cryo.Dictionary.union(tbl1, { positionYOffset = positionYOffset })
            end
            return Cryo.Dictionary.union(tbl3, { positionYOffset = positionYOffset + vector2_3.Y })
        elseif bool2 then
            if bool3 then
                return Cryo.Dictionary.union(tbl1, { positionYOffset = positionYOffset })
            end
            return Cryo.Dictionary.union(tbl2, { positionYOffset = positionYOffset })
        elseif bool3 then
            return Cryo.Dictionary.union(tbl3, { positionYOffset = positionYOffset + vector2_3.Y })
        else
            return Cryo.Dictionary.union(tbl4, { positionYOffset = -1 * num1 })
        end
    end,
    getNotificationScript2LegacyToastOffsets = FFlagFriendshipNotifsUseSendrExperiment and function(vector2_2: Vector2)
        local var1 = func3(vector2_2) - vector2_2.Y
        return -constants.FRRToastPosition.NotificationRightInset, var1
    end or nil,
    calculateTimeRemaining = function(arg1, num1: number?, num2: number?): number
        num1 = num1 or DateTime.now().UnixTimestampMillis
        num2 = num2 or DateTime.now().UnixTimestampMillis
        local num3 = 0

        if arg1.trigger == TimeTrigger.OnReceive then
            num3 = arg1.timespanMs - (DateTime.now().UnixTimestampMillis - num1)
        elseif arg1.trigger == TimeTrigger.OnDisplay then
            num3 = arg1.timespanMs - (DateTime.now().UnixTimestampMillis - num2)
        end

        return math.max(num3, 0)
    end,
    getDeviceOrientation = function(vector2_2: Vector2)
        return if vector2_2.X > vector2_2.Y then type.DeviceOrientationEnum.Landscape else type.DeviceOrientationEnum.Portrait
    end,
    getNotificationSize = function(bool1: boolean, num1: number): UDim2
        if num1 < constants.FullWidthDeviceThreshold then
            return UDim2.new(0, num1 - 24, 0, 0)
        elseif bool1 then
            if num1 < constants.CompactCardThreashold then
                return UDim2.new(0, constants.InExperienceToastWidth, 0, 0)
            end
            return UDim2.new(0, constants.InAppToastWidth, 0, 0)
        else
            return UDim2.new(0, constants.InAppToastWidth, 0, 0)
        end
    end,
    marshalNotificationData = function(arg1)
        local tbl5 = {
            currentState = arg1.content.currentState,
            notificationType = arg1.content.notificationType,
            id = arg1.content.id,
            priority = arg1.content.priority,
            clientEventsPayload = arg1.content.clientEventsPayload,
            deliverTimestamp = arg1.deliverTimestamp,
            notificationReceivedTimestampMs = arg1.notificationReceivedTimestampMs,
            timers = arg1.content.timers,
            luaNotifInfo = arg1.luaNotifInfo
        }
        if arg1.content.states then
            tbl5.state = func2(arg1.content.states[arg1.content.currentState])
        end

        return tbl5
    end,
    isToastToRight = function(landscape): boolean
        return landscape == type.DeviceOrientationEnum.Landscape
    end,
    isDesktopDevice = function(): boolean
        local none = Enum.Platform.None
        pcall(function()
            none = UserInputService:GetPlatform()
        end)
        local windows = Enum.Platform.Windows
        local bool1

        if none == windows then
            bool1 = true
        else
            local osx = Enum.Platform.OSX

            if none == osx then
                bool1 = true
            else
                local uwp = Enum.Platform.UWP
                bool1 = none == uwp
            end
        end

        return bool1
    end,
    getNearestWholeNumber = function(num1: number): number
        if num1 % 1 < 0.5 then
            return math.floor(num1)
        end
        return math.ceil(num1)
    end,
    getTimerFromCardData = function(arg1, str1: string)
        if arg1 and arg1.timers and arg1.timers[str1] then
            return arg1.timers[str1]
        end
        Logger:warning("timerKey {} not found in list of timers. Using default.", str1)
        return {
            timespanMs = 0,
            trigger = TimeTrigger.OnDisplay
        }
    end,
    fireEvent = function(arg1, tbl5)
        arg1.sendEventDeferred("ToastNotification", "toastNotificationClientEvent", tbl5)
    end,
    isUserThumbnail = function(arg1): boolean
        return arg1.idType == type.SENDERThumbnailTypeEnum.User or arg1.idType == type.SENDERThumbnailTypeEnum.AvatarImageUrl
    end
}
