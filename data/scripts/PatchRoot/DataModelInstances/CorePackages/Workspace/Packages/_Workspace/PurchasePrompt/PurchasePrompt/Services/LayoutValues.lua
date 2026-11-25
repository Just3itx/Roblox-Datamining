-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-25T07:31:28Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local scriptParentParent = script.Parent.Parent

local createSignal = require(scriptParentParent.Misc.createSignal)
local strict = require(scriptParentParent.strict)

local function makeImageData(arg1, sliceCenter) -- Luacid: unused: defined but never referenced
    return {
        Path = "rbxasset://textures/" .. arg1,
        SliceCenter = sliceCenter
    }
end

local module = {}
function module.__tostring(): string
    return "Service(LayoutValues)"
end

function module.new(arg1)
    local result = {}
    setmetatable(result, { __index = module })

    result.signal = createSignal()
    result.layout = result:generate(arg1)

    return result
end

function module:update(arg1)
    self.layout = self:generate(arg1)
    self.signal:fire(self.layout)
end

function module:generate(arg1)
    local num1 = if arg1 then 3 else 1

    local buttonHeight = 44 * num1
    local yOffset = 30 * num1

    local num3 = 6 * num1

    local num4 = 16 * num1

    local productDescriptionPaddingTop = 18 * num1
    local xOffset = 210 * num1
    local yOffset2 = 106 * num1

    local xOffset2 = 96 * num1
    local yOffset3 = 20 * num1

    local horizontalPadding = 25 * num1
    local num7 = 2 * num1
    local xOffset3 = 64 * num1
    local yOffset4 = 64 * num1

    local buttonIconPadding = 3 * num1

    local buttonIconYOffset = 2 * num1

    local xOffset4 = xOffset3 + 2 * num7
    local yOffset5 = yOffset4 + 2 * num7

    local xOffset5 = xOffset4 + 2 * horizontalPadding
    local yOffset6 = yOffset5 + 2 * horizontalPadding

    local tbl1 = {
        AdditionalDetailsLabel = UDim2.new(1, 0, 0, yOffset),
        ItemPreview = UDim2.new(0, xOffset3, 0, yOffset4),
        ItemPreviewWhiteFrame = UDim2.new(0, xOffset4, 0, yOffset5),
        ItemPreviewContainerFrame = UDim2.new(0, xOffset5, 0, yOffset6),
        HorizontalPadding = horizontalPadding,
        ProductDescription = UDim2.new(0, xOffset, 0, yOffset2),
        ProductDescriptionPaddingTop = productDescriptionPaddingTop,
        RobuxIconContainerFrame = UDim2.new(0, num4 + num3, 0, num4 + 2 * num3),
        RobuxIcon = UDim2.new(0, num4, 0, num4),
        PriceTextLabel = UDim2.new(0, xOffset - (num4 + num3), 0, num4),
        PurchasingAnimation = UDim2.new(0, xOffset2, 0, yOffset3),
        ButtonIconPadding = buttonIconPadding,
        ButtonIconYOffset = buttonIconYOffset,
        ButtonHeight = buttonHeight,
        Dialog = UDim2.new(0, xOffset5 + xOffset, 0, math.max(yOffset6, yOffset2) + yOffset + buttonHeight)
    }

    local tbl2 = {
        Default = 18 * num1,
        ProductDescription = 18 * num1,
        Button = 24 * num1,
        AdditionalDetails = 14 * num1,
        Purchasing = 36 * num1
    }

    local tbl3 = {
        PriceLabel = Color3.new(1, 1, 1)
    }
    local tbl4 = {
        PromptBackground = arg1
            and {
                Path = "rbxasset://textures/ui/PurchasePrompt/PurchasePromptBG@2x.png",
                SliceCenter = Rect.new(17, 17, 19, 19)
            }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/PurchasePromptBG.png",
                SliceCenter = Rect.new(8, 9, 10, 10)
            },
        InProgressBackground = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/LoadingBG@2x.png",
            SliceCenter = Rect.new(17, 17, 19, 19)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/LoadingBG.png",
                SliceCenter = Rect.new(9, 9, 11, 11)
            },
        ButtonUpLeft = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/LeftButton@2x.png",
            SliceCenter = Rect.new(18, 5, 20, 7)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/LeftButton.png",
                SliceCenter = Rect.new(8, 3, 10, 4)
            },
        ButtonDownLeft = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/LeftButtonDown@2x.png",
            SliceCenter = Rect.new(18, 5, 20, 7)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/LeftButtonDown.png",
                SliceCenter = Rect.new(8, 3, 10, 4)
            },
        ButtonUpRight = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/RightButton@2x.png",
            SliceCenter = Rect.new(3, 5, 5, 7)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/RightButton.png",
                SliceCenter = Rect.new(2, 3, 3, 4)
            },
        ButtonDownRight = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/RightButtonDown@2x.png",
            SliceCenter = Rect.new(3, 5, 5, 7)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/RightButtonDown.png",
                SliceCenter = Rect.new(2, 3, 3, 4)
            },
        ButtonUp = arg1 and {
            Path = "rbxasset://textures/ui/PurchasePrompt/SingleButton@2x.png",
            SliceCenter = Rect.new(18, 5, 20, 7)
        }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/SingleButton.png",
                SliceCenter = Rect.new(8, 3, 10, 4)
            },
        ButtonDown = arg1
            and {
                Path = "rbxasset://textures/ui/PurchasePrompt/SingleButtonDown@2x.png",
                SliceCenter = Rect.new(18, 5, 20, 7)
            }
            or {
                Path = "rbxasset://textures/ui/PurchasePrompt/SingleButtonDown.png",
                SliceCenter = Rect.new(8, 3, 10, 4)
            },
        PremiumIcon = {
            Path = "rbxasset://textures/ui/PurchasePrompt/Premium.png",
            SliceCenter = nil
        },
        RobuxIcon = arg1 and {
            Path = "rbxasset://textures/ui/common/robux_small@2x.png",
            SliceCenter = nil
        }
            or { Path = "rbxasset://textures/ui/common/robux_small.png", SliceCenter = nil },
        ErrorIcon = arg1 and { Path = "rbxasset://textures/ui/ErrorIcon.png", SliceCenter = nil }
            or { Path = "rbxasset://textures/ui/ErrorIcon.png", SliceCenter = nil },
        ButtonA = arg1 and {
            Path = "rbxasset://textures/ui/Settings/Help/AButtonDark@2x.png",
            SliceCenter = nil
        }
            or { Path = "rbxasset://textures/ui/Settings/Help/AButtonDark.png", SliceCenter = nil },
        ButtonB = arg1 and {
            Path = "rbxasset://textures/ui/Settings/Help/BButtonDark@2x.png",
            SliceCenter = nil
        }
            or { Path = "rbxasset://textures/ui/Settings/Help/BButtonDark.png", SliceCenter = nil }
    }

    return (strict({
        Size = strict(tbl1, "LayoutValues.Size"),
        TextSize = strict(tbl2, "LayoutValues.TextSize"),
        TextColor = strict(tbl3, "LayoutValues.TextColor"),
        Image = strict(tbl4, "LayoutValues.Image")
    }, "LayoutValues"))
end

return module
