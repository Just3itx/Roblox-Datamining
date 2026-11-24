-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-24T02:21:19Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local CurrencyTransfers = script:FindFirstAncestor("CurrencyTransfers")
local CurrencyTransfersParent = CurrencyTransfers.Parent

local React = require(CurrencyTransfersParent.React)

local GetFFlagCurrencyTransferFlowUIImprovementFix = require(CurrencyTransfers.Flags.GetFFlagCurrencyTransferFlowUIImprovementFix)

local FFlagCurrencyTransferUseProfileFrameThumbnail = require(CurrencyTransfers.Flags.FFlagCurrencyTransferUseProfileFrameThumbnail)

local Foundation = require(CurrencyTransfersParent.Foundation)
local Image = Foundation.Image
local View = Foundation.View
local FoundationText = Foundation.Text
local useTokens = Foundation.Hooks.useTokens

local UserLib = require(CurrencyTransfersParent.UserLib)
local Constants = UserLib.Utils.Constants
local getRbxthumbWithTypeSizeAndOptions = UserLib.Utils.getRbxthumbWithTypeSizeAndOptions

local Size100x100 = Enum.ThumbnailSize.Size100x100

local function UserProfileThumbnail(tbl1)
    local var1 = useTokens()
    if not tbl1.thumbnailSize then
        tbl1.thumbnailSize = Size100x100
    end

    local num1 = if tbl1.thumbnailSize == Enum.ThumbnailSize.Size48x48 then 48 elseif tbl1.thumbnailSize == Enum.ThumbnailSize.Size60x60 then 60 else 150

    local image = getRbxthumbWithTypeSizeAndOptions(
        tbl1.userId,
        Constants.RbxthumbTypes.AvatarHeadShot,
        num1,
        true,
        nil,
        FFlagCurrencyTransferUseProfileFrameThumbnail
    )

    local var2 = tbl1.size or UDim2.fromOffset(80, 80)

    local createElement = React.createElement
    local var3 = View
    local tbl2 = {
        tag = "col gap-xlarge auto-xy align-x-center align-y-center",
        LayoutOrder = tbl1.layoutOrder
    }
    local tbl3 = {
        AvatarContainer = React.createElement(
            View,
            { tag = "aspect-1-1 position-center-center anchor-center-center", Size = var2 },
            {
                AvatarImage = React.createElement(Image, {
                    Image = image,
                    backgroundStyle = var1.Color.Shift.Shift_300,
                    tag = "size-full aspect-1-1 radius-circle align-x-center align-y-center"
                })
            }
        ),
        NameContainer = 0,
        HandleContainer = 0
    }
    local var4

    if tbl1.showUsername then
        if if GetFFlagCurrencyTransferFlowUIImprovementFix() then tbl1.username or tbl1.displayName else tbl1.username then
            local createElement2 = React.createElement
            local var5 = View
            local tbl4 = { tag = "col auto-y align-x-center" }

            local tbl5 = {
                Name = React.createElement(FoundationText, {
                    Text = if GetFFlagCurrencyTransferFlowUIImprovementFix() then tbl1.displayName or tbl1.username or "" else tbl1.username or "",
                    tag = "text-title-medium content-emphasis text-align-x-center"
                })
            }
            var4 = createElement2(var5, tbl4, tbl5)
        else
            var4 = nil
        end
    else
        var4 = nil
    end

    tbl3.NameContainer = var4
    local element

    if GetFFlagCurrencyTransferFlowUIImprovementFix() then
        if tbl1.displayName and tbl1.username then
            element = React.createElement(View, {
                tag = "col auto-y padding-bottom-medium",
                LayoutOrder = 3
            }, {
                Handle = React.createElement(FoundationText, { Text = "@" .. tbl1.username, tag = "text-label-medium content-emphasis" })
            })
        else
            element = nil
        end
    elseif tbl1.displayName then
        element = React.createElement(View, {
            tag = "col auto-y padding-bottom-medium",
            LayoutOrder = 3
        }, {
            Handle = React.createElement(FoundationText, { Text = "@" .. tbl1.displayName, tag = "text-label-medium content-emphasis" })
        })
    else
        element = nil
    end

    tbl3.HandleContainer = element
    return createElement(var3, tbl2, tbl3)
end

return UserProfileThumbnail
