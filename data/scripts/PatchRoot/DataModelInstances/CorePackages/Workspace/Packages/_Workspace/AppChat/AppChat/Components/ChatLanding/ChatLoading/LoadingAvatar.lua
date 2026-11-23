-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:31Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChatParent = script:FindFirstAncestor("AppChat").Parent

local Roact = require(AppChatParent.Roact)
local withStyle = require(AppChatParent.UIBlox).Style.withStyle

local UIBlox = require(AppChatParent.UIBlox)
local Foundation = require(AppChatParent.Foundation)
local Radius = Foundation.Enums.Radius
local Skeleton = Foundation.Skeleton

local ImageSetLabel = UIBlox.Core.ImageSet.ImageSetLabel
local Images = UIBlox.App.ImageSet.Images

local var1 = Roact.PureComponent:extend("LoadingAvatar")
local bool1 = game:DefineFastFlag("AppChatLoadingIndicatorTransparency", false)

var1.defaultProps = {
    avatarImage = Images["component_assets/circle_49_mask"],
    cellHeight = 64,
    avatarSize = 36,
    LayoutOrder = 0
}

function var1.render(arg1)
    local var2 = arg1.props.cellHeight / 2 - arg1.props.avatarSize / 2

    return withStyle(function(arg2)
        local createElement = Roact.createElement
        local str1 = "Frame"
        local tbl1 = {
            Size = UDim2.new(0, arg1.props.cellHeight, 0, arg1.props.cellHeight),
            BackgroundTransparency = 1,
            LayoutOrder = arg1.props.LayoutOrder,
            BorderSizePixel = 0
        }
        local tbl2 = {
            avatarShimmer = Roact.createElement(Skeleton, {
                Size = UDim2.fromOffset(arg1.props.avatarSize, arg1.props.avatarSize),
                Position = UDim2.fromOffset(var2, var2),
                radius = Radius.Circle
            }),
            avatarMask = 0
        }
        local element

        if bool1 then
            element = nil
        else
            element = Roact.createElement(ImageSetLabel, {
                Size = UDim2.fromOffset(arg1.props.avatarSize, arg1.props.avatarSize),
                Position = UDim2.fromOffset(var2, var2),
                Image = arg1.props.avatarImage,
                BackgroundTransparency = 1,
                ImageColor3 = arg2.Theme.BackgroundDefault.Color
            })
        end

        tbl2.avatarMask = element
        return createElement(str1, tbl1, tbl2)
    end)
end

return var1
