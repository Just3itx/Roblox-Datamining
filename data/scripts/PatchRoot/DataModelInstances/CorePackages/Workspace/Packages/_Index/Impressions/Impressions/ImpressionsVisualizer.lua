-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T02:00:48Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CollectionService = game:GetService("CollectionService")
local RunService = game:GetService("RunService")
local ImpressionsParent = script:FindFirstAncestor("Impressions").Parent

local Cryo = require(ImpressionsParent.Cryo)
local Constants = require(script.Parent.Constants)

local bool1 = game:DefineFastFlag("DebugEnableImpressionsVisualizer", false)

local tbl1 = {
    Color3.new(0.941176, 0.941176, 0.015686),
    Color3.new(0.890196, 0.058823, 0.058823),
    Color3.new(0.031372, 0.870588, 0.031372),
    Color3.new(0.866666, 0.039215, 0.647058),
    Color3.new(0.035294, 0.631372, 0.866666),
    Color3.new(0.882352, 0.556862, 0.035294),
    Color3.new(0.729411, 0.043137, 0.835294)
}

local num1 = 1

local tbl2 = {
    BackgroundColor3 = Color3.new(1, 1, 1),
    BorderColor3 = Color3.new(1, 1, 1),
    BackgroundTransparency = 0,
    BorderMode = Enum.BorderMode.Outline,
    BorderSizePixel = 15,
    ZIndex = 100
}

local tbl3 = { BackgroundTransparency = 0.65, BorderSizePixel = 8 }

local module = {}
module.__index = module

local function getTaggedInstances(tag: string)
    local taggedInstances = ({})
    local tagged = CollectionService:GetTagged(tag)
    for _, value in ipairs(tagged) do
        local var1 = value:GetAttribute(Constants.ItemIndex)
        if var1 and value:IsA("GuiObject") then
            taggedInstances[var1] = value
        end
    end

    return taggedInstances
end

function module.new(impressionsTag, customKeyMapper)
    local tbl4 = {
        impressionsTag = impressionsTag,
        highlightedInstances = {},
        originalInstances = {},
        highlightColor = tbl1[num1],
        customKeyMapper = customKeyMapper or function<T>(arg1: T): T
            return arg1
        end
    }
    setmetatable(tbl4, module)

    if bool1 then
        num1 += 1
        if num1 > #tbl1 then
            num1 %= #tbl1
        end

        if impressionsTag then
            local connection = nil
            connection = RunService.RenderStepped:Connect(function(deltaTime: number)
                if tbl4 then
                    tbl4:_step(deltaTime)
                elseif connection then
                    connection:Disconnect()
                end
            end)

            tbl4.renderConnection = connection
        end
    end

    return tbl4
end

function module:destroy()
    if self.renderConnection then
        self.renderConnection:Disconnect()
    end
end

function module:_startHighlightState(arg1, highlightState, arg2, arg3, doLerp)
    local var1 = self.highlightedInstances[arg1]
    if var1 == nil then
        self.highlightedInstances[arg1] = {
            highlightState = highlightState,
            currentFields = {}
        }
        var1 = self.highlightedInstances[arg1]
    else
        var1.highlightState = highlightState
    end

    var1.totalDuration = arg2
    var1.duration = arg2
    var1.doLerp = doLerp
    if doLerp then
        local startFields = ({})
        local targetFields = ({})
        for k, value in pairs(arg3) do
            startFields[k] = var1.currentFields[k]
            targetFields[k] = value
        end
        var1.startFields = startFields
        var1.targetFields = targetFields
    else
        var1.startFields = nil
        var1.targetFields = nil
        for k, value in pairs(arg3) do
            var1.currentFields[k] = value
        end
    end

    self.highlightedInstances[arg1] = var1
end

function module:_step(arg1)
    assert(self.impressionsTag, "impressionsTag is nil")

    for k, value in pairs(self.highlightedInstances) do
        if value.doLerp and value.duration ~= nil and value.totalDuration ~= nil then
            assert(value.startFields, "startFields is nil")
            assert(value.targetFields, "targetFields is nil")
            if value.duration <= 0 then
                value.doLerp = nil
                value.duration = nil
                for k2, targetField in pairs(value.targetFields) do
                    value.currentFields[k2] = targetField
                end
            else
                local num2 = math.clamp((value.totalDuration - value.duration) / value.totalDuration, 0, 1)
                for k2, targetField in pairs(value.targetFields) do
                    local startField = value.startFields[k2]
                    local var1 = startField + (targetField - startField) * num2

                    value.currentFields[k2] = var1
                end
            end
        end

        if value.highlightState == "Highlight" then
            assert(value.duration ~= nil, "duration is nil")
            if value.duration <= 0 then
                self:_startHighlightState(k, "FadeOut", 2.5, tbl3, true)
            end
        end

        if value.duration then
            value.duration -= arg1
        end
    end

    local taggedInstances = getTaggedInstances(self.impressionsTag)
    for k, value in pairs(taggedInstances) do
        if value == nil then
            continue
        end

        if self.originalInstances[value] == nil then
            self.originalInstances[value] = {}
            for k2, _ in pairs(tbl2) do
                self.originalInstances[value][k2] = value[k2]
            end
        end

        local var1 = self.customKeyMapper(k)
        local tbl4 = self.highlightedInstances[var1]
        if tbl4 == nil then
            tbl4 = {
                highlightState = "None",
                currentFields = {}
            }

            assert(self.originalInstances[value], "self.originalInstances[instance] is nil")
            for k2, value2 in pairs(self.originalInstances[value]) do
                tbl4.currentFields[k2] = value2
            end

            self.highlightedInstances[var1] = tbl4
        end

        assert(tbl4 ~= nil, "stateData is nil")
        if not tbl4.currentFields then
            continue
        end

        for k2, currentField in pairs(tbl4.currentFields) do
            value[k2] = currentField
        end
    end
end

function module:_highlightImpression(arg1)
    if self.highlightedInstances[arg1] ~= nil and self.highlightedInstances[arg1].highlightState ~= "None" then
        return
    end

    self:_startHighlightState(
        arg1,
        "Highlight",
        1,
        Cryo.Dictionary.join(tbl2, { BackgroundColor3 = self.highlightColor, BorderColor3 = self.highlightColor }),
        false
    )
end

function module:_clearImpression(arg1)
    self.highlightedInstances[arg1] = nil
end

function module:onSendImpressions(arg1)
    if not bool1 or not self.impressionsTag or arg1 == nil or #arg1 <= 0 then
        return
    end

    for _, value in ipairs(arg1) do
        self:_highlightImpression((self.customKeyMapper(value)))
    end
end

function module:onClearImpressions(arg1)
    if not bool1 or not self.impressionsTag or arg1 == nil or #arg1 <= 0 then
        return
    end

    for _, value in ipairs(arg1) do
        self:_clearImpression((self.customKeyMapper(value)))
    end
end

function module:onClearAllImpressions()
    if not bool1 or not self.impressionsTag then
        return
    end

    for k, value in pairs(self.originalInstances) do
        for k2, value2 in pairs(value) do
            k[k2] = value2
        end
    end

    self.highlightedInstances = {}
    self.originalInstances = {}
end

function module:setCustomKeyMapper(customKeyMapper)
    self.customKeyMapper = customKeyMapper or function<T>(arg1: T): T
        return arg1
    end
end

function module:setImpressionsTag(impressionsTag)
    self.impressionsTag = impressionsTag
end

return module
