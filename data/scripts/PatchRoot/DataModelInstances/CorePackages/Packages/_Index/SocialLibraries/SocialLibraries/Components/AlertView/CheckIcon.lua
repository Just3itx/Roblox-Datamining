-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T15:41:23Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local SocialLibraries = script:FindFirstAncestor("SocialLibraries")
local dependencies = require(SocialLibraries.dependencies)
local Roact = dependencies.Roact
local UIBlox = dependencies.UIBlox
local Images = require(script.Parent.Images)

local var1 = Roact.PureComponent:extend("CheckIcon")

var1.defaultProps = {
    checked = false,
    onActivated = function() end
}

function var1.render(arg1)
    local var2 = arg1.props.checked and Images.checkFill or Images.checkStroke
    return UIBlox.Style.withStyle(function(arg2)
        local createElement = Roact.createElement
        local tbl1 = {
            BackgroundTransparency = 1,
            BorderSizePixel = 0,
            Size = UDim2.new(0, 17, 0, 17)
        }
        local tbl2 = {
            Button = Roact.createElement("ImageButton", {
                AutoButtonColor = false,
                BackgroundTransparency = 1,
                BorderSizePixel = 0,
                Image = var2.Image,
                ImageRectOffset = var2.ImageRectOffset,
                ImageRectSize = var2.ImageRectSize,
                ImageColor3 = arg2.Theme.UIDefault.Color,
                ScaleType = Enum.ScaleType.Slice,
                Size = UDim2.new(1, 0, 1, 0),
                SliceCenter = var2.SliceCenter,
                [Roact.Event.MouseButton1Click] = arg1.props.onActivated
            })
        }
        return createElement("Frame", tbl1, tbl2)
    end)
end

return var1
