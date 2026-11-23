-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-23T08:01:06Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local AppChat = script:FindFirstAncestor("AppChat")
local AppChatParent = AppChat.Parent

local _types = require(AppChat.types)
local SocialLibraries = require(AppChat.SocialLibraries)

local useStyle = require(AppChatParent.UIBlox).Core.Style.useStyle
local Cryo = require(AppChatParent.Cryo)
local React = require(AppChatParent.React)
local memo = React.memo

local ResponseIndicator = SocialLibraries.Components.ResponseIndicator
local RemoveUserDialog = require(script.Parent.RemoveUserDialog)

local tbl1 = {}

function RemoveUserDialogLayout(tbl2)
    local var1 = Cryo.Dictionary.join(tbl1, tbl2)
    local var2 = useStyle()

    return React.createElement("Frame", {
        Size = UDim2.new(1, 0, 1, 0),
        BackgroundTransparency = 1
    }, {
        RemoveUserDialog = var1.isModalVisible and React.createElement(RemoveUserDialog, var1),
        ResponseIndicator = var1.isLoading
            and React.createElement(
                ResponseIndicator,
                {
                    soakAreaColor3 = var2.Theme.Overlay.Color,
                    soakAreaTransparency = var2.Theme.Overlay.Transparency
                }
            )
    })
end
return memo(RemoveUserDialogLayout)
