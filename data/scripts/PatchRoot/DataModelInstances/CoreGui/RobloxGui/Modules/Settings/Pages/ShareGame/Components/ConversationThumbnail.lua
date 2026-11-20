-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T00:21:01Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CorePackages = game:GetService("CorePackages")
local Modules = game:GetService("CoreGui").RobloxGui.Modules
local Roact = require(CorePackages.Packages.Roact)
local Constants = require(Modules.Settings.Pages.ShareGame.Constants)
local Constants2 = require(CorePackages.Workspace.Packages.UserLib).Utils.Constants

local getRbxthumbWithTypeSizeAndOptions = require(CorePackages.Workspace.Packages.UserLib).Utils.getRbxthumbWithTypeSizeAndOptions

local GRAY3 = Constants.Color.GRAY3

local InviteAvatarThumbnailSize = Constants.InviteAvatarThumbnailSize

local tbl1 = {
    {{
        Size = UDim2.new(1, 0, 1, 0),
        Position = UDim2.new(0, 0, 0, 0),
        FrameSize = UDim2.new(1, 0, 1, 0),
        FramePosition = UDim2.new(0, 0, 0, 0)
    }},
    {
        {
            Size = UDim2.new(2, 0, 1, 0),
            Position = UDim2.new(-0.5, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 1, 0),
            FramePosition = UDim2.new(0, 0, 0, 0),
            Border = {
                BorderPosition = UDim2.new(0.5, -1, 0, 0),
                BorderSize = UDim2.new(0, 1, 1, 0)
            }
        },
        {
            Size = UDim2.new(2, 0, 1, 0),
            Position = UDim2.new(-0.5, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 1, 0),
            FramePosition = UDim2.new(0.5, 1, 0, 0)
        }
    },
    {
        {
            Size = UDim2.new(2, 0, 1, 0),
            Position = UDim2.new(-0.5, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 1, 0),
            FramePosition = UDim2.new(0, 0, 0, 0),
            Border = {
                BorderPosition = UDim2.new(0.5, -1, 0, 0),
                BorderSize = UDim2.new(0, 1, 1, 0)
            }
        },
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0.5, 1, 0, 0),
            Border = {
                BorderPosition = UDim2.new(0.5, 0, 0.5, -1),
                BorderSize = UDim2.new(0.5, 0, 0, 1)
            }
        },
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0.5, 1, 0.5, 1)
        }
    },
    {
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0, 0, 0, 0),
            Border = {
                BorderPosition = UDim2.new(0, 0, 0.5, -1),
                BorderSize = UDim2.new(1, 0, 0, 1)
            }
        },
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0.5, 1, 0, 0)
        },
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0, 0, 0.5, 1),
            Border = {
                BorderPosition = UDim2.new(0.5, -1, 0, 0),
                BorderSize = UDim2.new(0, 1, 1, 0)
            }
        },
        {
            Size = UDim2.new(1, 0, 1, 0),
            Position = UDim2.new(0, 0, 0, 0),
            FrameSize = UDim2.new(0.5, -1, 0.5, -1),
            FramePosition = UDim2.new(0.5, 1, 0.5, 1)
        }
    }
}

local var1 = Roact.PureComponent:extend("ConversationThumbnail")

function var1.render(arg1)
    local size = arg1.props.size
    local layoutOrder = arg1.props.layoutOrder
    local zIndex = arg1.props.zIndex
    local users = arg1.props.users
    local usersLen = #users

    local tbl2 = ({})
    for i, user in ipairs(users) do
        local var2 = tbl1[usersLen][i]
        local rbxthumbWithTypeSizeAndOptions

        if user then
            local var3 = Constants2.RbxThumbnailSizeToNumberSize[InviteAvatarThumbnailSize]
            rbxthumbWithTypeSizeAndOptions = getRbxthumbWithTypeSizeAndOptions(user.id, Constants.InviteAvatarRbxthumbType, var3)
        else
            rbxthumbWithTypeSizeAndOptions = nil
        end

        local var3 = "AvatarHolder-" .. i
        local createElement = Roact.createElement
        local tbl3 = {
            BackgroundTransparency = 1,
            ClipsDescendants = true,
            Size = var2.FrameSize,
            Position = var2.FramePosition,
            ZIndex = zIndex
        }
        local tbl4 = {
            Avatar = Roact.createElement("ImageLabel", {
                BackgroundTransparency = 1,
                Size = var2.Size,
                Position = var2.Position,
                Image = rbxthumbWithTypeSizeAndOptions or "rbxasset://textures/ui/LuaApp/graphic/ph-avatar-portrait.png",
                ZIndex = zIndex
            })
        }
        tbl2[var3] = createElement("Frame", tbl3, tbl4)

        if not var2.Border then
            continue
        end

        local var4 = "Border-" .. i
        tbl2[var4] = Roact.createElement("Frame", {
            Size = var2.Border.BorderSize,
            Position = var2.Border.BorderPosition,
            BorderSizePixel = 0,
            BackgroundColor3 = GRAY3,
            ZIndex = zIndex
        })
    end

    return Roact.createElement(
        "Frame",
        { BackgroundTransparency = 1, Size = size, LayoutOrder = layoutOrder, ZIndex = zIndex },
        {
            ContentsContainer = Roact.createElement("Frame", {
                BackgroundTransparency = 0,
                Size = UDim2.new(1, -1, 1, -1),
                AnchorPoint = Vector2.new(0.5, 0.5),
                Position = UDim2.new(0.5, 0, 0.5, 0),
                BackgroundColor3 = Constants.Color.WHITE,
                BorderColor3 = GRAY3,
                BorderSizePixel = 1,
                ZIndex = zIndex
            }, tbl2)
        }
    )
end

return var1
