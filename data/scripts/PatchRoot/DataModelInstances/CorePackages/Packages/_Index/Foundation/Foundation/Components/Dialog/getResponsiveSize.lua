-- [[ luacid.dev ]] v0.2.16 decompiled at 2026-11-20T04:21:24Z
-- Luau bytecode version: 14 | Luau type version: 3
--!optimize 1
local Foundation = script:FindFirstAncestor("Foundation")

local DialogSize = require(Foundation.Enums.DialogSize)

local _Tokens = require(Foundation.Providers.Style.Tokens)

local DIALOG_SIZES = require(script.Parent.useDialogVariants).DIALOG_SIZES

local function getResponsiveSize(num1: number, arg1, arg2)
    local var1 = ({
        [DialogSize.Small] = arg2.Padding.Large,
        [DialogSize.Medium] = arg2.Padding.XLarge,
        [DialogSize.Large] = arg2.Padding.XLarge
    })[arg1] * 2
    local scale = arg2.Config.UI.Scale

    if num1 <= DIALOG_SIZES[DialogSize.Medium] * scale + var1 and arg1 ~= DialogSize.Small then
        return DialogSize.Small
    end

    if num1 <= DIALOG_SIZES[DialogSize.Large] * scale + var1 and arg1 == DialogSize.Large then
        return DialogSize.Medium
    end

    return arg1
end

return getResponsiveSize
