-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T08:40:52Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local TweenService = game:GetService("TweenService")
local PageLoadConfig = require(script.Parent.PageLoadConfig)

local module = {}
module.__index = module

local function getRandomHighlightColor(): Color3
    local red = math.random() * 0.6 + 0.4
    local green = math.random() * 0.6 + 0.4
    local blue = math.random() * 0.6 + 0.4
    return Color3.new(red, green, blue)
end

function module.new()
    local tbl1 = {
        originalProperties = {}
    }

    setmetatable(tbl1, module)
    return tbl1
end

function module:highlightComponent(instance: Instance)
    if self.originalProperties[instance] or instance.BackgroundColor3 == PageLoadConfig.VISUAL_DEBUG.HIGHLIGHT_COLOR then
        return
    end

    local backgroundColor3 = instance.BackgroundColor3
    local backgroundTransparency = instance.BackgroundTransparency
    local borderColor3 = instance.BorderColor3
    local borderSizePixel = instance.BorderSizePixel

    self.originalProperties[instance] = {
        backgroundColor = backgroundColor3,
        backgroundTransparency = backgroundTransparency,
        borderColor = borderColor3,
        borderSize = borderSizePixel
    }

    instance.BackgroundColor3 = PageLoadConfig.VISUAL_DEBUG.HIGHLIGHT_COLOR or getRandomHighlightColor()
    if backgroundTransparency >= 0.95 then
        instance.BackgroundTransparency = 0.5
    else
        local var1 = backgroundTransparency - PageLoadConfig.VISUAL_DEBUG.TRANSPARENCY_REDUCTION
        instance.BackgroundTransparency = math.max(0.3, var1)
    end
    instance.BorderColor3 = PageLoadConfig.VISUAL_DEBUG.BORDER_COLOR
    local minBorderSize = PageLoadConfig.VISUAL_DEBUG.MIN_BORDER_SIZE
    instance.BorderSizePixel = math.max(minBorderSize, borderSizePixel)

    task.delay(PageLoadConfig.VISUAL_DEBUG.HIGHLIGHT_DURATION, function()
        if not instance.Parent or not self.originalProperties[instance] then
            return
        end

        local var1 = self.originalProperties[instance]

        local tweenInfo = TweenInfo.new(PageLoadConfig.VISUAL_DEBUG.FADE_DURATION, Enum.EasingStyle.Quart, Enum.EasingDirection.Out)

        local tween = TweenService:Create(instance, tweenInfo, {
            BackgroundColor3 = PageLoadConfig.VISUAL_DEBUG.END_COLOR,
            BackgroundTransparency = var1.backgroundTransparency * 0.9,
            BorderSizePixel = var1.borderSize
        })

        tween.Completed:Connect(function()
            self.originalProperties[instance] = nil
        end)

        tween:Play()
    end)
end

function module:clearAllHighlights()
    for value, value2 in self.originalProperties do
        if value.Parent then
            value.BackgroundColor3 = value2.backgroundColor
            value.BackgroundTransparency = value2.backgroundTransparency
            value.BorderColor3 = value2.borderColor
            value.BorderSizePixel = value2.borderSize
        end
    end
    self.originalProperties = {}
end

function module.destroy(arg1)
    arg1:clearAllHighlights()
end

return module
