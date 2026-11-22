-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T22:40:38Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Squads = script:FindFirstAncestor("Squads")
local SquadsParent = Squads.Parent

local Cryo = require(SquadsParent.Cryo)

local dependencies = require(Squads.dependencies)

local Foundation = dependencies.Foundation
local React = dependencies.React

local useTokens = Foundation.Hooks.useTokens
local Image = Foundation.Image
local View = Foundation.View

function HorizontalFacepileGroup(tbl1)
    local var1 = useTokens()

    local tbl2 = {
        avatarSize = 0,
        images = {},
        layoutOrder = 1,
        imageBackgroundStyle = nil,
        imageBorderStyle = {
            Color = var1.Color.Extended.Green.Green_800.Color3,
            Transparency = var1.Color.Extended.Green.Green_800.Transparency
        }
    }

    local var2 = Cryo.Dictionary.union(tbl2, tbl1)

    local xOffset = React.useMemo(function()
        local imagesLen = #var2.images
        if imagesLen <= 0 then
            return 0
        end

        local avatarSize = var2.avatarSize
        for _ = 2, imagesLen do
            avatarSize += var2.avatarSize - 4
        end

        return avatarSize
    end, { #var2.images, var2.avatarSize })

    local var3 = React.useMemo(function()
        local imagesLen = #var2.images
        local result = {}
        for i, image in ipairs(var2.images) do
            local num1 = if i == 1 then 0 else 4

            local createElement = React.createElement
            local var3 = Image
            local tbl3 = {
                Image = image,
                backgroundStyle = if var2.imageBackgroundStyle then var2.imageBackgroundStyle else nil,
                Size = UDim2.fromOffset(var2.avatarSize, var2.avatarSize),
                Position = UDim2.new(0, var2.avatarSize * (i - 1) - num1 * (i - 1), 0.5, 0),
                tag = "anchor-center-left bg-surface-100 radius-circle",
                ZIndex = imagesLen - i + 1,
                testId = if var2.testId then `{var2.testId}--image-{i}` else nil
            }
            local tbl4 = {
                UIStroke = React.createElement("UIStroke", {
                    Color = if var2.imageBorderStyle then var2.imageBorderStyle.Color else var1.Color.Extended.Green.Green_800.Color3,
                    Transparency = if var2.imageBorderStyle then var2.imageBorderStyle.Transparency else var1.Color.Extended.Green.Green_800.Transparency,
                    Thickness = var1.Stroke.Thick
                })
            }
            table.insert(result, createElement(var3, tbl3, tbl4))
        end

        return result
    end, {
        var2.avatarSize,
        var2.images,
        var2.imageBackgroundStyle,
        var2.imageBorderStyle,
        var2.testId
    })
    return React.createElement(View, {
        Size = UDim2.fromOffset(xOffset, var2.avatarSize),
        BackgroundTransparency = 1,
        LayoutOrder = if var2.layoutOrder then var2.layoutOrder else nil,
        testId = var2.testId
    }, { var3 })
end

return HorizontalFacepileGroup
