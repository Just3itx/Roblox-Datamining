-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T00:21:22Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local UserInputService = game:GetService("UserInputService")
local GuiService = game:GetService("GuiService")

local NotificationsCommon = script:FindFirstAncestor("NotificationsCommon")
local NotificationsCommonParent = NotificationsCommon.Parent
local Cryo = require(NotificationsCommonParent.Cryo)

local type = require(NotificationsCommon.type)
local constants = require(NotificationsCommon.constants)

local bool1 = game:DefineFastFlag("FFlagLuaAppFixToastNotificationClosePosition", false)

return {
    calculateToastPosition = function(bool2: boolean, bool3: boolean, positionYOffset: number)
        local num1 = if bool1 and GuiService then GuiService:GetGuiInset().Y + 20 else 60

        if bool2 then
            if bool3 then
                return {
                    positionX = 1,
                    positionXOffset = -20,
                    positionY = 0,
                    positionYOffset = positionYOffset,
                    anchorX = 1,
                    anchorY = 0
                }
            end

            return {
                positionX = 0.5,
                positionXOffset = 0,
                positionY = 0,
                positionYOffset = positionYOffset,
                anchorX = 0.5,
                anchorY = 0
            }
        end

        if bool3 then
            return {
                positionX = 1,
                positionXOffset = 20,
                positionY = 0,
                positionYOffset = positionYOffset,
                anchorX = 0,
                anchorY = 0
            }
        end

        return {
            positionX = 0.5,
            positionXOffset = 0,
            positionY = 0,
            positionYOffset = if bool1 then num1 * -1 else -50,
            anchorX = 0.5,
            anchorY = 1
        }
    end,
    getDeviceOrientation = function(vector2: Vector2)
        return if vector2.X > vector2.Y then type.DeviceOrientationEnum.Landscape else type.DeviceOrientationEnum.Portrait
    end,
    getNotificationSize = function(bool2: boolean, num1: number): UDim2
        if num1 < constants.FullWidthDeviceThreshold then
            return UDim2.new(0, num1 - 24, 0, 0)
        elseif bool2 then
            if num1 < constants.CompactCardThreashold then
                return UDim2.new(0, constants.InExperienceToastWidth, 0, 0)
            end
            return UDim2.new(0, constants.InAppToastWidth, 0, 0)
        else
            return UDim2.new(0, constants.InAppToastWidth, 0, 0)
        end
    end,
    marshalStreamNotificationData = function(arg1, _: number?)
        local tbl1 = {
            currentState = arg1.content.currentState,
            notificationType = arg1.content.notificationType,
            id = arg1.id
        }
        if arg1.content.states then
            local var1 = arg1.content.states[arg1.content.currentState]
            tbl1.state = {
                layoutKey = var1.layoutKey,
                name = var1.name,
                visualItems = var1.visualItems
            }
        end

        return tbl1
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
        local bool2

        if none == windows then
            bool2 = true
        else
            local osx = Enum.Platform.OSX

            if none == osx then
                bool2 = true
            else
                local uwp = Enum.Platform.UWP
                bool2 = none == uwp
            end
        end

        return bool2
    end,
    fireEvent = function(arg1, str1: string, str2: string, tbl1)
        local tbl2 = { streamContext = "InApp" }

        if str2 == nil or str2 == "" then
            str2 = constants.NotificationsClientEventNameDefault
        end

        arg1.sendEventDeferred(str1, str2, Cryo.Dictionary.join(tbl1, tbl2))
    end
}
