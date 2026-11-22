-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-22T11:31:02Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local ProfileQRCode = script:FindFirstAncestor("ProfileQRCode")
local ProfileQRCodeParent = ProfileQRCode.Parent

local React = require(ProfileQRCodeParent.React)
local Localization = require(ProfileQRCodeParent.Localization)
local Foundation = require(ProfileQRCodeParent.Foundation)

local View = Foundation.View
local Snackbar = Foundation.Snackbar
local useTokens = Foundation.Hooks.useTokens

local TextKeys = require(ProfileQRCode.Common.TextKeys)
local useLocalization = Localization.Hooks.useLocalization
local useLocalUserInfo = require(ProfileQRCode.Utils.useLocalUserInfo)

local function FriendAcceptedSnackbar(tbl1)
    local var1 = useLocalUserInfo(tbl1.acceptedFriendUserId)
    local var2 = useTokens()
    local username = if var1 then var1.displayName or var1.username else nil
    local var4 = useLocalization({ nowTrusted = { TextKeys.NowTrusted, username = username }, friendAdded = TextKeys.QRFriendAdded })

    React.useEffect(function()
        local var5 = task.delay(5, function()
            if tbl1.onDismissed then
                tbl1.onDismissed()
            end
        end)
        return function()
            task.cancel(var5)
        end
    end, { tbl1.onDismissed, tbl1.acceptedFriendUserId })

    local createElement = React.createElement
    local var5 = View
    local tbl2 = { tag = "size-full", ZIndex = 101 }

    local tbl3 = {
        Message = React.createElement(Snackbar, {
            title = if tbl1.newFriendIsTrusted then var4.nowTrusted else var4.friendAdded,
            Position = UDim2.new(0.5, 0, 1, -var2.Size.Size_500),
            AnchorPoint = Vector2.new(0.5, 1)
        })
    }
    return createElement(var5, tbl2, tbl3)
end

return FriendAcceptedSnackbar
