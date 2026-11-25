-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T10:01:29Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local GuiService = game:GetService("GuiService")
local UserInputService = game:GetService("UserInputService")
local SduiCoreSystem = script:FindFirstAncestor("SduiCoreSystem")

local SduiCoreSystemParent = SduiCoreSystem.Parent
local ArgCheck = require(SduiCoreSystemParent.ArgCheck)
local GetDisplayStore = require(SduiCoreSystemParent.Display).GetDisplayStore

local _SduiBuilderTypes = require(SduiCoreSystem.SduiBuilderTypes)
local SduiConditionKey = require(SduiCoreSystem.ConditionalProps.SduiConditionalPropTypes).SduiConditionKey
local SduiErrors = require(SduiCoreSystem.SduiErrors)

local str1 = game:DefineFastString("SduiForcePerfLevel", "")

local str2 = game:DefineFastString("SduiForceImageQualityLevel", "")

local tbl1 = { low = 1, Low = 1, medium = 2, Medium = 2, high = 3, High = 3 }

local tbl2 = {
    [Enum.DeviceLevel.Low] = 1,
    [Enum.DeviceLevel.Medium] = 2,
    [Enum.DeviceLevel.High] = 3
}

local var1 = nil
local var2 = nil

local function getDevicePerformanceValue() -- Luacid: unused: defined but never referenced
    if var1 == nil then
        if str1 ~= "" then
            var1 = tbl1[str1] or 3
        else
            local deviceLevel = UserInputService:GetDeviceLevel()
            var1 = tbl2[deviceLevel] or 3
        end
    end
    return var1
end

local function getImageQualityValue()
    if str2 ~= "" then
        return tbl1[str2] or 3
    end

    if var1 == nil then
        if str1 ~= "" then
            var1 = tbl1[str1] or tbl1.High
        else
            local deviceLevel = UserInputService:GetDeviceLevel()
            var1 = tbl2[deviceLevel] or tbl1.High
        end
    end
    local var3 = var1

    if var3 == 1 then
        return 1
    elseif var3 == 2 then
        return 2
    elseif var3 == 3 then
        if var2 == nil then
            var2 = GuiService:GetResolutionScale()
        end
        return if var2 >= 2 then 3 else 2
    else
        ArgCheck.assert(true, `Unexpected performanceLevel {var3}`)
        return 3
    end
end

return {
    shouldIncludeKey = function(str3: string): boolean
        return str3 ~= "imageQualityLevel" and str3 ~= "performanceLevel"
    end,
    shouldFailConditionEarly = function(name: string, value, arg2): boolean
        if name ~= "performanceLevel" then
            if name ~= "imageQualityLevel" then
                return false
            end

            local imageQualityValue = getImageQualityValue()
            local var3 = tbl1[value]
            if var3 then
                return imageQualityValue ~= var3
            end

            arg2.dependencies.logger.reportError(
                SduiErrors.SduiErrorType.InvalidResponsiveCondition,
                { name = name, value = value },
                arg2.appPage
            )
            return false
        end

        if var1 == nil then
            if str1 ~= "" then
                var1 = tbl1[str1] or tbl1.High
            else
                local deviceLevel = UserInputService:GetDeviceLevel()
                var1 = tbl2[deviceLevel] or tbl1.High
            end
        end
        local var3 = var1

        local var4 = tbl1[value]
        if var4 then
            return var3 ~= var4
        end

        arg2.dependencies.logger.reportError(
            SduiErrors.SduiErrorType.InvalidResponsiveCondition,
            { name = name, value = value },
            arg2.appPage
        )
        return false
    end,
    PERF_KEY = "performanceLevel",
    IMAGE_QUALITY_KEY = "imageQualityLevel",
    setDeviceLevelValueForTests = function(num1: number?)
        var1 = num1
    end,
    setResolutionScaleForTests = function(num1: number?)
        var2 = num1
    end,
    adaptThumbnailDimensions = function(num1: number, num2: number, num3: number, num4: number, str3: string)
        local imageQualityValue = getImageQualityValue()
        if imageQualityValue == 3 then
            return num1, num2
        elseif imageQualityValue == 1 then
            return num3, num4
        end

        if imageQualityValue ~= 2 then
            ArgCheck.assert(true, `Unexpected imageQualityLevel {imageQualityValue}`)
        elseif num1 == 1320 and num2 == 440 then
            if num3 <= 660 and num4 <= 220 then
                return 660, 220
            end
        elseif num1 == 384 and num2 == 216 then
            if (str3 == "GameThumbnail" or str3 == "Asset") and num3 <= 256 and num4 <= 144 then
                return 256, 144
            end
        elseif num1 == 768 and num2 == 432 or num1 == 576 and num2 == 324 then
            if (str3 == "GameThumbnail" or str3 == "Asset") and num3 <= 384 and num4 <= 216 then
                return 384, 216
            end
        elseif num1 == 512 and num2 == 512 then
            if str3 == "GameIcon" and num3 <= 256 and num4 <= 256 then
                return 256, 256
            end
        elseif num1 == 700 and num2 == 700 and str3 == "Asset" and num3 <= 420 and num4 <= 420 then
            return 420, 420
        end

        return num1, num2
    end,
    checkResponsiveConditions = function(tbl3, vector2: Vector2, str3: string, str4: string, bool1: boolean, arg1)
        local result = ({})
        if not tbl3 then
            return result
        end
        assert(tbl3, "allConditionalProps must exist")
        for value, value2 in tbl3 do
            local var3 = nil
            if value2.conditions then
                for name, condition in value2.conditions do
                    if name == SduiConditionKey.minScreenWidth then
                        if vector2.X < condition then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.maxScreenWidth then
                        if condition < vector2.X then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.isPortrait then
                        if condition and vector2.X > vector2.Y or not condition and vector2.X < vector2.Y then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.lastInput then
                        if condition ~= str3 then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.preferredInput then
                        if condition ~= str4 then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.isSpatial then
                        if not bool1 and condition or bool1 and not condition then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.imageQualityLevel then
                        local imageQualityValue = getImageQualityValue()
                        local var4 = tbl1[condition]
                        if not var4 then
                            arg1.dependencies.logger.reportError(
                                SduiErrors.SduiErrorType.InvalidResponsiveCondition,
                                { name = name, value = condition },
                                arg1.appPage
                            )
                            var3 = true
                            break
                        end

                        if imageQualityValue ~= var4 then
                            var3 = true
                            break
                        end
                    elseif name == SduiConditionKey.performanceLevel then
                        if var1 == nil then
                            if str1 ~= "" then
                                var1 = tbl1[str1] or tbl1.High
                            else
                                local deviceLevel = UserInputService:GetDeviceLevel()
                                var1 = tbl2[deviceLevel] or tbl1.High
                            end
                        end
                        local var4 = var1

                        local var5 = tbl1[condition]
                        if not var5 then
                            arg1.dependencies.logger.reportError(
                                SduiErrors.SduiErrorType.InvalidResponsiveCondition,
                                { name = name, value = condition },
                                arg1.appPage
                            )
                            var3 = true
                            break
                        end

                        if var4 ~= var5 then
                            var3 = true
                            break
                        end
                    end
                end
            end

            result[value] = var3
        end
        return result
    end,
    isPortraitOrientation = function(): boolean
        local var3 = GetDisplayStore(false).getViewportSize(false)
        return var3.X < var3.Y
    end
}
